function agents = initAgents(grid, nPeople)

% Qualities: Home, Num Tasks, Current Location
agents = struct();

% Find Homes
[x, y] = find(grid == 4);

coordinates = [x, y];

% Assign Homes
currentC = 1;
counter = 0;
for i = 1:nPeople
    if counter == 5
        counter = 0;
        currentC = currentC + 1;
    end
    agents(i).home = coordinates(currentC, :);
    agents(i).currentL = agents(i).home;
    agents(i).nTasks = 0;
    agents(i).eatOut = 0;
    counter = counter + 1;
end

