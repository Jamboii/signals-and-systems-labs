load handel.mat

file = 'handel.wav';

[x,Fs] = audioread(file); % save original data to array with sampling rate

sound(x,Fs); % play original full file
pause(11);

tau = 0.5; % 500 ms delay
alpha = 0.7; % attenuation factor
D = tau*Fs; % total delay

y = zeros(size(x)); % set up echo matrix
y(1:D) = x(1:D);

for n=D+1:length(x) 
    y(n) = alpha*y(n-D) + x(n); % using equation from (1)
end

sound(y,Fs); % play echoed file