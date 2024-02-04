function grid = initGrid(gridSize, nCompetitorsOutsideCenters)
grid = zeros(gridSize, gridSize);

% Calculate radius for approximately 1000 cells
A = 1000; % Target area in cells
r = sqrt(A / pi);

% Define center points for neighborhood centers
centers = [0.75*gridSize - 1 + 1, 0.25*gridSize - 2 + 1;  % Adjusted to account for MATLAB indexing
           0.25*gridSize - 1 + 1, 0.75*gridSize - 2 + 1];

% Mark residential areas around neighborhood centers
for idx = 1:size(centers, 1)
    centerX = centers(idx, 1);
    centerY = centers(idx, 2);
    for i = max(1, floor(centerX - r)):min(gridSize, ceil(centerX + r))
        for j = max(1, floor(centerY - r)):min(gridSize, ceil(centerY + r))
            % Check if the cell is within the radius and currently unassigned (0)
            if sqrt((i - centerX)^2 + (j - centerY)^2) <= r && grid(i, j) == 0
                grid(i, j) = 4;
            end
        end
    end
end

% Mall
for i = 1:5
    for j = 1:5
      grid(i,j) = 3;  
    end
end

% Neighborhood Centers bottom left
x = 0.75*gridSize - 1;
y = 0.25*gridSize - 4;

for i = 1:2
    for j = 1:5
        grid(i+x,j+y) = 2;
    end
end

% Neighborhood Centers upper right
x = 0.25*gridSize - 1;
y = 0.75*gridSize - 4;

for i = 1:2
    for j = 1:5
        grid(i+x,j+y) = 2;
    end
end

% Highway
for i = 1:gridSize
    grid(49, i) = 5;
    grid(50, i) = 5;
end

% Highway Entrance/Exits
grid(49,0.25 *gridSize) = 6;
grid(50,0.25 *gridSize) = 6;
grid(49,0.75 * gridSize) = 6;
grid(50,0.75 * gridSize) = 6;

% Residents Outside of Residential Areas
counter = 0;
while counter < 1026
    randx = randi(gridSize);
    randy = randi(gridSize);
    if(grid(randx, randy) == 0)
        grid(randx, randy) = 4 ;
        counter = counter + 1;
    end
end

% Competitors disperse randomly outside centers/malls
counter = 0;
while counter < nCompetitorsOutsideCenters
    randx = randi(gridSize);
    randy = randi(gridSize);
    if(grid(randx, randy) == 0)
        grid(randx, randy) = 1;
        counter = counter + 1;
    end
end

imagesc(grid);
colorbar; % Shows the color scale for reference
axis equal tight;

% Define a new custom colormap
customColormap = [0.75 0.75 0.75; ... % Color for 0 (black)
                  1 0 0; ... % Color for 1 (red) - Competitors
                  0 0 1; ... % Color for 2 (blue) - Neighborhood Centers
                  0 0 0.5; ... % Color for 3 (dark blue) - Mall
                  .25 .25 .25; ... % Color for 4 (white) - Residential Areas
                  1 1 0; ... % Color for 5 (yellow) - Highway
                  1 0.647 0]; % Color for 6 (orange) - Highway Entrance/Exits

% Apply the new custom colormap
colormap(customColormap);

% Adjust the color scale limits to include 0 to 6
caxis([0 6]);