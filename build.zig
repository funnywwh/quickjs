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


    const qjslib_files = &[_][]const u8{
        "quickjs.c",
        "libregexp.c",
        "libunicode.c",
        "cutils.c",
        "quickjs-libc.c",
        "libbf.c",
    };
    const cflags = &[_][]const u8{
        "-DCONFIG_BIGNUM",
        "-D_GNU_SOURCE",
        "-DCONFIG_VERSION=\"2021-03-27\"",
    };

    const qjslib = b.addStaticLibrary("quickjs","src/main.zig");
    qjslib.setTarget(target);
    qjslib.setBuildMode(mode);
    qjslib.addCSourceFiles(qjslib_files, cflags);
    qjslib.install();
    qjslib.linkLibC();

    const qjsc = b.addExecutable("qjsc", "src/main.zig");
    qjsc.setTarget(target);
    qjsc.setBuildMode(mode);
    
    qjsc.addCSourceFiles(&[_][]const u8{
        "qjsc.c",
    }, cflags);
    qjsc.install();
    qjsc.linkLibC();
    qjsc.linkLibrary(qjslib);

    const qjsc_run_cmd = qjsc.run();
    qjsc_run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        qjsc_run_cmd.addArgs(args);
    }
    const run_step = b.step("qjsc", "Run the app");
    run_step.dependOn(&qjsc_run_cmd.step);

    const qjs = b.addExecutable("qjs", "src/main.zig");
    qjs.setTarget(target);
    qjs.setBuildMode(mode);

    qjs.linkLibrary(qjslib);
    qjs.addCSourceFiles(&[_][]const u8{
        "qjs.c",
        "qjscalc.c",
        "repl.c",
    }, cflags);

    qjs.install();
    qjs.linkLibC();

    const qjs_run_cmd = qjs.run();
    qjs_run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        qjs_run_cmd.addArgs(args);
    }
    
    const qjs_run_step = b.step("qjs", "Run qjs");
    qjs_run_step.dependOn(&qjs_run_cmd.step);

    var qjscalcStep = b.step("qjscalc","build qjscalc.c");

    const qjscalcCmdStep = b.addSystemCommand(&[_][]const u8{
        "./zig-out/bin/qjsc", "-fbignum", "-c", "-o", "qjscalc.c", "qjscalc.js",
    });
    qjscalcStep.dependOn(&qjscalcCmdStep.step);
    qjs.step.dependOn(qjscalcStep);
    


    var replStep = b.step("repl","build repl.c");

    const replCmdStep = b.addSystemCommand(&[_][]const u8{
        "./zig-out/bin/qjsc", "-c", "-o", "repl.c","-m" ,"repl.js",
    });
    replStep.dependOn(&replCmdStep.step);
    qjs.step.dependOn(replStep);

    
    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}

const QjscToCStep = struct {};
