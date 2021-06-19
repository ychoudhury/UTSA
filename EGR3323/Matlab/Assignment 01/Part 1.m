%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 1
[x,y] = meshgrid(-2:.2:2, -2:.2:2);
vector1 = x;
vector2 = -y;
figure(1)
quiver(x,y,vector1,vector2)
title('Graphing Vector Fields in MATLAB')

[x,y] = meshgrid(-2:.2:2, -2:.2:2);
vector1 = y;
vector2 = -x;

figure(2)
quiver(x,y,vector1, vector2)
title('Graphing Vector Fields in MATLAB part 2')
