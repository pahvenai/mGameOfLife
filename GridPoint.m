classdef GridPoint < handle
    %GridPoint is a periodic grid point
    %   !
    
    properties
        maxWidth
        maxHeight
        x
        y
    end
    
    methods
        function obj = GridPoint(x,y,maxWidth, maxHeight)
            obj.x = x;
            obj.y = y;
            obj.maxWidth = maxWidth;
            obj.maxHeight = maxHeight;
        end
        function addToX(obj, value)
            obj.x = obj.x + value;
            if obj.x <= 0
                obj.x = objmaxWidth - obj.x;
            else if obj.x > obj.maxWidth
                    obj.x  = obj.x - obj.maxWidth;
                end
            end
        end
        function addToY(obj, value)
            obj.y = obj.y + value;
            if obj.y < 0
                obj.y = obj.maxHeight - obj.x;
            else if obj.x > obj.maxWidth
                    obj.x  = obj.x - obj.maxWidth;
                end
            end
        end
        function translation(obj, translation)
            addToX(obj, translation(1));
            addToY(obj, translation(2));
        end
    end
    
end

