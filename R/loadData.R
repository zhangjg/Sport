
loadData <- function(){
    data2<- read.table("bluetoothdata2.txt",col.name=c("ax","ay","az"),sep=",");
    #browser();
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
    list(ax=ax,ay=ay,az=az,a=a,ax1=ax1,ay1=ay1,az1=az1);
}

printf <- function(...) cat(sprintf(...));
