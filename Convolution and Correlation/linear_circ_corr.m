% Compute linear and circular convolution
% A Length 3 sequence
x = 0:1:5;
h = x;
% x = [2 1 2 1];
% y = [1 2 3 4];
% c = cconv(x,y,4);
% y = CrossCorr(x,h);
% fprintf('  mine \n')
% disp(y);
% fprintf('  inbuit \n')
% disp(xcorr(x,h))
% y = CrossCorr(x,h);
% disp(y);
figure(1)
subplot(5,1,1)
stem([x zeros(1,10-length(x))]);
xlim([1,10]);
title('1st Signal x(n)');

subplot(5,1,2)
stem([h,zeros(1,10-length(h))]);
xlim([1,10]);
title('2nd Signal h(n)');

subplot(5,1,3);
stem(LinearConv(x,h));
xlim([1,10]);
title('Linear convolution');

subplot(5,1,4)
stem(CircConv(x,h));
xlim([1,10]);
title('Circular Convolution');

subplot(5,1,5);
stem(CrossCorr(x,h));
xlim([1,10]);
title('Cross Correlation');


% difference between convolution and cross-correlation is, for conv one
% signal is reversed before moving right over the other signal

% https://www.entcengg.com/linear-convolution-matlab-program/
% https://dsp.stackexchange.com/questions/27451/the-difference-between-convolution-and-cross-correlation-from-a-signal-analysis
function y = LinearConv(x,h)
n1 = length(x);
n2 = length(h);
n3 = n1+n2-1;
% y(n) = sum(1,M) x(k)*h(n-k);
x = [x zeros(1,n3-n1)];
h = [h zeros(1,n3-n2)];
y = zeros(1,n3);
for n = 1:n3
    for k = 1:n2
        if(n-k+1>0) % else values will be zeros
            y(n) = y(n)+ x(k)*h(n-k+1);
        end
    end
end
end

% Cross correlation
function y = CrossCorr(x,h)
% assuming n1 <= n2
% matches with original xcorr of n1<= n2
n1 = length(x);
n2 = length(h);
n3 = n1+n2-1;
% y(n) = sum(1,M) x(k)*h(n+k);
x = [x zeros(1,n3-n1)];
h = [h zeros(1,n3-n2)];
y = zeros(1,n3);
for n = 1:n3
    for k = 1:n
        if(n2-n+k>0 && k<=n1)
            y(n) = y(n)+x(k)*h(n2-n+k);
        end
    end
end
end
 
% circular convolution
function y = CircConv(x,h)
n1 = length(x);
n2 = length(h);
n3 = max(n1,n2);
% y(n) = sum(1,M) x(k)*h(n-k);
x = [x zeros(1,n3-n1)];
h = [h zeros(1,n3-n2)];
y = zeros(1,n3);
for n = 0:n3-1
    y(n+1) = 0;
    for k = 0:n3-1
        j = mod(n-k,n3);
        y(n+1) = y(n+1)+ x(k+1)*h(j+1);
    end
end
end
