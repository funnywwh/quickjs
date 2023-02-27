const std = @import("std");
const quickjs = @cImport(@cInclude("quickjs.h"));

pub const Runtime = struct {
    rt: ?*quickjs.JSRuntime,
    pub fn NewRuntime() Runtime {
        var obj = Runtime{
            .rt = quickjs.JS_NewRuntime(),
        };
        return obj;
    }
    pub fn Free(self: *Runtime) void {
        std.debug.assert(self.rt != null);
        quickjs.JS_FreeRuntime(self.rt.?);
        self.rt = null;
    }
};

pub const Context = struct {
    ctx: ?*quickjs.JSContext,
    pub fn NewContextRaw(rt: Runtime) @This() {
        var obj = Context{
            .ctx = quickjs.JS_NewContextRaw(rt.rt),
        };
        return obj;
    }
    pub fn Free(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_FreeContext(self.ctx.?);
        self.ctx = null;
    }
    pub fn AddIntrinsicBaseObjects(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBaseObjects(self.ctx.?);
    }
    pub fn AddIntrinsicDate(self: *Context) void {
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicDate(self.ctx.?);
    }
    pub fn AddIntrinsicEval(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicEval(self.ctx.?);
    }
    pub fn AddIntrinsicStringNormalize(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicStringNormalize(self.ctx.?);
    }
    pub fn AddIntrinsicRegExp(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicRegExp(self.ctx.?);
    }
    pub fn AddIntrinsicJSON(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicJSON(self.ctx.?);
    }
    pub fn AddIntrinsicProxy(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicProxy(self.ctx.?);
    }
    pub fn AddIntrinsicMapSet(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicMapSet(self.ctx.?);
    }
    pub fn AddIntrinsicTypedArrays(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicTypedArrays(self.ctx.?);
    }
    pub fn AddIntrinsicPromise(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicPromise(self.ctx.?);
    }
    pub fn AddIntrinsicBigInt(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBigInt(self.ctx.?);
    }
    pub fn AddIntrinsicBigFloat(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBigFloat(self.ctx.?);
    }
    pub fn AddIntrinsicBigDecimal(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicBigDecimal(self.ctx.?);
    }
    pub fn AddIntrinsicOperators(self: *Context)void{
        std.debug.assert(self.ctx != null);
        quickjs.JS_AddIntrinsicOperators(self.ctx.?);
    }
    pub fn EnableBignumExt(self: *Context,enable:bool)void{
        std.debug.assert(self.ctx != null);
        if(enable){
            quickjs.JS_EnableBignumExt(self.ctx.?,1);
        }else{
            quickjs.JS_EnableBignumExt(self.ctx.?,0);
        }        
    }
    
};
