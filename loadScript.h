#ifndef loadScript_h
#define loadScript_h

#include "lua/lualib.h"
#include "lua/lua.h"
#include "lua/lauxlib.h"

/**
 * Note:
 * This group functions is uesed to load the lua scirpt.
 * In every process, you need used init() and deinit() as a pair. first use init() to get the lua_State struct,
 * When the donot want to count the skip again, your can call deinit();
 * Between the init() and deinit() you can use the loadScript() to load a lua script file and use it.
 */

lua_State* init();
void deinit(lua_State* p);

int loadScript(lua_State*p,const char* scripeFile);

#endif//loadScript_h
