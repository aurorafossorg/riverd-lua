/*
                                    __
                                   / _|
  __ _ _   _ _ __ ___  _ __ __ _  | |_ ___  ___ ___
 / _` | | | | '__/ _ \| '__/ _` | |  _/ _ \/ __/ __|
| (_| | |_| | | | (_) | | | (_| | | || (_) \__ \__ \
 \__,_|\__,_|_|  \___/|_|  \__,_| |_| \___/|___/___/

Copyright (C) 2018-2019 Aurora Free Open Source Software.

This file is part of the Aurora Free Open Source Software. This
organization promote free and open source software that you can
redistribute and/or modify under the terms of the GNU Lesser General
Public License Version 3 as published by the Free Software Foundation or
(at your option) any later version approved by the Aurora Free Open Source
Software Organization. The license is available in the package root path
as 'LICENSE' file. Please review the following information to ensure the
GNU Lesser General Public License version 3 requirements will be met:
https://www.gnu.org/licenses/lgpl.html .

Alternatively, this file may be used under the terms of the GNU General
Public License version 3 or later as published by the Free Software
Foundation. Please review the following information to ensure the GNU
General Public License requirements will be met:
http://www.gnu.org/licenses/gpl-3.0.html.

NOTE: All products, services or anything associated to trademarks and
service marks used or referenced on this file are the property of their
respective companies/owners or its subsidiaries. Other names and brands
may be claimed as the property of others.

For more info about intellectual property visit: aurorafoss.org or
directly send an email to: contact (at) aurorafoss.org .
*/

module riverd.lua.types;

import core.stdc.stdarg;

alias LUA_INT32 = int;
alias LUAI_UMEM = size_t;
alias LUAI_MEM = ptrdiff_t;
alias LUAI_UACNUMBER = double;

enum LUA_NUMBER_SCAN = "%lf";
enum LUA_NUMBER_FMT = "%.14g";
enum LUAI_MAXSTACK = 1000000;
enum LUA_EXTRASPACE = (void*).sizeof;

// The minimum version of Lua with which this binding is compatible.
enum LUA_VERSION_MAJOR ="5";
enum LUA_VERSION_MINOR ="3";
enum LUA_VERSION_NUM = 503;
enum LUA_VERSION_RELEASE = "0";

enum LUA_VERSION = "Lua " ~ LUA_VERSION_MAJOR ~ "." ~ LUA_VERSION_MINOR;
enum LUA_RELEASE = LUA_VERSION ~ "." ~ LUA_VERSION_RELEASE;
enum LUA_COPYRIGHT = LUA_RELEASE ~ "  Copyright (C) 1994-2012 Lua.org, PUC-Rio";
enum LUA_AUTHORS = "R. Ierusalimschy, L. H. de Figueiredo, W. Celes";

enum LUA_SIGNATURE = "\x1bLua";
enum LUA_MULTRET = -1;

enum LUA_REGISTRYINDEX = -LUAI_MAXSTACK - 1000;

int lua_upvalueindex(int i) nothrow {
	return LUA_REGISTRYINDEX - i;
}

enum {
	LUA_OK = 0,
	LUA_YIELD = 1,
	LUA_ERRRUN = 2,
	LUA_ERRSYNTAX = 3,
	LUA_ERRMEM = 4,
	LUA_ERRGCMM = 5,
	LUA_ERRERR = 6,
}

struct lua_State;

enum {
	LUA_TNONE = -1,
	LUA_TNIL = 0,
	LUA_TBOOLEAN = 1,
	LUA_TLIGHTUSERDATA = 2,
	LUA_TNUMBER = 3,
	LUA_TSTRING = 4,
	LUA_TTABLE = 5,
	LUA_TFUNCTION = 6,
	LUA_TUSERDATA = 7,
	LUA_TTHREAD = 8,
	LUA_NUMTAGS = 9,

	LUA_MINSTACK = 20,

	LUA_RIDX_MAINTHREAD = 1,
	LUA_RIDX_GLOBALS = 2,
	LUA_RIDX_LAST = LUA_RIDX_GLOBALS,
}

alias lua_Number = double;
alias lua_Integer = ptrdiff_t;
alias lua_Unsigned = uint;
alias lua_KContext = ptrdiff_t;
alias LUA_NUMBER = lua_Number;
alias LUA_INTEGER = lua_Integer;
alias LUA_UNSIGNED = lua_Unsigned;
alias LUA_KCONTEXT = lua_KContext;

