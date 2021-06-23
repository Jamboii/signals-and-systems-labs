t = zeros(1,11);    % Define time range
y = zeros(1,11);    % Define y[n] range
x = y;              % Define x[n] range
x(t>=0) = 1;        % Define x[n] as step function

xinit  = 0;
y1init = 0;         % Define inital conditions: y[-1]
y2init = 0;         % y[-2]

for n=1:11          % Apply transfer function based on value of n
    x(n) = x(n) * 0.8.^(n-1);
    if n==1
        % y(0) = 2*x(0) - 3*x(-1) + 4*x(-2) + 1.5*y(-1) + 0.9*y(-2);
        y(n) = 2*x(n) - 3*xinit + 4*xinit + 1.5*y2init + 0.9*y1init; 
        t(n) = n-1;
    elseif n==2
        % y(1) = 2*x(1) - 3*x(0) + 4*x(-1) + 1.5*y(0) + 0.9*y(-1);
        y(n) = 2*x(n) - 3*x(n-1) + 4*xinit + 1.5*y(n-1) + 0.9*y2init; 
        t(n) = n-1;
    else
        y(n) = 2*x(n) - 3*x(n-1) + 4*x(n-2) + 1.5*y(n-1) + 0.9*y(n-2);
        t(n) = n-1;
    end
end

num = [2 -3 4];
den = [1 -1.5 -0.9];
[A,B,C,D] = tf2ss(num,den)  % Define state space representation using transfer function

% x1[n+1] = 1.5x1[n] + 0.9x2[n] + 1u[n]
% x2[n+1] = x1[n]
% y[n] = 5.8x2[n] + 2u[n]

subplot(1,2,1);     % Plot x[n]
stem(t,x)
title('x[n]'), xlabel('sample (n)'), ylabel('x[n]')
subplot(1,2,2);     % Plot y[n]
stem(t,y)
title('y[n]'), xlabel('sample (n)'), ylabel('y[n]')
