% �ú������ڽ��� Pgama �� Py ͶӰ 
function  w2=Py_Pgama(w1,wpeak,wframe,level,sr)
err=wpeak-w1.*(wpeak~=0);  %ģ����ֵ�������ع��ź�С���任�ڼ�ֵ���ϵ��������
w2=zeros(size(wpeak));     % w2
[r,c]=size(wpeak);         % r: wpeak���У�ʵ���Ͼ��Ƿֽ����level
                           % c: wpeak���У�ʵ���Ͼ������ݳ���points
% ��ÿһ��С���ֱ���д���
for m=1:r
    frame=find(wpeak(m,:));  % frame���е�m��ģ����ֵ�ĵ�ַ���±꣩
    num_interval=length(frame)-1; % ����ģ����ֵ�ĸ���-1����ģ����ֵ���ֳ���������
   
    % ���ҵ���ģ���󻮷ֵ�����, Ȼ���ÿһ�������PyͶӰ���������Py.m��
      for j=1:num_interval
          interval=w1(m,frame(j):frame(j+1));  % ��m����j�������С���任��ֵ����ʼֵ���������
          len=length(interval);                % ��m����j�����䳤��
             if len>2                          % ��������Ҫ����2������������
                w1(m,frame(j):frame(j+1))=P_y(interval,len); % ��PyͶӰ���µ�m����j�������С���任��ֵ
             end                                             % PyͶӰ�����Py.m
      end
  
      % ����һ�������PgamaͶӰ
      for j=1:num_interval
          interval=err(m,frame(j):frame(j+1));   % ���interval�������intervalû�й�ϵ�������������������
          if r==1                                % err������μ�function������һ��
              err(m,frame(j):frame(j+1))=P_gama(interval,level,sr); % ������P_gamaͶӰ
          else
              err(m,frame(j):frame(j+1))=P_gama(interval,m,sr);
          end
      end
      w2(m,:)=w1(m,:)+err(m,:);    %�����ͶӰֵ�ӵ�����P_yͶӰ������
end
