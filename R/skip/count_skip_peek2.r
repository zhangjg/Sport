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
        sum=in_data$sum,plusOne=F,
        lengthOfWell=1,count_less5=in_data$count_less5,
        isPreviousWell=F
        );
    if(!is.null(in_data$isPreviousWell)){
        out_data$isPreviousWell = in_data$isPreviousWell;
    }
    if(!is.null(in_data$lengthOfWell)){
        out_data$lengthOfWell = in_data$lengthOfWell;
    }
    if(data<0.2){
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
    # if(isPreviousPeek != out_data$peek && isPreviousPeek){
    #     if(out_data$sum >= 15){
    #         out_data$plusOne=T;
    #     }
    #     #out_data$sum = 0;
    # }

    isCurrentWell = !out_data$peek;
    #browser();
    if(!out_data$peek){
        lines(x=out_data$index-1,-1,col=2,type="h");
    }
    if(out_data$isPreviousWell && isCurrentWell){
        printf("index1:%d,%d\n",out_data$index-1,out_data$lengthOfWell);
        out_data$lengthOfWell = out_data$lengthOfWell +1;
        if( out_data$lengthOfWell >= 5 ){
            if(out_data$sum >= 16) {
                out_data$plusOne = T;
            }
            out_data$sum = 0;
        }
    }
    # if(out_data$lengthOfWell > 5 && current > ){
    #     browser();
    # }
    if(out_data$isPreviousWell && !isCurrentWell){
        printf("index:%d,%d\n",out_data$index-1,out_data$lengthOfWell);
        if(out_data$lengthOfWell > 5){
            text(out_data$lengthOfWell,
                x=(out_data$index-out_data$lengthOfWell/2),y=0.05,
                col=3);
            out_data$count_less5 = 1;
        }else{
            # printf("%d\n",out_data$lengthOfWell);
            text(out_data$lengthOfWell,x=(out_data$index-1),
            y=-1+(out_data$count_less5%%5)/10,col=1);
            out_data$count_less5 = out_data$count_less5 +1;
        }
        out_data$lengthOfWell =1;
    }
    out_data$isPreviousWell = isCurrentWell;
    out_data;
}


count_skiping <- function(dataid){
    d=loadData(dataid);
    da=d$a[]^.5 -1;
    plot(da,type="l");
    abline(h=0.05,col=1);
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
        coreResult = core(coreResult);
        isCurrentWell = !coreResult$peek;
        t[length(t)+1]= isCurrentWell;
        if(coreResult$plusOne){
            count = count +1;
            points(coreResult$index-15, 1,col=2);
        }
        isPreviousWell = isCurrentWell;
    }
    #lines(-t,type="h",col=2);
    printf("count%d\n",count);
}
