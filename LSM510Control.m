classdef LSM510Control < handle
%LSM510Control Wrapper for controlling the LSM510 via CAN and Zen2009
    properties (Access = private)
        zen;
        scanner;
    end
    properties (Transient)
        can;
    end
    properties (Dependent)
        position;
    end
    
    methods
        %% Constructor
        function obj = LSM510Control(scanner)
            obj.scanner = scanner;
            switch scanner
                case 'Scanning Mirrors'
                    obj.zen = BA_Utils.ScanControl.moveAndClick();
                case 'Translation Stage'
                    obj.can = CANControl('COM1',9600);
            end
        end
        
        %% Destructor
        function delete (obj)
            c = obj.can;
            if isa(c,'CanControl')
                c.delete();
            end
        end
        
        %% Initialize the stage
        function init (~)
        end
        
        %% Set the position
        function set.position (obj, position)
            switch obj.scanner
                case 'Scanning Mirrors'
                    obj.zen.move(position(1), position(2));
                    obj.zen.click();
                case 'Translation Stage'
                    obj.can.mcu.x = position(1);
                    obj.can.mcu.y = position(2);
                    obj.can.focus.z = position(3);
            end
        end
        
        %% Get the position
        function position = get.position (obj)
            switch obj.scanner
                case 'Scanning Mirrors'
                    position = [NaN NaN NaN];
                case 'Translation Stage'
                    x = obj.can.mcu.x;
                    y = obj.can.mcu.y;
                    z = obj.can.focus.z;
                    position = [x y z];
            end
        end
        
        %% Move relative
        function moveRelative (obj, distance)
            obj.can.focus.z = obj.can.focus.z + distance(3);
        end
    end
end