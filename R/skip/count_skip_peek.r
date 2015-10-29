source("loadData.R");
core <-function(in_data){
    data= in_data$data;
    current= in_data$index;
    isPreviousPeek = in_data$peek;
    if(is.null(isPreviousPeek)){
        isPreviousPeek = F;
    }

    out_data=list(
        peek=F,index=current+1,
        sum=in_data$sum,plusOne=F
        );

    if(data<0.05){
        out_data$peek=F;
    }else{
        out_data$peek=T;
    }
    if(is.null(out_data$sum)){
        out_data$sum = 0;
    }
    if(isPreviousPeek == out_data$peek && isPreviousPeek){
        out_data$sum=out_data$sum + data;
    }
    if(isPreviousPeek != out_data$peek && isPreviousPeek){
        if(out_data$sum >= 15){
            out_data$plusOne=T;
        }
        out_data$sum = 0;
    }
    out_data;
}


count_skiping <- function(dataid){
    d=loadData(dataid);
    da=d$a[1:2000]^.5 -1;
    plot(da,type="l");
    len = length(da);
    count_result = 0;
    i = 1;
    coreResult=list(index=1,data=NULL);
    i = 1;
    t=0;
    isPreviousPeek=F;
    previous=1;
    while(i <= len){
        coreResult$data=da[i];
        i = i +1;
        coreResult = core(coreResult);
        if(isPreviousPeek == coreResult$peek && isPreviousPeek == F ){
            lines(previous:(coreResult$index-1),
                    rep(0.05,coreResult$index-previous),col=2);
            previous = coreResult$index;
        }
        isPreviousPeek = coreResult$peek;
        if(coreResult$plusOne){
            # printf("index:%d\n",coreResult$index);
            points(coreResult$index-5,1,col=2);
            t = t+1;
        }
    }
    printf("result2:%d\n",t);
}
