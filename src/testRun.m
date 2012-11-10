
clear; close all;

grid = zeros(64,64);

%grid([13 14 15], [13 15 16]) = 1;
%grid(10,10) = 1;
%grid(3, 1:3)  = 1;
%grid(2, 3) = 1;
%grid(1, 2) = 1;

gameOfLife = GameOfLife(grid);
%insert(gameOfLife, 'glider', [5 5]);
%insert(gameOfLife, 'LWSS', [15 4]);
%insert(gameOfLife, 'block', [50 50]);
%insert(gameOfLife, 'blinker', [50 15]);
insert(gameOfLife, 'acorn', [10 10]);

figure;
updateNeighbors(gameOfLife)
plot(gameOfLife)

run(gameOfLife, 500, 0.01)


