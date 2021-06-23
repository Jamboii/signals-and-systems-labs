A = [-4 5; 0 1];            % Define state-space matrices
B = [0; 1];
C = [1 1];
D = 2;
x0 = [1; 2];                % Define initial conditions

sys1 = ss(A,B,C,D);         % Define state-space

[num,den] = ss2tf(A,B,C,D);
sys2 = tf(num,den);         % Define transfer function

subplot(2,1,1)
initial(sys1,x0), title('Step response under initial conditions (State-space)')
subplot(2,1,2)
step(sys2), title('Step response under no initial conditions (Transfer function)')