extern(C) nothrow {
	alias lua_CFunction = int function(lua_State*);
	alias lua_KFunction = int function(lua_State*, int, lua_KContext);
	alias lua_Reader = const(char)* function(lua_State*, void*, size_t*);
	alias lua_Writer = int function(lua_State*, const(void)*, size_t, void*);
	alias lua_Alloc = void* function(void*, void*, size_t, size_t);
}

enum {
	LUA_OPADD = 0,
	LUA_OPSUB = 1,
	LUA_OPMUL = 2,
	LUA_OPMOD = 3,
	LUA_OPPOW = 4,
	LUA_OPDIV = 5,
	LUA_OPIDIV = 6,
	LUA_OPBAND = 7,
	LUA_OPBOR = 8,
	LUA_OPBXOR = 9,
	LUA_OPSHL = 10,
	LUA_OPSHR = 11,
	LUA_OPUNM = 12,
	LUA_OPBNOT = 13,

	LUA_OPEQ = 0,
	LUA_OPLT = 1,
	LUA_OPLE = 2,

	LUA_GCSTOP = 0,
	LUA_GCRESTART = 1,
	LUA_GCCOLLECT = 2,
	LUA_GCCOUNT = 3,
	LUA_GCCOUNTB = 4,
	LUA_GCSTEP = 5,
	LUA_GCSETPAUSE = 6,
	LUA_GCSETSTEPMUL = 7,
	LUA_GCISRUNNING = 9,

	LUA_HOOKCALL = 0,
	LUA_HOOKRET = 1,
	LUA_HOOKLINE = 2,
	LUA_HOOKCOUNT = 3,
	LUA_HOOKTAILCALL = 4,

	LUA_MASKCALL = 1 << LUA_HOOKCALL,
	LUA_MASKRET = 1 << LUA_HOOKRET,
	LUA_MASKLINE = 1 << LUA_HOOKLINE,
	LUA_MASKCOUNT = 1 << LUA_HOOKCOUNT,
}

struct lua_Debug;

extern(C) nothrow alias lua_Hook = void function(lua_State*, lua_Debug*);

struct luaL_Reg {
	const(char)* name;
	lua_CFunction func;
}

enum LUAL_NUMSIZES = (lua_Integer.sizeof * 16) + lua_Number.sizeof;

enum LUA_NOREF = -2;
enum int LUA_REFNIL = -1;

struct luaL_Buffer {
	char* b;
	size_t size;
	size_t n;
	lua_State* L;
	char[] initb;
}

struct luaL_Stream;

enum : string {
	LUA_COLIBNAME = "coroutine",
	LUA_TABLIBNAME = "table",
	LUA_IOLIBNAME = "io",
	LUA_OSLIBNAME = "os",
	LUA_STRLIBNAME = "string",
	LUA_UTF8LIBNAME = "utf8",
	LUA_BITLIBNAME = "bit32",
	LUA_MATHLIBNAME = "math",
	LUA_DBLIBNAME = "debug",
	LUA_LOADLIBNAME = "package",
}

version(RiverD_Lua_Static) {
	import riverd.lua.statfun;
} else {
	import riverd.lua.dynfun;
}

