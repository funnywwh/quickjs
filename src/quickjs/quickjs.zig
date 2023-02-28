const std = @import("std");
const quickjs = @cImport(@cInclude("quickjs-libc.h"));
pub const Runtime = struct {
    rt: ?*quickjs.JSRuntime,
    pub fn NewRuntime() !Runtime {
        var obj = Runtime{
            .rt = quickjs.JS_NewRuntime(),
        };
        if (obj.rt == null) {
            return error.RtNullPtr;
        }
        return obj;
    }
    pub fn Free(self: *Runtime) void {
        std.debug.assert(self.rt != null);
        quickjs.JS_FreeRuntime(self.rt.?);
        self.rt = null;
    }

    pub fn std_init_handlers(self: *Runtime) void {
        std.debug.assert(self.rt != null);
        quickjs.js_std_init_handlers(self.rt.?);
    }
    pub inline fn SetModuleLoaderFunc(self: *Runtime) void {
        std.debug.assert(self.rt != null);
        quickjs.JS_SetModuleLoaderFunc(self.rt.?, null, quickjs.js_module_loader, null);
    }
};

pub const EvalFlag = struct{
    pub const STRICT = quickjs.JS_EVAL_FLAG_STRICT;
    pub const STRIP = quickjs.JS_EVAL_FLAG_STRIP;
    pub const COMPILE_ONLY = quickjs.JS_EVAL_FLAG_COMPILE_ONLY;
    pub const BACKTRACE_BARRIER = quickjs.JS_EVAL_FLAG_BACKTRACE_BARRIER;
};

