-- function gender_core(threshold=0.05,index=1,isPreviousPeek=false,sum=0)
local function gender_core(threshold,index,isPreviousPeek,sum)

    if(threshold == nil) then
        threshold=0.05;
    end
    if(index == nil) then
        index =1;
    end
    if(isPreviousPeek == nil) then
        isPreviousPeek = false;
    end
    if(sum ==nil)then
        sum = 0;
    end
    local core=function(data)
        --print(data);
        local current = index;
        local plusOne = false;
        index = index +1;
        --print(index);
        local isPeek =null;
        if(data < threshold) then
            isPeek = false;
        else
            isPeek = true;
        end
        if(isPreviousPeek == isPeek and isPreviousPeek) then
            sum = sum + data;
        end
        if(isPreviousPeek ~= isPeek and isPreviousPeek) then
            --print("sum:",sum);
            if(sum >= 15) then
                plusOne = true;
            end
            sum = 0;
        end
        isPreviousPeek = isPeek;
        return plusOne;
    end
    return core;
end


local core=nil;
function count_skip(ax,ay,az)
    local const1=2^14;
    ax = ax/const1;
    ay = ay/const1;
    az = az/const1;
    data=(ax^2+ay^2+az^2)^0.5-1;
    if(core == nil) then
        core = gender_core();
    end
    return core(data);
end
--return count_skpe;
