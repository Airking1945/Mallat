% �ú�����������вü���PyͶӰ�����زü���������źţ���ʵ�����ڲ�ģ����ֵ֮���С��ϵ��ֵ
function pc3inte=P_y(interval,len)

if sign(interval(1))==sign(interval(len))     % ���ǰ������ģ����ֵͬ�ţ�ͬ�����Ļ�ͬ�Ǹ��ģ�
    interval = interval.*(sign(interval)==sign(interval(1)));% 
    inte = interp1([1,len],[interval(1),interval(len)],(1:len),'linear'); 
          %inte �ǿ�ʼֵΪ��˵㣬����ֵΪ�Ҷ˵㣬����Ϊlen���ڲ�����
          % ����ڲ�ֵ�þ���ֵ����ԭ����ֵ�ľ���ֵ((abs(inte)-abs(interval))>0)
          % ��ȡԭ����ֵ������ȡ�ڲ��ֵ�����Ų���
    interval = sign(interval(1))*(abs(inte)-(abs(inte)-abs(interval)).*((abs(inte)-abs(interval))>0));          
else                                           % ���ǰ������ģ����ֵ��ͬ�ţ�һ����������һ���Ǹ���
    sgn = sign(interval(len)-interval(1));       % sgn = 1, ǰ���Ǹ��ģ����������ģ� -1�� ǰ�������ģ������Ǹ���
    intemax = max([interval(1),interval(len)]);  % intmax ���˵�ļ�ֵ�����Ǹ�
    intemin = min([interval(1),interval(len)]);  % intmin ���˵�ļ�ֵ��С���Ǹ�
    for i=1:len-2
        if sign(interval(i+1)-interval(i))~=sgn  % �������������ȣ���ʾ��������ֵ��˭��˭С���������˵�˭��˭С����һ��
            interval(i+1)=interval(i);           % ������ֵ�ĺ����Ǹ�����ǰ���Ǹ�
        end
        if interval(i+1)>intemax                 % ��������Ǹ�ֵ�������ֵ���������������ֵ
            interval(i+1)=intemax;               % 
        end
       if interval(i+1)<intemin                   % ��������Ǹ�ֵС����Сֵ��������������Сֵ
                interval(i+1)=intemin;
        end
    end
end
pc3inte=interval;                                % �����ڲ��ֵ
