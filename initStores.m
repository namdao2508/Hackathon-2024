function stores = initStores(grid, nCompetitors, strategy);

%Attributes: restaurant ID, incrementor, and location
stores = struct();

% Find Stores Outside of Malls
[x, y] = find(grid == 1);

coordinates = [x, y];

%Assign store locations outside of mall, initializing attributes
for i = 1:nCompetitors/2
    stores(i).location = coordinates(i, :);
    stores(i).incrementor = 0;
end

% Find Stores Inside of Neighborhood strip malls
[x, y] = find(grid == 2);

coordinates = [x, y];

%Assign store locations inside of neighborhood centers, initializing
%attributes
stores(end + 1).location = coordinates(1, :);
stores(end).incrementor = 0;

stores(end + 1).location = coordinates(11, :);
stores(end).incrementor = 0;

%Find Stores Inside of mall
[x, y] = find(grid == 3);

coordinates = [x, y];

%Assign store locations inside of malls, initializing attributes
stores(end+1).location = coordinates(1, :);
stores(end).incrementor = 0;

%Initializing my store/target store to analyze
if strategy == 1
    stores(end+1).location = 0; %change later CHANGE LATER
    stores(end).incrementor = 0;
end