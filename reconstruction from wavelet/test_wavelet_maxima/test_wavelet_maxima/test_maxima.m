 %小波模极大值重构是采用的交替投影法
close all;
points = 1024;   % 所处理数据的长度
level = 6;       % 分解的级数 
sr = 360;        % 抽样率， P gama投影要用的
num_inter = 6;   % 迭代次数  
wf='db3';      % 小波名称       
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wf);% 得到小波变换要用的滤波器
%ecgdata = load('ecg.txt');  %需要分析的信号
%signal = ecgdata(1:points,3)';% 取第3列，不懂可以打开ecg.txt看一下
                              % 这个信号是可以换的，做过一个信号文件就可以。
%signal = signal * 300;        % 乘以300，数据大一点显示出来漂亮一点，不为什么
%调用wave_peak进行小波变换，计算小波分解系数和模极大序列
signal = signal_fig1;
[swa,swd,ddw,wpeak] = wave_peak(signal,level,Lo_D,Hi_D);
% signal:  原始信号;       swa:小波概貌;  swd:小波细节;
% ddw:     局部极大位置; wpeak:小波变换的局部极大序列]
% 作图：左列为各层的概略信号，右列为各层的细节信号（即小波变换）
figure;
subplot(level,1,1); plot(real(signal)); grid on;axis tight;
title('original signal(Upper）、wavelet transform (Lower left)and modulus maxima（Lower right）');
for i=1:level
    %概略信号
    subplot(level+1,3,3*(i)+1);
    plot(swa(i,:)); axis tight; grid on; xlabel('time');
    ylabel(strcat('a   ',num2str(i)));
    %小波变换
    subplot(level+1,3,3*(i)+2);
    plot(swd(i,:)); axis tight;grid on;
    ylabel(strcat('d   ',num2str(i)));
    %模极大值
    subplot(level+1,3,3*(i)+3);
    plot(wpeak(i,:)); axis tight;grid on;
    ylabel(strcat('j=   ',num2str(i)));
end

pswa = swa(level,:);  % pswa: 第level层的概略信号仍然保留为重构用
wframe = (wpeak~=0);  % wframe 中的1标明wpeak非零的位置，即模极大值的位置
%迭代初始化
w0=zeros(1,points);   % 重构信号初始值设为0
[a,d]=swt(w0,level,Lo_D,Hi_D);   % 做一次稳定小波变换，结果在a和d里面，层数level不变
w2=d;                            % w2为待重建小波，上一行和这一行好像可以省去
    for j=1:num_inter            % 循环重构，d -> w2 -> w0 -> d -> w2 -> w0 -> d
       w2=Py_Pgama(d,wpeak,wframe,1,sr);  % 先进行Py投影和 Pgama投影
       w0=iswt(pswa,w2,Lo_R,Hi_R);         % 再进行Pv投影（小波逆变换）
       [a,d]=swt(w0,level,Lo_D,Hi_D);      % Pv
    end
% 最后通过w2做逆小波变换得到重构信号：    
pswa = iswt(swa(level,:),w2,Lo_R,Hi_R); % 计算重建信号
    
% 原信号和由模极大重建信号的比较
figure,
subplot(211);
plot(pswa(1:points));        % 重构信号描图
title('The comparation between original signal (Upper) and reconstructed signal (Lower)');
subplot(212);
plot(signal(1:points),'r');  % 原始信号描图

%分别计算重建小波以及原信号的信噪比
werr = w2 - swd; % 原信号的小波变换的细节部分和重构信号的细节部分的误差，即 
% 原信号的小波变换（swd)和重建后的小波变换（w2）的比较
figure,
wsnr = zeros(level,1);     % 存储每一层的信噪比
for m=1:level              % norm为2范数，即均方值
    wsnr(m) = 20*log10(norm(swd(m,:))/norm(werr(m,:)));
    subplot(level,1,m);
    plot(swd(m,:)),hold on,%红色的重构小波变换覆盖在原图上
    plot(w2(m,:),'r');grid on;ylabel(strcat('j=',num2str(m))),axis tight;
    if(m==1)
        title('The wavelet transform of original signal (blue) and the wavelet transform of reconstructed signal (red)');
    end
end

wsnr                                   % 小波域计算出的各层的信噪比
err = pswa(1:points)-signal(1:points); % 时域的误差信号
mse = mean(err.^2)                      % 均方误差
smse = mean(signal.^2);                 % 信号的均方值
snr = 10*log10(smse/mse)                % 时域中计算的信噪比(dB值）
 
