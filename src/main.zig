const std = @import("std");
const quickjs = @import("quickjs/quickjs.zig");

pub extern fn main() void;

test "main" {
    var rt = quickjs.Runtime.NewRuntime();
    defer rt.Free();
    var ctx = quickjs.Context.NewContextRaw(rt);
    defer ctx.Free();
    ctx.AddIntrinsicBaseObjects();
    ctx.AddIntrinsicDate();
    ctx.AddIntrinsicEval();
    ctx.AddIntrinsicStringNormalize();
    ctx.AddIntrinsicRegExp();
    ctx.AddIntrinsicJSON();
    ctx.AddIntrinsicProxy();
    ctx.AddIntrinsicMapSet();
    ctx.AddIntrinsicTypedArrays();
    ctx.AddIntrinsicPromise();
    ctx.AddIntrinsicBigInt();
    ctx.AddIntrinsicBigFloat();
    ctx.AddIntrinsicBigDecimal();
    ctx.AddIntrinsicOperators();
    ctx.EnableBignumExt(true);
    std.testing.log_level = .debug;
}
