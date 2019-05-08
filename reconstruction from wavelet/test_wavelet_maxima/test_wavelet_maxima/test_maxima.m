 %С��ģ����ֵ�ع��ǲ��õĽ���ͶӰ��
close all;
points = 1024;   % ���������ݵĳ���
level = 6;       % �ֽ�ļ��� 
sr = 360;        % �����ʣ� P gamaͶӰҪ�õ�
num_inter = 6;   % ��������  
wf='db3';      % С������       
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wf);% �õ�С���任Ҫ�õ��˲���
%ecgdata = load('ecg.txt');  %��Ҫ�������ź�
%signal = ecgdata(1:points,3)';% ȡ��3�У��������Դ�ecg.txt��һ��
                              % ����ź��ǿ��Ի��ģ�����һ���ź��ļ��Ϳ��ԡ�
%signal = signal * 300;        % ����300�����ݴ�һ����ʾ����Ư��һ�㣬��Ϊʲô
%����wave_peak����С���任������С���ֽ�ϵ����ģ��������
signal = signal_fig1;
[swa,swd,ddw,wpeak] = wave_peak(signal,level,Lo_D,Hi_D);
% signal:  ԭʼ�ź�;       swa:С����ò;  swd:С��ϸ��;
% ddw:     �ֲ�����λ��; wpeak:С���任�ľֲ���������]
% ��ͼ������Ϊ����ĸ����źţ�����Ϊ�����ϸ���źţ���С���任��
figure;
subplot(level,1,1); plot(real(signal)); grid on;axis tight;
title('original signal(Upper����wavelet transform (Lower left)and modulus maxima��Lower right��');
for i=1:level
    %�����ź�
    subplot(level+1,3,3*(i)+1);
    plot(swa(i,:)); axis tight; grid on; xlabel('time');
    ylabel(strcat('a   ',num2str(i)));
    %С���任
    subplot(level+1,3,3*(i)+2);
    plot(swd(i,:)); axis tight;grid on;
    ylabel(strcat('d   ',num2str(i)));
    %ģ����ֵ
    subplot(level+1,3,3*(i)+3);
    plot(wpeak(i,:)); axis tight;grid on;
    ylabel(strcat('j=   ',num2str(i)));
end

pswa = swa(level,:);  % pswa: ��level��ĸ����ź���Ȼ����Ϊ�ع���
wframe = (wpeak~=0);  % wframe �е�1����wpeak�����λ�ã���ģ����ֵ��λ��
%������ʼ��
w0=zeros(1,points);   % �ع��źų�ʼֵ��Ϊ0
[a,d]=swt(w0,level,Lo_D,Hi_D);   % ��һ���ȶ�С���任�������a��d���棬����level����
w2=d;                            % w2Ϊ���ؽ�С������һ�к���һ�к������ʡȥ
    for j=1:num_inter            % ѭ���ع���d -> w2 -> w0 -> d -> w2 -> w0 -> d
       w2=Py_Pgama(d,wpeak,wframe,1,sr);  % �Ƚ���PyͶӰ�� PgamaͶӰ
       w0=iswt(pswa,w2,Lo_R,Hi_R);         % �ٽ���PvͶӰ��С����任��
       [a,d]=swt(w0,level,Lo_D,Hi_D);      % Pv
    end
% ���ͨ��w2����С���任�õ��ع��źţ�    
pswa = iswt(swa(level,:),w2,Lo_R,Hi_R); % �����ؽ��ź�
    
% ԭ�źź���ģ�����ؽ��źŵıȽ�
figure,
subplot(211);
plot(pswa(1:points));        % �ع��ź���ͼ
title('The comparation between original signal (Upper) and reconstructed signal (Lower)');
subplot(212);
plot(signal(1:points),'r');  % ԭʼ�ź���ͼ

%�ֱ�����ؽ�С���Լ�ԭ�źŵ������
werr = w2 - swd; % ԭ�źŵ�С���任��ϸ�ڲ��ֺ��ع��źŵ�ϸ�ڲ��ֵ����� 
% ԭ�źŵ�С���任��swd)���ؽ����С���任��w2���ıȽ�
figure,
wsnr = zeros(level,1);     % �洢ÿһ��������
for m=1:level              % normΪ2������������ֵ
    wsnr(m) = 20*log10(norm(swd(m,:))/norm(werr(m,:)));
    subplot(level,1,m);
    plot(swd(m,:)),hold on,%��ɫ���ع�С���任������ԭͼ��
    plot(w2(m,:),'r');grid on;ylabel(strcat('j=',num2str(m))),axis tight;
    if(m==1)
        title('The wavelet transform of original signal (blue) and the wavelet transform of reconstructed signal (red)');
    end
end

wsnr                                   % С���������ĸ���������
err = pswa(1:points)-signal(1:points); % ʱ�������ź�
mse = mean(err.^2)                      % �������
smse = mean(signal.^2);                 % �źŵľ���ֵ
snr = 10*log10(smse/mse)                % ʱ���м���������(dBֵ��
 