@nogc nothrow {
	ptrdiff_t lua_getextraspace(lua_State* L) {
		return cast(ptrdiff_t)(cast(void*)L - LUA_EXTRASPACE);
	}

	void lua_call(lua_State* L, int nargs, int nresults) {
		lua_callk(L, nargs, nresults, 0, null);
	}

	int lua_pcall(lua_State* L, int nargs, int nresults, int errfunc) {
		return lua_pcallk(L, nargs, nresults, errfunc, 0, null);
	}

	int lua_yield(lua_State* L, int nresults) {
		return lua_yieldk(L, nresults, 0, null);
	}

	lua_Number lua_tonumber(lua_State* L, int i) {
		return lua_tonumberx(L, i, null);
	}

	lua_Integer lua_tointeger(lua_State* L, int i) {
		return lua_tointegerx(L, i, null);
	}

	void lua_pop(lua_State* L, int idx) {
		lua_settop(L, (-idx)-1);
	}

	void lua_newtable(lua_State* L) {
		lua_createtable(L, 0, 0);
	}

	void lua_register(lua_State* L, const(char)* n, lua_CFunction f) {
		lua_pushcfunction(L, f);
		lua_setglobal(L, n);
	}

	void lua_pushcfunction(lua_State* L, lua_CFunction f) {
		lua_pushcclosure(L, f, 0);
	}

	bool lua_isfunction(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TFUNCTION;
	}

	bool lua_istable(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TTABLE;
	}

	bool lua_islightuserdata(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TLIGHTUSERDATA;
	}

	bool lua_isnil(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TNIL;
	}

	bool lua_isboolean(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TBOOLEAN;
	}

	bool lua_isthread(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TTHREAD;
	}

	bool lua_isnone(lua_State* L, int idx) {
		return lua_type(L, idx) == LUA_TNONE;
	}

	bool lua_isnoneornil(lua_State* L, int idx) {
		return lua_type(L, idx) <= 0;
	}

	const(char)* lua_pushliteral(lua_State* L, string s) {
		return lua_pushstring(L, s.ptr);
	}

	void lua_pushglobaltable(lua_State* L) {
		lua_rawgeti(L, LUA_REGISTRYINDEX, LUA_RIDX_GLOBALS);
	}

	const(char)* lua_tostring(lua_State* L, int idx) {
		return lua_tolstring(L, idx, null);
	}

	void lua_insert(lua_State* L, int idx) {
		lua_rotate(L, idx, 1);
	}

	void lua_remove(lua_State* L, int idx) {
		lua_rotate(L, idx, -1);
		lua_pop(L, 1);
	}

	void lua_replace(lua_State* L, int idx) {
		lua_copy(L, -1, idx);
		lua_pop(L, 1);
	}

	void luaL_checkversion(lua_State* L) {
		luaL_checkversion_(L, LUA_VERSION_NUM, LUAL_NUMSIZES);
	}

	int luaL_loadfile(lua_State* L, const(char)* f) {
		return luaL_loadfilex(L, f, null);
	}

	void luaL_newlibtable(lua_State* L, const(luaL_Reg)[] l) {
		lua_createtable(L, 0, cast(int)(l.length) - 1);
	}

	void luaL_newlib(lua_State* L, luaL_Reg[] l) {
		luaL_checkversion(L);
		luaL_newlibtable(L, l);
		luaL_setfuncs(L, l.ptr, 0);
	}

	const(char)* luaL_checkstring(lua_State* L, int n) {
		return luaL_checklstring(L, n, null);
	}

	const(char)* luaL_optstring(lua_State* L, int n, const(char)* d) {
		return luaL_optlstring(L, n, d, null);
	}

	const(char)* luaL_typename(lua_State* L, int i) {
		return lua_typename(L, lua_type(L,i));
	}

	int luaL_dofile(lua_State* L, const(char)* fn) {
		luaL_loadfile(L, fn);
		return lua_pcall(L, 0, LUA_MULTRET, 0);
	}

	int luaL_dostring(lua_State* L, const(char)* s) {
		luaL_loadstring(L, s);
		return lua_pcall(L, 0, LUA_MULTRET, 0);
	}

	void luaL_getmetatable(lua_State* L, const(char)* n) {
		lua_getfield(L, LUA_REGISTRYINDEX, n);
	}


	int luaL_loadbuffer(lua_State* L, const(char)* s, size_t sz, const(char)* n) {
		return luaL_loadbufferx(L, s, sz, n, null);
	}
}

