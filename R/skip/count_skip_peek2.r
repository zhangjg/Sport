source("loadData.R");
core <-function(in_data,threshold=0.2,threshold_eng=16,plot=F){
    data= in_data$data;
    current= in_data$index;
    isPreviousPeek = in_data$peek;
    if(is.null(isPreviousPeek)){
        isPreviousPeek = F;
    }

    out_data=list(
        peek=F,index=current+1,
        sum=in_data$sum,plusOne=F,
        lengthOfWell=1,count_less5=in_data$count_less5#,
        #isPreviousWell=F
        );
    # if(!is.null(in_data$isPreviousWell)){
    #     out_data$isPreviousWell = in_data$isPreviousWell;
    # }
    if(!is.null(in_data$lengthOfWell)){
        out_data$lengthOfWell = in_data$lengthOfWell;
    }
    if(data<threshold){
        out_data$peek=F;
    }else{
        out_data$peek=T;
    }
    if(is.null(out_data$sum)){
        out_data$sum = 0;
    }
    if(is.null(out_data$count_less5)){
        out_data$count_less5 = 1;
    }
    if(isPreviousPeek == out_data$peek && isPreviousPeek){
        out_data$sum=out_data$sum + data;
    }

    #isCurrentWell = !out_data$peek;
    #browser();
    if(!out_data$peek && plot){
        lines(x=out_data$index-1,-1,col=2,type="h");
    }
    #if(out_data$isPreviousWell && isCurrentWell){
    # !isPreviousPeek equal isPreviousWell
    # !out_data$peek equal isCurrentWell
    # if(!isPreviousPeek && !out_data$peek ){
    if(!(isPreviousPeek ||out_data$peek)){
        #printf("index1:%d,%d\n",out_data$index-1,out_data$lengthOfWell);
        out_data$lengthOfWell = out_data$lengthOfWell +1;
        if( out_data$lengthOfWell >= 5 ){
            if(out_data$sum >= threshold_eng) {
                out_data$plusOne = T;
            }
            out_data$sum = 0;
        }
    }
    # if(out_data$isPreviousWell && !isCurrentWell){
    # !isPreviousPeek equal isPreviousWell
    # !out_data$peek equal isCurrentWell
    if(!isPreviousPeek && out_data$peek){
        if(out_data$lengthOfWell > 5){
            text(out_data$lengthOfWell,
                x=(out_data$index-out_data$lengthOfWell/2),y=0.05,
                col=3);
            out_data$count_less5 = 1;
        }else{
            # prinf("%d\n",out_data$lengthOfWell);
            if(plot){
                text(out_data$lengthOfWell,x=(out_data$index-1),
                y=-1+(out_data$count_less5%%5)/10,col=1);
            }
            out_data$count_less5 = out_data$count_less5 +1;
        }
        out_data$lengthOfWell =1;
    }
    #out_data$isPreviousWell = isCurrentWell;
    #out_data$isPreviousWell = !out_data$peek;
    out_data;
}


count_skiping <- function(dataid,begin=1,end=NULL,threshold=0.2,threshold_eng=16){
    d=loadData(dataid);
    filter=NULL;
    if(is.null(end)){
        end=length(d$a);
    }
    filter = begin:end;
    da=d$a[filter]^.5 -1;
    plot(da,type="l");
    abline(h=threshold,col=1);
    len = length(da);
    count_result = 0;
    i = 1;
    coreResult=list(index=1,data=NULL);
    i = 1;
    t=logical();
    isPreviousWell =F;# the previous data is in a well.
    lengthOfWell = 1;
    count_less5 = 1;
    count=0;
    while(i <= len){
        coreResult$data=da[i];
        i = i +1;
        coreResult = core(coreResult,threshold,threshold_eng,plot=T);
        isCurrentWell = !coreResult$peek;
        t[length(t)+1]= isCurrentWell;
        if(coreResult$plusOne){
            count = count +1;
            points(coreResult$index-15, 1,col=2);
        }
        isPreviousWell = isCurrentWell;
    }
    #lines(-t,type="h",col=2);
    printf("count:%d\n",count);
}
