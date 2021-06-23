% Half-Wave Rectifier Circuit
% Vs(t) = Asin(wo*t)
% A = 5V wo = 2pi RL = 1ohm

t = linspace(0,5,1000);
w0 = 2*pi;
Vs = (5-0.7)*sin(w0*t); % Define source voltage with ideal diode voltage drop
Vl = Vs;
for t1 = 1:length(t)
    if Vl(t1) < 0
        Vl(t1) = 0;
    end
end

figure(1)
plot(t,Vl);
title('V_L(t) Plot for Half-Wave Rectifier');
xlabel('time (s)');
ylabel('V_L(t) (V)');

j = sqrt(-1);

N = [4 10 22 46];       % Define +/- harmonic values at which to truncate FS
X0 = 4.3;               % Amplitude = 5 - 0.7 = 4.3 V

figure(2)
for i = 1:4             % Compute truncated FS for harmonic values
    f = zeros(size(t)); % start out with DC bias term
    
    for k = -N(i):N(i)                  % Loop over index k
        if mod(k,2) == 0
            Ck = -X0/(pi*(k.^2-1));     % FS coefficient (even)
        elseif k == -1 || k == 1
            Ck = -1*j*k*(X0/4);         % FS coefficient (-1 and 1)
        else
            Ck = 0;                     % FS coefficient (odd)
        end
        f = f + real(Ck*exp(j*k*w0*t)); % FS computation
    end

    subplot(2,2,i); % Plot truncated FS representation of square wave
    plot(t,f);      % and actual signal
    hold on;

    xlabel('t (s)');
    ylabel('f(t)');
    titlevec = ['Truncated f(t) FS for n = ' num2str(-N(i)),',..,',num2str(N(i))];
    title(titlevec);
end

        