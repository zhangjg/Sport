#ifndef count_skip_h
#define count_skip_h
#include "loadScript.h"

/**
 * @param L: lua_State,from init(), no need to care.
 * @param ax: data from x axis
 * @param ay: data from y axis
 * @param az: data from z axis
 *
 * @return  if there is one skip return true,else return false.
 */
int count_skip(lua_State* L,int ax,int ay,int az);
#endif
