figure(1); clf;         % Open and clear Figure 1

To = 5;                 % Define fundamental period, frequency and j
wo = 2*pi/To; 
j = sqrt(-1); 

t = 0:0.01:10;          % Define time range

N = [3 9 21 45];        % Define +/- harmonic values at which to truncate FS

for i = 1:4             % Compute truncated FS for harmonic values
    f = zeros(size(t)); % start out with DC bias term
    
    for k = -N(i):2:N(i)                % Loop over index k (odd)
        Ck = 2/(j*k*wo);                % FS coefficient
        f = f + real(Ck*exp(j*k*wo*t)); % FS computation
    end

    subplot(2,2,i); % Plot truncated FS representation of square wave
    plot(t,f);      % and actual signal
    hold on;

    xlabel('t ');
    ylabel('f(t)');
    titlevec = ['Truncated f(t) FS for n = ' num2str(-N(i)),',..,',num2str(N(i))];
    title(titlevec);
end
