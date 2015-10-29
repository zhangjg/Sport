--local count_skpe=require "count_skip";
require "count_skip";

function loadData(filename)
    local input=io.open("data/shaft_"..filename..".log","r");
    count=0;
    for line in input:lines() do
        t=tonumber(string.match(line,"%s(%-?%d*)"));
        t1=tonumber(string.match(line,"%s.%d+%s(%-?%d*)"));
        t2=tonumber(string.match(line,"%s%-?%d+%s%-?%d+%s(%-?%d*)"));
        if(count_skip(t,t1,t2)) then
            print("+1")
            count=count+1;
        end
    end
    print("count:",count);
    input:close();
end
loadData('li20');
