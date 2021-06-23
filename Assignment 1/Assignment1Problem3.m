t = zeros(1,11);    % Define time range
y = zeros(1,11);    % Define y[n] range
x = y;              % Define x[n] range
x(t>=0) = 1;        % Define x[n] as step function

y1init = 0;         % Define inital conditions: y[-1]
y2init = 1;         % y[-2]

a = 1.7;            % Define gain values
b = -0.72;

for n=1:11          % Apply transfer function based on value of n
    if n==1
        y(n) = x(n) + a*y1init + b*y2init; % y[n] = x[n] + 1.7y[-1] - 0.72y[-2]
        t(n) = n-1;
    elseif n==2
        y(n) = x(n) + a*y(n-1) + b*y1init; % y[n] = x[n] + 1.7y[0] - 0.72y[-1]
        t(n) = n-1;
    else
        y(n) = x(n) + a*y(n-1) + b*y(n-2); % y[n] = x[n] + 1.7y[n-1] - 0.72y[n-2]
        t(n) = n-1;
    end
end

subplot(1,2,1);     % Plot x[n]
stem(t,x)
title('x[n]')
subplot(1,2,2);     % Plot y[n]
stem(t,y)
title('y[n]')
