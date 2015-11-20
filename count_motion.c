#include <math.h>
#define U  4096 //2^12
#include "count_motion.h"
int count_motion(int ax,int ay,int az){
    double x= ax;
    x/=U;
    double y= ay;
    y /= U;
    double z= az;
    z /= U;
    double sum = sqrt(x*x + y*y + z*z);

    static int timmer= TIMMER_UP +1;
    if(  timmer < TIMMER_UP ){
        timmer++;
    }

    if( (sum > UP || sum < DOWN) && timmer >= TIMMER_UP ){
        timmer = 1;
        return 1;
    }
    return 0;
}
