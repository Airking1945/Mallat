% �ú������ڶ�ȡecg�źţ��ҵ�С���任ģ��������
% signal:  ԭʼ�ź�;       swa:С����ò;  swd:С��ϸ��;
% ddw:     �ֲ�����λ��; wpeak:С���任�ľֲ���������]
function [swa,swd,ddw,wpeak]=wave_peak(signal,level,Lo_D,Hi_D)

points = size(signal,2); %�źŵĳ���

%  �źŵ�С���任������������ò��ϸ�ڵĲ���, ϸ���뿴swt����(help swt)frgtthyufcvcvgfhd
[swa,swd] = swt(signal,level,Lo_D,Hi_D);

% ��С���任��ģ����ֵ����λ��
ddw = zeros(size(swd));   % �ֲ�����ֵλ�ã���ʼֵȫΪ0
pddw = ddw;               % ���ֲ�����ֵλ�ã���ʼֵȫΪ0
nddw = ddw;               % ���ֲ�����ֵλ�ã���ʼֵȫΪ0
posw = swd.*(swd>0);      % posw��С���任������ϵ��ֵ������ȫ������0
pdw = ((posw(:,1:points-1)-posw(:,2:points))<0);%ˮƽ��֣����-�ұߣ������<0,���Ϊ1
pddw(:,2:points-1) = ((pdw(:,1:points-2)-pdw(:,2:points-1))>0);%ˮƽ�ٲ�֣����>0,���Ϊ1
                                                               % pddw�е�1��Ӧ����ģ����ֵ��λ��
negw = swd.*(swd<0);     % negw��С���任�ĸ���ϵ��ֵ������ȫ������0
ndw=((negw(:,1:points-1)-negw(:,2:points))>0); %ˮƽ��֣����-�ұߣ������>0,���Ϊ1
nddw(:,2:points-1)=((ndw(:,1:points-2)-ndw(:,2:points-1))>0);%ˮƽ�ٲ�֣����>0,���Ϊ1
                                                             % nddw�е�1��Ӧ����ģ����ֵ��λ��
ddw=pddw|nddw;            %  ddw�е�1��Ӧ����ģ����ֵ��λ��
ddw(:,1)=1;               %  ���߶ȵ������Ǹ���ȫ����Ϊ��ֵ��
ddw(:,points)=1;          %  ���߶ȵ������Ǹ���ȫ����Ϊ��ֵ��
wpeak=ddw.*swd;           %  wpeak�еķ���ֵ��Ϊģ����ֵ�㣬����Ϊ0
wpeak(:,1)=wpeak(:,1)+1e-10;  % ��˵����һ����С������1e-10)������0��Ϊģ����ֵ
wpeak(:,points)=wpeak(:,points)+1e-10; %�Ҷ˵����һ����С������1e-10)��......

%ע�����д˳���ʱһ��Ҫ���������ź���ӽ�ȥ: ecgdata=load('ecg.txt'); 