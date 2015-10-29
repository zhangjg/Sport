#include "count_skip.h"
#include <stdio.h>

int main(){
    lua_State *L = init();
    int ret = loadScript(L,"count_skip.luac");
    if(!ret){
        fprintf(stderr,"loadScript error\n");
        return 1;
    }
    int i = 0;
    int c =0;
    if(L){
        printf("count:%d\n",count_skip(L,123,134,136));
    }else{
        printf("error\n");
    }
    deinit(L);
    return 0;
}
