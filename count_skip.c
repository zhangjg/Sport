#include "count_skip.h"
#include <stdio.h>

int count_skip(lua_State*L,int ax,int ay,int az){
    lua_getglobal(L,"count_skip");
    lua_pushnumber(L,ax);
    lua_pushnumber(L,ay);
    lua_pushnumber(L,az);
    
    int ret=0;
    if(lua_pcall(L,3,1,0) ){
        fprintf(stderr,"count(data) error:%s\n",lua_tostring(L,-1));
    }
    ret = lua_toboolean(L,-1);
    lua_pop(L,1);
    return ret;
}
