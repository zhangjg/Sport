-- function gender_core(threshold_zero=0.05,energy_threshold=15,index=1,isPreviousPeek=false,sum=0)
local function gender_core(threshold_zero,energy_threshold,index,isPreviousPeek,sum,lengthOfWell)

    if(threshold_zero == nil) then
        threshold_zero=0.2;
    end
    if(energy_threshold == nil) then
        energy_threshold = 16;
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
    if(lengthOfWell == nil) then
        lengthOfWell = 1;
    end
    local core=function(data)
        --print(data);
        local current = index;
        local plusOne = false;
        index = index +1;
        --print(index);
        local isPeek =null;
        if(data < threshold_zero) then
            isPeek = false;
        else
            isPeek = true;
        end
        if(isPreviousPeek == isPeek and isPreviousPeek) then
            sum = sum + data;
        end

        if(not(isPreviousPeek or isPeek)) then
            lengthOfWell = lengthOfWell +1;
            if (lengthOfWell >= 5) then
                if(sum >= energy_threshold) then
                    plusOne = true;
                end
                sum = 0;
            end
        end
        if( not isPreviousPeek and isPeek) then
            lengthOfWell =1 ;
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
