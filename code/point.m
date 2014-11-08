classdef point    
    properties
        x 
        y
    end
    
    methods
        function obj = point(newX,newY)
           obj.x = newX;
           obj.y = newY;
        end
        
        function result = eq(obj,otherPoint)
           result = obj.x == otherPoint.x  && obj.y == otherPoint.y;
        end
    end
    
end

