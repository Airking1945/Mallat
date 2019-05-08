% 该函数对一个区间进行Pgama投影，返回修正的区间
% 这个P gama投影我暂时没看懂，先得到结果再说。反正是输入一个误差序列，
% 投影以后得到一个内插的误差序列。继续查资料找到原理
function [inter] = P_gama(interval,lev,sr)
T = length(interval);
if T==2
    inter = interval;
else
    t=linspace(0,(T-1)/sr,T);
    para = (([1,1;exp(2^(-lev)*t(T)),exp(-2^(-lev)*t(T))])\[interval(1),interval(T)]')';
    % a\b表示a的逆乘以b，但不求逆，用高斯消去法求解，比较稳定
    alpha = para(1);
    beta = para(2);
    inter = alpha.*exp(2^(-lev).*t) + beta.*exp(-2^(-lev).*t);
end