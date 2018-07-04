classdef ScanControl < handle
%ScanControl Wrapper for the different scanning stages ('LSM510' and 'XPS')
    properties (Access = private)
        device;
    end
    properties (Dependent)
        position;
    end
    
    methods
        %% Constructor
        function obj = ScanControl(device)
            if strcmp(device,'LSM510')
                obj.device = Utils.ScanControl.LSM510Control();
            elseif strcmp(device,'XPS')
                disp('Device not implemented.');
                % connection.IP = '192.168.0.254';    % IP Adress of the Controller
                % connection.Port = 5001;             % Port number of the Controller
                % connection.TimeOut = 60;            % Timeout to use
                
                % settings.velocity = 1;              % [mm/s]    velocity of the stage
                % settings.acceleration = 1;          % [mm/s^2]  acceleration of the stage
                
                % % Connect to the controller via TCP
                % obj.device = XPS(connection.IP, connection.Port, connection.TimeOut);
                % % Initialize the home position of the stages
                % obj.device.init();
                
                % % set parameters of the translation
                % obj.device.set(settings);
            end
        end
        
        %% Destructor
        function delete (obj)
            obj.device.delete();
        end
        
        %% Initialize the stage
        function init (obj)
            obj.device.init();
        end
        
        %% Set the position
        function set.position (obj, position)
            obj.device.position = position;
        end
        
        %% Get the position
        function position = get.position (obj)
            position = obj.device.position;
        end
        
        %% Move relative
        function moveRelative (obj, distance)
            obj.device.moveRelative(distance);
        end
    end
end