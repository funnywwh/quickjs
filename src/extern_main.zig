const std = @import("std");
const quickjs = @import("quickjs/quickjs.zig");

pub extern fn main() void;


test "main" {
    std.testing.log_level = .debug;
    std.debug.print("main test\n",.{});
}

test "quickjs test"{    
    std.testing.log_level = .debug;
    var rt = try quickjs.Runtime.NewRuntime();
    defer rt.Free();
    quickjs.Context.std_set_worker_new_context_func();
    rt.std_init_handlers();
    rt.SetModuleLoaderFunc();

    var ctx = try quickjs.Context.NewContext(rt);
    defer ctx.Free();

    var val = ctx.NewBool(true);    
    defer val.Free();
    var dupVal = val.Dup();
    defer dupVal.Free();
    var u32v = ctx.NewInt32(10);
    defer u32v.Free();


    std.debug.assert(u32v.IsException() == false);
    ctx.std_add_helpers(std.os.argv);
        
    var evalVal = ctx.EvalString("print(\"Hello World\");","test.js",quickjs.EvalType.GLOBAL);
    defer evalVal.Free();
    std.debug.print("quickjs test ok\n",.{});

    var evelFileRet = try ctx.EvalFile("examples/hello.js",quickjs.EvalType.GLOBAL);
    defer evelFileRet.Free();
    ctx.std_loop();
}