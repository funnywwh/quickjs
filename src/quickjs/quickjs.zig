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

    pub fn std_set_worker_new_context_func(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.js_std_set_worker_new_context_func(Context.new_ctx);
    }
};
