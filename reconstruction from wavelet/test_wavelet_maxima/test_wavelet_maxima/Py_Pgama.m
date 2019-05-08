% 该函数用于进行 Pgama 和 Py 投影 
function  w2=Py_Pgama(w1,wpeak,wframe,level,sr)
err=wpeak-w1.*(wpeak~=0);  %模极大值序列与重构信号小波变换在极值点上的误差序列
w2=zeros(size(wpeak));     % w2
[r,c]=size(wpeak);         % r: wpeak的行，实际上就是分解层数level
                           % c: wpeak的列，实际上就是数据长度points
% 对每一级小波分别进行处理
for m=1:r
    frame=find(wpeak(m,:));  % frame含有第m级模极大值的地址（下标）
    num_interval=length(frame)-1; % 这是模极大值的个数-1，即模极大值划分出的区间数
   
    % 先找到以模极大划分的区间, 然后对每一区间进行Py投影（详见函数Py.m）
      for j=1:num_interval
          interval=w1(m,frame(j):frame(j+1));  % 第m级第j个区间的小波变换的值，初始值是输入参数
          len=length(interval);                % 第m级第j个区间长度
             if len>2                          % 长度最少要大于2，才有意义做
                w1(m,frame(j):frame(j+1))=P_y(interval,len); % 用Py投影更新第m级第j个区间的小波变换的值
             end                                             % Py投影计算见Py.m
      end
  
      % 再逐一区间进行Pgama投影
      for j=1:num_interval
          interval=err(m,frame(j):frame(j+1));   % 这个interval和上面的interval没有关系，仅借用了这个变量名
          if r==1                                % err的意义参见function名称下一行
              err(m,frame(j):frame(j+1))=P_gama(interval,level,sr); % 误差采用P_gama投影
          else
              err(m,frame(j):frame(j+1))=P_gama(interval,m,sr);
          end
      end
      w2(m,:)=w1(m,:)+err(m,:);    %将误差投影值加到上述P_y投影，返回
end
