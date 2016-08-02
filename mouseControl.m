%% Configure parameters
% get the screen size
scaling = 1.5;          % scaling factor for high resolution devices
set(0,'units','pixels');
screenSize = scaling*get(0, 'screensize');

% parameters of the area to click in
areaPosition = [800; 118];
width = [1130; 1130];

% number of different positions
nrPositions = [2; 2];

if ~exist('stage','var') || ~isa(stage,'ScanControl')
    stage = ScanControl('LSM510');
end

%%
pos.x = areaPosition(1) + width(1)/(nrPositions(1)-1)*((1:nrPositions(1))-1);
pos.y = areaPosition(2) + width(2)/(nrPositions(2)-1)*((1:nrPositions(2))-1);

pos.x = linspace(1280, 1315, 30);
pos.y = linspace(780, 815, 30);

mouseMove = moveAndClick();

mouseMove.move(areaPosition(1), areaPosition(2));
for ii = 1:length(pos.x)
    for jj = 1:length(pos.y)
        stage.position = [pos.x(ii), pos.y(jj), 0];
        pause(0.05);
    end
end
