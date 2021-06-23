% h(t) = e^-2t*u(t)
% square wave input: X0 = 2, C0x = 2, w0 = 1, Ckx = 4/(-j*pi*k)

w0 = 1;                     % Define fundamental frequency
j = sqrt(-1);
t = linspace(0,10,1000);    % Define time range
h = zeros(1,length(t));     % Define impulse response range

for i=1:length(t)           % Define h(t) = u(t)*e^-2t
    if(t(i)>=0)
        h(i)=exp(-2*t(i));
    else
        h(i)=0;
    end
end

w = t;                      % Set range of frequency to time range
H = zeros(1,length(w));
for k=1:length(w)
    H(k) = 1 / (j*w(k)+2);
end

figure(1)
subplot(3,1,1)
plot(t,h), title('Impulse Response Plot'), xlabel('Time (s)'), ylabel('h(t)')
subplot(3,1,2)
plot(w, abs(H)), title('Magnitude plot'), xlabel('Frequency (w)'), ylabel('|H(w)|')
subplot(3,1,3)
plot(w, angle(H)), title('Phase plot'), xlabel('Frequency (w)'), ylabel('<H(w)')

N = 99;
X0 = 2;

fx = zeros(size(t)); % start out with DC bias term

for k = -N:2:N                              % Loop over index k (odd)
    if k ~= 0
        Ckx = (2*X0)/(j*pi*k*w0);           % FS coefficient for square wave
        fx = fx + real(Ckx*exp(j*k*w0*t));  % FS computation
    else
        C0x = 2;                            % Add C0x to FS
        fx = fx + C0x;
    end
end

% sq = 2*square(t);
% Fsq = fft(sq);
Fx = fft(fx);                               % DFT of input signal
Fy = Fx.*H;                                 % Compute Y(w) = X(w)*H(w)

figure(2)
subplot(2,1,1)
plot(w,Fx), title('X(w)'), xlabel('Frequency (w)'), ylabel('X(w)')
subplot(2,1,2)
plot(w,Fy), title('Y(w)'), xlabel('Frequency (w)'), ylabel('Y(w)')

