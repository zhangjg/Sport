
loadData <- function(name){
    data<-read.table(paste("11-12/element_",name,".txt",sep=""),col.names=c("t","q0","q1","q2","q3"));
    q0=data$q0/2^30;
    q1=data$q1/2^30;
    q2=data$q2/2^30;
    q3=data$q3/2^30;

    data$t <- NULL;
    data2<- read.table(paste("11-12/shaft_",name,".txt",sep=""),col.name=c("t","ax","ay","az","gx","gy","gz"));
    ax=data2$ax;
    ay=data2$ay;
    az=data2$az;
    ax=ax/2^14;
    ay=ay/2^14;
    az=az/2^14;

    ax1=  (max(ax)-ax)/(max(ax)-min(ax))
    ay1=  (max(ay)-ay)/(max(ay)-min(ay))
    az1=  (max(az)-az)/(max(az)-min(az))

    a = ax^2 + ay^2 + az^2;
    gx=data2$gx/131
    gy=data2$gy/131
    gz = data2$gz/131
    gx1= (max(gx)-gx)/(max(gx)-min(gx))
    gy1= (max(gy)-gy)/(max(gy)-min(gy))
    gz1= (max(gz)-gz)/(max(gz)-min(gz))

    g = gx^2 + gy^2 + gz^2
    list(q0=q0,q1=q1,q2=q2,q3=q3,ax=ax,ay=ay,az=az,a=a,ax1=ax1,ay1=ay1,az1=az1,gx=gx,
        gy=gy,gz=gz,gx1=gx1,gy1=gy1,gz1=gz1);
}

printf <- function(...) cat(sprintf(...));
