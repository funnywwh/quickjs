const std = @import("std");
const quickjs = @import("quickjs/quickjs.zig");

pub extern fn main() void;

test "main" {
    var rt = try quickjs.Runtime.NewRuntime();
    defer rt.Free();
    var ctx = try quickjs.Context.NewContext(rt);
    defer ctx.Free();
    ctx.std_set_worker_new_context_func();
    rt.std_init_handlers();
    std.testing.log_level = .debug;
}