pub const EvalType = struct{
    pub const GLOBAL = quickjs.JS_EVAL_TYPE_GLOBAL;
    pub const MODULE = quickjs.JS_EVAL_TYPE_MODULE;
    pub const DIRECT = quickjs.JS_EVAL_TYPE_DIRECT;
    pub const INDIRECT = quickjs.JS_EVAL_TYPE_INDIRECT;
    pub const MASK = quickjs.JS_EVAL_TYPE_MASK;
};
pub const Context = struct {
    ctx: ?*quickjs.JSContext,
    pub fn NewContext(rt: Runtime) !Context {
        var obj = Context{
            .ctx = new_ctx(rt.rt.?),
        };
        if (obj.ctx == null) {
            return error.CtxNullPtr;
        }

        return obj;
    }

    pub fn Free(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_FreeContext(self.ctx.?);
        self.ctx = null;
    }
    pub inline fn AddIntrinsicBaseObjects(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBaseObjects(self.ctx.?);
    }
    pub inline fn AddIntrinsicDate(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicDate(self.ctx.?);
    }
    pub inline fn AddIntrinsicEval(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicEval(self.ctx.?);
    }
    pub inline fn AddIntrinsicStringNormalize(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicStringNormalize(self.ctx.?);
    }
    pub inline fn AddIntrinsicRegExp(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicRegExp(self.ctx.?);
    }
    pub inline fn AddIntrinsicJSON(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicJSON(self.ctx.?);
    }
    pub inline fn AddIntrinsicProxy(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicProxy(self.ctx.?);
    }
    pub inline fn AddIntrinsicMapSet(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicMapSet(self.ctx.?);
    }
    pub inline fn AddIntrinsicTypedArrays(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicTypedArrays(self.ctx.?);
    }
    pub inline fn AddIntrinsicPromise(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicPromise(self.ctx.?);
    }
    pub inline fn AddIntrinsicBigInt(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBigInt(self.ctx.?);
    }
    pub inline fn AddIntrinsicBigFloat(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBigFloat(self.ctx.?);
    }
    pub inline fn AddIntrinsicBigDecimal(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBigDecimal(self.ctx.?);
    }
    pub inline fn AddIntrinsicOperators(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicOperators(self.ctx.?);
    }
    pub inline fn EnableBignumExt(self: *Context, enable: bool) void {
        std.debug.assert(self.ctx != null);
        if (enable) {
            quickjs.JS_EnableBignumExt(self.ctx.?, 1);
        } else {
            quickjs.JS_EnableBignumExt(self.ctx.?, 0);
        }
    }
    fn new_ctx(rt: ?*quickjs.JSRuntime) callconv(.C) ?*quickjs.JSContext {
        var ctx: ?*quickjs.JSContext = quickjs.JS_NewContextRaw(rt);
        if (ctx == null) {
            return ctx.?;
        }
        var obj = Context{
            .ctx = ctx,
        };
        obj.AddIntrinsicBaseObjects();
        obj.AddIntrinsicDate();
        obj.AddIntrinsicEval();
        obj.AddIntrinsicStringNormalize();
        obj.AddIntrinsicRegExp();
        obj.AddIntrinsicJSON();
        obj.AddIntrinsicProxy();
        obj.AddIntrinsicMapSet();
        obj.AddIntrinsicTypedArrays();
        obj.AddIntrinsicPromise();
        obj.AddIntrinsicBigInt();
        obj.AddIntrinsicBigFloat();
        obj.AddIntrinsicBigDecimal();
        obj.AddIntrinsicOperators();
        obj.EnableBignumExt(true);
        return ctx.?;
    }

    pub fn std_set_worker_new_context_func() void {
        quickjs.js_std_set_worker_new_context_func(Context.new_ctx);
    }
    pub fn std_add_helpers(self: *Context, argv: [][*:0]const u8) void {
        std.debug.assert(self.ctx != null);
        quickjs.js_std_add_helpers(self.ctx.?, @intCast(c_int, argv.len), @ptrCast([*c][*c]u8, argv.ptr));
    }
    pub fn std_eval_binary(self: *Context, buf: []u8, loadOnly: bool) void {
        std.debug.assert(self.ctx != null);
        if (loadOnly) {
            quickjs.js_std_eval_binary(self.ctx.?, @ptrCast([*c]u8, buf.ptr), buf.len, 1);
        } else {
            quickjs.js_std_eval_binary(self.ctx.?, @ptrCast([*c]u8, buf.ptr), buf.len, 0);
        }
    }
    pub inline fn EvalString(self: *Context, buf:[]const u8,filename:[]const u8,flag:i32)Value{
        std.debug.assert(self.ctx != null);
        var retVal = quickjs.JS_Eval(self.ctx,buf.ptr,buf.len,filename.ptr,flag);
        return Value{
            .ctx = self,
            .val = retVal,
        };
    }
    pub inline fn std_loop(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.js_std_loop(self.ctx.?);
    }

    pub inline fn NewBool(self: *Context,val:bool)Value{
        std.debug.assert(self.ctx != null);
        
        var jsv = quickjs.JS_NewBool(self.ctx.?,@boolToInt(val));
        return Value{
            .ctx = self,
            .val = jsv,
        };
    }

    pub inline fn NewInt32(self: *Context,val:u32)Value{
        std.debug.assert(self.ctx != null);        
        var jsv = quickjs.JS_NewInt32(self.ctx.?,val);
        return Value{
            .ctx = self,
            .val = jsv,
        };
    }
    pub inline fn NewCatchOffset(self: *Context,val:u32)Value{
        std.debug.assert(self.ctx != null);        
        var jsv = quickjs.JS_NewCatchOffset(self.ctx.?,val);
        return Value{
            .ctx = self,
            .val = jsv,
        };
    }
};

pub const Value = struct{
    ctx:*Context,
    val:?quickjs.JSValue,
    pub fn Free(self:*Value)void{
        std.debug.assert(self.val != null);
        quickjs.JS_FreeValue(self.ctx.ctx,self.val.?);
        self.val = null;
    }
    pub fn Dup(self:*Value)Value{
        std.debug.assert(self.val != null);
        var jsv = quickjs.JS_DupValue(self.ctx.ctx,self.val.?);
        return Value{
            .ctx = self.ctx,
            .val = jsv,
        };
    }
    pub fn IsException(self:*Value)bool{
        std.debug.assert(self.val != null);
        return quickjs.JS_IsException(self.val.?) != 0;
    }
};