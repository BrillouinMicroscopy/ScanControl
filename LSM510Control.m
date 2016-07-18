classdef LSM510Control < handle
%LSM510Control Wrapper for controlling the LSM510 via CAN and Zen2009
    properties (Access = private)
        can;
        zen;
    end
    properties (Dependent)
        position;
    end
    
    methods
        %% Constructor
        function obj = LSM510Control()
            obj.can = CANControl('COM1',9600);
            obj.zen = '';
        end
        
        %% Destructor
        function delete (obj)
            obj.can.delete();
        end
        
        %% Initialize the stage
        function init (~)
        end
        
        %% Set the position
        function set.position (obj, position)
            obj.can.focus.z = position(3);
        end
        
        %% Get the position
        function position = get.position (obj)
            x = NaN;
            y = NaN;
            position = [x y obj.can.focus.z];
        end
        
        %% Move relative
        function moveRelative (obj, distance)
            obj.can.focus.z = obj.can.focus.z + distance(3);
        end
    end
end