%����һ������Ϊ1024������Ϊ��0��1.023��������Ϊ���ף�1��Fig. 3������
%�����ϲ����ô���з������������棬��������һ������������ function signal_fig1;
function y = signal_fig1
B = 0.9*(1 - abs(0.32-0.16).^0.25);
A = 0.7 - B;
x0 = 0.06;
x1 = 0.16;
x2 = 0.32;
x44 = 0.44;
x3 = 0.6;
x4 = 0.7;
x5 = 0.8;
x6 = 0.88;
t = 0:0.001:1.023;
N = size(t,2);
y = zeros(1,N);
for n = 0:N-1
    x = n / 1024;
    if x < x0
        y(n+1) = 0.9*(1 - abs(x0-x1).^0.2);
    else if x <= x1
            y(n+1) = 0.9*(1 - abs(x-x1).^0.2);
        else if x< x2
                y(n+1) = 0.9*(1 - abs(x-x1).^0.25);
            else if x < x3
                    y(n+1) = 0.9*(1 - abs(x2-x1).^0.25);
                    else if x <x5
                            y(n+1) = A / (1 + exp(-60*(x-x4))) + B;
                        else if x < 0.88
                                y(n+1) = A / (1 + exp(-100*(x6-x4))) + B;
                            else
                                y(n+1) = 0.9*(1 - abs(x0-x1).^0.2);
                            end
                        end
                    end
            end
        end
    end
end
y(round(x44*1024+1))=y(round(x1*1024+1));



% Reference: S. Mallat, W. L. Hwang, Singularity detection and processing
% with wavelet [J], IEEE Transactions on Information Theory, 1992, 38(2):
% 617-643
