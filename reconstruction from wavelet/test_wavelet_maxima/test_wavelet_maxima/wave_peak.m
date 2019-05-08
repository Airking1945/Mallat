% 该函数用于读取ecg信号，找到小波变换模极大序列
% signal:  原始信号;       swa:小波概貌;  swd:小波细节;
% ddw:     局部极大位置; wpeak:小波变换的局部极大序列]
function [swa,swd,ddw,wpeak]=wave_peak(signal,level,Lo_D,Hi_D)

points = size(signal,2); %信号的长度

%  信号的小波变换，按级给出概貌和细节的波形, 细节请看swt帮助(help swt)frgtthyufcvcvgfhd
[swa,swd] = swt(signal,level,Lo_D,Hi_D);

% 求小波变换的模极大值及其位置
ddw = zeros(size(swd));   % 局部极大值位置，初始值全为0
pddw = ddw;               % 正局部极大值位置，初始值全为0
nddw = ddw;               % 负局部极大值位置，初始值全为0
posw = swd.*(swd>0);      % posw是小波变换的正的系数值，负的全部成了0
pdw = ((posw(:,1:points-1)-posw(:,2:points))<0);%水平差分（左边-右边），如果<0,结果为1
pddw(:,2:points-1) = ((pdw(:,1:points-2)-pdw(:,2:points-1))>0);%水平再差分，如果>0,结果为1
                                                               % pddw中的1对应正的模极大值的位置
negw = swd.*(swd<0);     % negw是小波变换的负的系数值，正的全部成了0
ndw=((negw(:,1:points-1)-negw(:,2:points))>0); %水平差分（左边-右边），如果>0,结果为1
nddw(:,2:points-1)=((ndw(:,1:points-2)-ndw(:,2:points-1))>0);%水平再差分，如果>0,结果为1
                                                             % nddw中的1对应负的模极大值的位置
ddw=pddw|nddw;            %  ddw中的1对应所有模极大值的位置
ddw(:,1)=1;               %  各尺度的最左那个点全部设为极值点
ddw(:,points)=1;          %  各尺度的最右那个点全部设为极值点
wpeak=ddw.*swd;           %  wpeak中的非零值即为模极大值点，其余为0
wpeak(:,1)=wpeak(:,1)+1e-10;  % 左端点加上一个很小的数（1e-10)，避免0作为模极大值
wpeak(:,points)=wpeak(:,points)+1e-10; %右端点加上一个很小的数（1e-10)，......

%注：运行此程序时一定要将待处理信号添加进去: ecgdata=load('ecg.txt'); 