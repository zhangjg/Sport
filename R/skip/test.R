source("loadData.R", chdir = TRUE)
library(rgl);


main<- function(name){
    d=loadData(name);
    gx=d$gx;
    gy=d$gy;
    gz=d$gz;
    l = length(gx);
    m=min(gx,gz)
    M=max(gx,gz);
    plot(1:l,seq(m,M,length=l),type="n",main="G",xlab="t",ylab="gx,gy,gz");
    lines(gx,col="blue",type="s");
    lines(gz,col="green",type="s");
    abline(h=-3);
    abline(h=2);
    i =1;
    input_data=NULL;
    input_data=list(gx=gx[1],gy=gy[1],gz=gz[1]);
    #sink("test.log");
    count = 0;
    while(i <= l){
        out_data = zero_point(input_data);
        if(out_data$isABegin == 1){
            count = count + 0.5;
            points(i,1,col="blue");
        }else if(out_data$isABegin== -1){
            count = count + 0.5;
            points(i,1,col="green");
        }else {
            #points(i,1,col="red");
        }
        i= i+1;
        input_data$gx=gx[i]
        #browser();
        input_data$gy=gy[i]
        input_data$gz=gz[i]
        #input_data$timmer = out_data$timmer;
        input_data$prevStationX = out_data$current_stationX;
        input_data$prevStationZ = out_data$current_stationZ;
        input_data$sumX = out_data$sumX;
        input_data$sumZ = out_data$sumZ;
        input_data$gx_up = out_data$gx_up;
        input_data$gx_down = out_data$gx_down;
        input_data$gz_up = out_data$gz_up;
        input_data$gz_down = out_data$gz_down;
        input_data$i = i;
    }
    printf("Total:%f\n",count);
}

#zero_point[2,-3]
zero_point <- function(input_data){
    gx=input_data$gx;
    #browser();
    gz=input_data$gz;
    timmer = input_data$timmer;
    prevStationX=input_data$prevStationX;

    if(is.null(prevStationX)){
        prevStationX=0;
    }

    prevStationZ = input_data$prevStationZ;
    if(is.null(prevStationZ)){
        prevStationZ = 0;
    }


    current_stationX = -1;
    if(-3 <= gx && gx <= 3){
        current_station = 0;
    }else if(gx > 3){
        current_stationX = 1;
    }

    current_stationZ = -1;
    if(-3 <= gz && gz <= 3){
        current_stationZ = 0;
    }else if (gz > 3){
        current_stationZ = 1;
    }

    sumX = input_data$sumX;
    if(is.null(sumX)){
        sumX = 0;
    }
    sumZ = input_data$sumZ;
    if(is.null(sumZ)){
        sumZ = 0;
    }
    if( !is.null(input_data$i) && input_data$i == 590){
        #browser();
    }
    gx_up = input_data$gx_up;
    if(is.null(gx_up)){
        gx_up = F;
    }
    gz_up = input_data$gz_up;
    if(is.null(gz_up)){
        gz_up = F;
    }


    if( current_stationX ==1 &&
        prevStationX != 1
        ){
            gx_up = T;
    }

    if( current_stationZ == 1 &&
        prevStationZ != 1)
    {
        gz_up = T;
    }

    gx_down = input_data$gx_down;
    if(is.null(gx_down)){
        gx_down = F;
    }
    gz_down = input_data$gz_down;
    if(is.null(gz_down)){
        gz_down = F;
    }


    if( current_stationX == -1 &&
        prevStationX != -1
        ){
        gx_down = T;
    }
    if( current_stationZ == -1 &&
        prevStationZ != -1
        ){
        gz_down = T;
    }

    isABegin = 0;
    if(gx_up  && gz_up){
        printf("UP!i=%d\n",input_data$i)
        gx_up = F;
        gz_up = F;
        isABegin = -1;
    }else    if(gz_down || gx_down){
        printf("DOWN!i=%d\n",input_data$i)
        gz_down = F;
        gx_down = F;
        isABegin = 1;
    }
    if(isABegin == 0){
        #browser();
        sumX = sumX + gx;
        sumZ = sumZ + gz;
    }else{
        #browser();
        if( isABegin *sumX < 100  || isABegin *sumZ < 100){
            printf("index:%d,isABegin:%d\n",
                input_data$i,isABegin);
            isABegin = 0;
        }else{
            printf("i:%d:isABegin:%d\n",input_data$i,isABegin);
        }
        sumX = gx;
        sumZ = gz;
    }

    list(isABegin=isABegin,
        current_stationX=current_stationX,
        current_stationZ = current_stationZ,
        gz_up=gz_up,
        gz_down = gz_down,
        gx_up = gx_up,
        gx_down = gx_down,
        sumX = sumX,
        sumZ = sumZ
        );
}

qp<-function(x,y){
    #browser();
    q0=x$q0*y$q0 - x$q1*y$q1 - x$q2*y$q2 - x$q3*y$q3;
    q1=x$q0*y$q1 + x$q1*y$q0 + x$q2*y$q3 - x$q3*y$q2;
    q2=x$q0*y$q2 + x$q2*y$q0 + x$q3*y$q1 - x$q1*y$q3;
    q3=x$q0*y$q3 + x$q3*y$q0 + x$q1*y$q2 - x$q2*y$q1;
    list(q0=q0,q1=q1,q2=q2,q3=q3);
}
