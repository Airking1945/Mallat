% 该函数对区间进行裁减即Py投影，返回裁剪后的区间信号（其实就是内插模极大值之间的小波系数值
function pc3inte=P_y(interval,len)

if sign(interval(1))==sign(interval(len))     % 如果前后两个模极大值同号（同是正的或同是负的）
    interval = interval.*(sign(interval)==sign(interval(1)));% 
    inte = interp1([1,len],[interval(1),interval(len)],(1:len),'linear'); 
          %inte 是开始值为左端点，结束值为右端点，长度为len的内插序列
          % 如果内插值得绝对值大于原来的值的绝对值((abs(inte)-abs(interval))>0)
          % 则取原来的值，否则取内插的值，符号不变
    interval = sign(interval(1))*(abs(inte)-(abs(inte)-abs(interval)).*((abs(inte)-abs(interval))>0));          
else                                           % 如果前后两个模极大值不同号（一个是正的另一个是负的
    sgn = sign(interval(len)-interval(1));       % sgn = 1, 前面是负的，后面是正的， -1， 前面是正的，后面是负的
    intemax = max([interval(1),interval(len)]);  % intmax 两端点的极值里大的那个
    intemin = min([interval(1),interval(len)]);  % intmin 两端点的极值里小的那个
    for i=1:len-2
        if sign(interval(i+1)-interval(i))~=sgn  % 如果这两个不相等，表示相邻两个值的谁大谁小，和两个端点谁大谁小，不一致
            interval(i+1)=interval(i);           % 让相邻值的后面那个等于前面那个
        end
        if interval(i+1)>intemax                 % 如果后面那个值大于最大值，就让它等于最大值
            interval(i+1)=intemax;               % 
        end
       if interval(i+1)<intemin                   % 如果后面那个值小于最小值，就让它等于最小值
                interval(i+1)=intemin;
        end
    end
end
pc3inte=interval;                                % 返回内插的值
