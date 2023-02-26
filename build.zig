const std = @import("std");

pub fn build(b: *std.build.Builder) !void {
    // _ = try b.addUserInputOption("target","aarch64-linux-musl");
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    // const mode = b.standardReleaseOptions();
    const mode = .ReleaseSmall;

    const exe = b.addExecutable("qjsc", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    const cfiles = &[_][]const u8{
        "quickjs.c",
        "libregexp.c",
        "libunicode.c",
        "cutils.c",
        "quickjs-libc.c",
        "libbf.c",
        "qjsc.c"
    };
    const cflags = &[_][]const u8{
        "-DCONFIG_BIGNUM",
        "-D_GNU_SOURCE",
        "-DCONFIG_VERSION=\"2021-03-27\"",
        "-lm","-ldl","-lpthread","-flto",
    };
    exe.addCSourceFiles(cfiles,cflags);

    exe.install();
    exe.linkLibC();


    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}