extern(C) @nogc nothrow {
	alias da_lua_newstate = lua_State* function(lua_Alloc, void*);
	alias da_lua_close = void function(lua_State*);
	alias da_lua_newthread = lua_State* function(lua_State*);
	alias da_lua_atpanic = lua_CFunction function(lua_State*, lua_CFunction);
	alias da_lua_version = const(lua_Number)* function(lua_State*);
	alias da_lua_absindex = int function(lua_State*, int);
	alias da_lua_gettop = int function(lua_State*);
	alias da_lua_settop = void function(lua_State*, int);
	alias da_lua_pushvalue = void function(lua_State*, int);
	alias da_lua_rotate = void function(lua_State*, int, int);
	alias da_lua_copy = void function(lua_State*, int, int);
	alias da_lua_checkstack = int function(lua_State*, int);
	alias da_lua_xmove = void function(lua_State*, lua_State*, int);
	alias da_lua_isnumber = int function(lua_State*, int);
	alias da_lua_isstring = int function(lua_State*, int);
	alias da_lua_iscfunction = int function(lua_State*, int);
	alias da_lua_isinteger = int function(lua_State*, int);
	alias da_lua_isuserdata = int function(lua_State*, int);
	alias da_lua_type = int function(lua_State*, int);
	alias da_lua_typename = const(char)* function(lua_State*, int);
	alias da_lua_tonumberx = lua_Number function(lua_State*, int, int*);
	alias da_lua_tointegerx = lua_Integer function(lua_State*, int, int*);
	alias da_lua_toboolean = int function(lua_State*, int);
	alias da_lua_tolstring = const(char)* function(lua_State*, int, size_t*);
	alias da_lua_rawlen = size_t function(lua_State*, int);
	alias da_lua_tocfunction = lua_CFunction function(lua_State*, int);
	alias da_lua_touserdata = void* function(lua_State*, int);
	alias da_lua_tothread = lua_State* function(lua_State*, int);
	alias da_lua_topointer = const(void)* function(lua_State*, int);
	alias da_lua_arith = void function(lua_State*, int);
	alias da_lua_rawequal = int function(lua_State*, int, int);
	alias da_lua_compare = int function(lua_State*, int, int, int);
	alias da_lua_pushnil = void function(lua_State*);
	alias da_lua_pushnumber = void function(lua_State*, lua_Number);
	alias da_lua_pushinteger = void function(lua_State*, lua_Integer);
	alias da_lua_pushlstring = const(char)* function(lua_State*, const(char)*, size_t);
	alias da_lua_pushstring = const(char)* function(lua_State*, const(char)*);
	alias da_lua_pushvfstring = const(char)* function(lua_State*, const(char)*, va_list);
	alias da_lua_pushfstring = const(char)* function(lua_State*, const(char)*, ...);
	alias da_lua_pushcclosure = void function(lua_State*, lua_CFunction, int);
	alias da_lua_pushboolean = void function(lua_State*, int);
	alias da_lua_pushlightuserdata = void function(lua_State*, void*);
	alias da_lua_pushthread = int function(lua_State*);
	alias da_lua_getglobal = int function(lua_State*, const(char)*);
	alias da_lua_gettable = int function(lua_State*, int);
	alias da_lua_getfield = int function(lua_State*, int, const(char)*);
	alias da_lua_geti = int function(lua_State*, int, lua_Integer);
	alias da_lua_rawget = int function(lua_State*, int);
	alias da_lua_rawgeti = int function(lua_State*, int, int);
	alias da_lua_rawgetp = int function(lua_State*, int, const(void)*);
	alias da_lua_createtable = void function(lua_State*, int, int);
	alias da_lua_newuserdata = void* function(lua_State*, size_t);
	alias da_lua_getmetatable = int function(lua_State*, int);
	alias da_lua_getuservalue = int function(lua_State*, int);
	alias da_lua_setglobal = void function(lua_State*, const(char)*);
	alias da_lua_settable = void function(lua_State*, int);
	alias da_lua_setfield = void function(lua_State*, int, const(char)*);
	alias da_lua_rawset = void function(lua_State*, int);
	alias da_lua_rawseti = void function(lua_State*, int, lua_Integer);
	alias da_lua_rawsetp = void function(lua_State*, int, const(void)*);
	alias da_lua_setmetatable = int function(lua_State*, int);
	alias da_lua_setuservalue = void function(lua_State*, int);
	alias da_lua_callk = void function(lua_State*, int, int, lua_KContext, lua_KFunction);
	alias da_lua_pcallk = int function(lua_State*, int, int, int, lua_KContext, lua_KFunction);
	alias da_lua_load = int function(lua_State*, lua_Reader, void*, const(char)*, const(char)*);
	alias da_lua_dump = int function(lua_State*, lua_Writer, void*, int);
	alias da_lua_yieldk = int function(lua_State*, int, lua_KContext, lua_KFunction);
	alias da_lua_resume = int function(lua_State*, lua_State*, int);
	alias da_lua_status = int function(lua_State*);
	alias da_lua_isyieldable = int function(lua_State*);
	alias da_lua_gc = int function(lua_State*, int, int);
	alias da_lua_error = int function(lua_State*);
	alias da_lua_next = int function(lua_State*, int);
	alias da_lua_concat = void function(lua_State*, int);
	alias da_lua_len = void function(lua_State*, int);
	alias da_lua_stringtonumber = size_t function(lua_State*, const(char)*);
	alias da_lua_getallocf = lua_Alloc function(lua_State*, void**);
	alias da_lua_setallocf = void function(lua_State*, lua_Alloc, void*);
	alias da_lua_getstack = int function(lua_State*, int, lua_Debug*);
	alias da_lua_getinfo = int function(lua_State*, const(char)*, lua_Debug*);
	alias da_lua_getlocal = const(char)* function(lua_State*, const(lua_Debug)*, int);
	alias da_lua_setlocal = const(char)* function(lua_State*, const(lua_Debug)*, int);
	alias da_lua_getupvalue = const(char)* function(lua_State*, int, int);
	alias da_lua_setupvalue = const(char)* function(lua_State*, int, int);
	alias da_lua_upvalueid = void* function(lua_State*, int, int);
	alias da_lua_upvaluejoin = void function(lua_State*, int, int, int, int);
	alias da_lua_sethook = void function(lua_State*, lua_Hook, int, int);
	alias da_lua_gethook = lua_Hook function(lua_State*);
	alias da_lua_gethookmask = int function(lua_State*);
	alias da_lua_gethookcount = int function(lua_State*);

	alias da_luaL_checkversion_ = void function(lua_State*, lua_Number, size_t);
	alias da_luaL_getmetafield = int function(lua_State*, int, const(char)*);
	alias da_luaL_callmeta = int function(lua_State*, int, const(char)*);
	alias da_luaL_tolstring = const(char)* function(lua_State*, int, size_t*);
	alias da_luaL_argerror = int function(lua_State*, int, const(char)*);
	alias da_luaL_checklstring = const(char)* function(lua_State*, int, size_t*);
	alias da_luaL_optlstring = const(char)* function(lua_State*, int, const(char)*, size_t*);
	alias da_luaL_checknumber = lua_Number function(lua_State*, int);
	alias da_luaL_optnumber = lua_Number function(lua_State*, int, lua_Number);
	alias da_luaL_checkinteger = lua_Integer function(lua_State*, int);
	alias da_luaL_optinteger = lua_Integer function(lua_State*, int, lua_Integer);
	alias da_luaL_checkstack = void function(lua_State*, int, const(char)*);
	alias da_luaL_checktype = void function(lua_State*, int, int);
	alias da_luaL_checkany = void function(lua_State*, int);
	alias da_luaL_newmetatable = int function(lua_State*, const(char)*);
	alias da_luaL_setmetatable = void function(lua_State*, const(char)*);
	alias da_luaL_testudata = void* function(lua_State*, int, const(char)*);
	alias da_luaL_checkudata = void* function(lua_State*, int, const(char)*);
	alias da_luaL_where = void function(lua_State*, int);
	alias da_luaL_error = int function(lua_State*, const(char)*, ...);
	alias da_luaL_checkoption = int function(lua_State*, int, const(char)*);
	alias da_luaL_fileresult = int function(lua_State*, int, const(char)*);
	alias da_luaL_execresult = int function(lua_State*, int);
	alias da_luaL_ref = int function(lua_State*, int);
	alias da_luaL_unref = void function(lua_State*, int, int);
	alias da_luaL_loadfilex = int function(lua_State*, const(char)*, const(char)*);
	alias da_luaL_loadbufferx = int function(lua_State*, const(char)*, size_t, const(char)*, const(char)*);
	alias da_luaL_loadstring = int function(lua_State*, const(char)*);
	alias da_luaL_newstate = lua_State* function();
	alias da_luaL_len = lua_Integer function(lua_State*, int);
	alias da_luaL_gsub = const(char)* function(lua_State*, const(char)*, const(char)*, const(char)*);
	alias da_luaL_setfuncs = void function(lua_State*, const luaL_Reg*, int);
	alias da_luaL_getsubtable = int function(lua_State*, int, const(char)*);
	alias da_luaL_traceback = void function(lua_State*, lua_State*, const(char)*, int);
	alias da_luaL_requiref = void function(lua_State*, const(char)*, lua_CFunction, int);
	alias da_luaL_buffinit = void function(lua_State*, luaL_Buffer*);
	alias da_luaL_prepbuffsize = char* function(luaL_Buffer*, size_t);
	alias da_luaL_addlstring = void function(luaL_Buffer*, const(char)*, size_t);
	alias da_luaL_addstring = void function(luaL_Buffer*, const(char)*);
	alias da_luaL_addvalue = void function(luaL_Buffer*);
	alias da_luaL_pushresult = void function(luaL_Buffer*);
	alias da_luaL_pushresultsize = void function(luaL_Buffer*, size_t);
	alias da_luaL_buffinitsize = char* function(lua_State*, luaL_Buffer*, size_t);
	alias da_luaL_pushmodule = void function(lua_State*, const(char)*, int);
	alias da_luaL_openlib = void function(lua_State*, const(char)*, const(luaL_Reg)*, int);

	alias da_luaopen_base = int function(lua_State*);
	alias da_luaopen_coroutine = int function(lua_State*);
	alias da_luaopen_table = int function(lua_State*);
	alias da_luaopen_io = int function(lua_State*);
	alias da_luaopen_os = int function(lua_State*);
	alias da_luaopen_string = int function(lua_State*);
	alias da_luaopen_utf8 = int function(lua_State*);
	alias da_luaopen_bit32 = int function(lua_State*);
	alias da_luaopen_math = int function(lua_State*);
	alias da_luaopen_debug = int function(lua_State*);
	alias da_luaopen_package = int function(lua_State*);
	alias da_luaL_openlibs = void function(lua_State*);
}
