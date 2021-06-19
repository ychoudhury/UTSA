%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 2

% Define the parameter t
t = [0:0.001:100];
% Compute variables x and y as functions of t
x = 10*sin((1/3.183)*t);
y = 10*cos((1/3.183)*t);

% Open a figure window and plot the helix
figure(1)
plot3(x,y,t)
grid on

title('Graphing Curves in MATLAB')
xlabel('x')
ylabel('y')


horRad = 2;
verRad = 3;
xCenter = 2;
yCenter = 1;

% Compute variables x and y as functions of t
t = [-pi:0.01:pi];

% 2,1 used as reference to ellipse center coordinates
x = xCenter + horRad*cos(t);
y = yCenter + verRad*sin(t);

figure(2)
plot(x,y)
grid on

title('Graphing Curves in MATLAB Part 2')
xlabel('x')
ylabel('y')