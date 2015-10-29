free_fall_poind <- function(a,threhold_zero_speed_poind=2){
    ret=double();
    n=0;
    for(i in a){
        n = n +1
        if( i < threhold_zero_speed_poind ){
            ret[n]=T
        }else
        {
            ret[n]=F;
        }
    }

    plot(a[],type="l");
    lines(ret[]*threhold_zero_speed_poind,col=2);
    ret
}



count_skipping<- function(zero_speed_data){
    len_data= length(zero_speed_data);
    i = 2;
    threhold_zero_num=10;
    threhold_non_zero_num=6;
    num_zero_speed=0;#零速度点的个数
    num_non_zero_speed=0;
    if(zero_speed_data[1] == T){
        num_zero_speed = 1;
    }else{
        num_non_zero_speed=0;
    }
    count= 0;
    #printf("len_data:%d\n",len_data);
    while ( i != len_data){
        previous = i -1;
        current = i;
        i = i +1;

        if(zero_speed_data[previous] == T && zero_speed_data[current] == T){
            num_zero_speed = num_zero_speed +1;
            next;
        }

        if( zero_speed_data[previous] == F && zero_speed_data[current] == F){
            num_non_zero_speed = num_non_zero_speed +1;
            next;
        }
        #browser();
        if(zero_speed_data[previous] == T && zero_speed_data[current] == F){
            #上升转折点
            num_non_zero_speed = num_non_zero_speed +1;
            if(num_zero_speed < threhold_zero_num){
                #printf("num_zero_speed:%d,threhold_zero_num:%d\n",num_zero_speed,threhold_zero_num)
                num_non_zero_speed = num_non_zero_speed + num_zero_speed;
                num_zero_speed = 0;
            }
            # else{
            #     #num_non_zero_speed = 1;
            #     printf("num_zero_speed:%d\n",num_zero_speed);
            # }
            next;
        }
        if(zero_speed_data[previous] == F && zero_speed_data[current] == T){
            #下降转折点
            num_zero_speed = num_zero_speed +1;
            if( num_zero_speed >= threhold_zero_num
                && num_non_zero_speed >= threhold_non_zero_num){
                num_non_zero_speed = 1;
                num_zero_speed = 0;
                count = count +1;
                points(current,2,col=3);
                printf("current:%d\n",current);
                next;
            }
            if( num_non_zero_speed < threhold_non_zero_num ){
                #printf("num_non_zero_speed:%d,threhold_no_zero_num:%d\n",num_non_zero_speed,threhold_zero_num)
                num_zero_speed = num_zero_speed + num_non_zero_speed;
                num_non_zero_speed = 0;
                next;
            }
            printf("78:num_zero_speed:%d\n",num_zero_speed);
        }
    }
    count;
}
