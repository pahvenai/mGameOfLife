classdef GameOfLife < handle
    %GameOfLife Simulation of Conway's Game of life
    %   This class can be used to 
    
    properties
       grid
       neighbors
       width
       height
       generation
       periodic=1
    end
    properties(Constant)
        OverPopulationLimit = 4 % at this value and beyond life is impossible
        UnderPopulationLimit = 1 % below and at this value life is impossible
        ReproductionValue = 3 % optimal conditions for life; new life generated
    end
    
    methods
        function obj = GameOfLife(booleanGrid)
           % booleanGrid is a 2D grid of boolean values
           obj.grid = booleanGrid;
           obj.width = size(obj.grid,1);
           obj.height = size(obj.grid,2);
           obj.generation = 0;
        end
        function update(obj)
            updateNeighbors(obj);
            for i=1:obj.width
                for j=1:obj.height
                    Nneighbors = obj.neighbors(i,j);
                    if obj.grid(i,j) == 1
                        if Nneighbors <= GameOfLife.UnderPopulationLimit
                            obj.grid(i,j) = 0;
                        end
                        if Nneighbors >= GameOfLife.OverPopulationLimit
                            obj.grid(i,j) = 0;
                        end
                    else
                        if Nneighbors == GameOfLife.ReproductionValue
                            obj.grid(i,j) = 1;
                        end
                    end
                end           
            end
            obj.generation = obj.generation + 1;
        end
        function updateNeighbors(obj)
            obj.neighbors = zeros(obj.width, obj.height);
            for i=1:obj.width
                for j=1:obj.height
                    if obj.periodic
                        % find directions left, right, up and down with
                        % periodic boundary conditions
                        up = j + 1;
                        if (up > obj.height); up = 1; end
                        down = j - 1;
                        if (down < 1); down = obj.height; end
                        left = i - 1;
                        if (left < 1); left = obj.width; end
                        right = i + 1;
                        if (right > obj.width); right = 1; end
                        % count the number of neighbors
                        obj.neighbors(i,j) = ...
                            sum(sum(obj.grid([left i right],[up j down]))) - ...
                            obj.grid(i,j);
                    end
                end
            end
        end
        function plot(obj)
            imshow(~obj.grid,  'InitialMagnification', 'fit');
            set(gcf, 'Color', [0.6 0.8 0.8]);
        end
        function run(obj, timesteps, speed)
            if nargin < 2
                timesteps = 100;
            end
            if nargin < 3
                speed = 0.1;
            end
            plot(obj);
            for i=1:timesteps
                pause(speed);
                update(obj);
                plot(obj);
                title(['timestep ' num2str(obj.generation)])
            end
        end
        function insert(obj, nameOfShape, location)
            shape.width = 0;
            shape.height = 0;
            switch nameOfShape
                % space ships
                case 'glider'
                    shape.width = 5; 
                    shape.height = 5;
                    grid = zeros(shape.height,shape.width);
                    grid(4, 2:4)  = 1;
                    grid(3, 4) = 1;
                    grid(2, 3) = 1;
                case 'LWSS'
                    shape.width = 7; 
                    shape.height = 6;
                    grid = zeros(shape.height,shape.width);
                    grid(2, [3 6]) = 1;
                    grid(3,2) = 1;
                    grid(4, [2 6]) = 1;
                    grid(5, 2:5) = 1;  
                % still shapes
                case 'block'
                    shape.width = 4;
                    shape.height = 4;
                    grid = zeros(shape.height,shape.width);
                    grid(2:3,2:3) = 1;
                % pulsers
                case 'blinker'
                    shape.width = 5;
                    shape.height = 3;
                    grid = zeros(shape.height,shape.width);
                    grid(2,2:4) = 1;
                % special cases
                case 'acorn'
                    shape.width = 9;
                    shape.height = 5;
                    grid = zeros(shape.height,shape.width);
                    grid(2,3) = 1;
                    grid(3,5) = 1;
                    grid(4,[2 3 6 7 8]) = 1;
            end
            for i=1:shape.height
                for j=1:shape.width
                    pos = GridPoint(i,j, obj.width, obj.height);
                    translation(pos, location-1);
                    obj.grid(pos.x, pos.y) = grid(i,j);
                end
            end
        end
    end
    
end

