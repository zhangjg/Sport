#include "loadScript.h"
#include <stdio.h>
lua_State * init(){
    lua_State *p = luaL_newstate();
    luaL_openlibs(p);
    return p;
}
void deinit(lua_State* p){
    if( 0 != p){
        lua_close(p);
    }
}

int loadScript(lua_State* p,const char* fileName){
    if(0 == p) {
        fprintf(stderr,"error:in loadScript(p,filename),p must not be a NULL\n");
        return 0;
    }
            
    if(luaL_loadfile(p,fileName)){
        fprintf(stderr,"load file \"%s\" error:%s\n",fileName,lua_tostring(p,-1));
        return 0;
    }
    if(lua_pcall(p,0,0,0)) {
        fprintf(stderr,"run file \"%s\" error:%s\n",fileName,lua_tostring(p,-1));
        return 0;
    }
    return 1;
}
