% Main Simulation

% Initialize Model Parameters

clc
clear all
close all

% Residential: 1/3 area ~5 people per cell
% Highway Entrances: 2
% Mall: 5x5
% Strip Mall/Neighborhood Center: 5x2

nruns = 30;
gridSize = 100;

nPeople = 15000;
stayHomePercentage = 0.25;
nCompetitors = 20;
nCompetitorsOutsideCenters = nCompetitors/2;

%Strategies
%Strategy 1: convenience via City Center
%Strategy 2: convenience via Neighborhood Center
%Strategy 3: Neighborhood
strategy = 3; % Defining strategy to analyze

%Generate my store location dependent on strategy
counter = 0;

%Initialize all models
grid = initGrid(gridSize, nCompetitorsOutsideCenters);
agents = initAgents(grid, nPeople);
stores = initStores(grid, nCompetitors, strategy);

% Simulation
for runs = 1:nruns
    for i = 1:nPeople %for each agent
        agents(i).nTasks = randi(3) - 1;
        threshold = 1 - (agents(i).nTasks*0.2) - 0.2;
        rF = rand;
        if (rF > threshold)
            agents(i).eatOut = 1;
            counter = counter + 1;
        else
            agents(i).eatOut = 0;
        end

        %Agents go to work
        agents(i).currentL = [50,1];
        [x, y] = find(grid == 6);
        coordinates = [x, y];

        if(agents(i).eatOut ~= 0) %if not going straight home
            %if at highway entrance
            agents(i).currentL = coordinates(randi(length(coordinates)),:);
            j = 0;
            if(agents(i).nTasks == 1) %if agent is going strip mall
                if(rand < 0.7)
                    temp = [stores(11), stores(12)];
                    j = findShortestLocation(agents(i).currentL, temp) + 10;
                else %eat at random ahh restaurant
                    j = randi(length(stores));
                end
            elseif(agents(i).nTasks == 2)%if agent is going to mall
                if(rand < 0.5)
                    j = 13;
                else %eat at random ahh restaurant
                    j = randi(length(stores));
                end
            
            else %if agent is going home first bc no tasks
                agents(i).currentL = agents(i).home;
                threshold = 0.5;
                rF = rand;
                if(rF < threshold) %we eat at closest restaurant
                    j = findShortestLocation(agents(i).currentL, stores);
                else %eat at random ahh restaurant
                    j = randi(length(stores));
                end
            end
            stores(j).incrementor = stores(j).incrementor+1;
        end
        agents(i).currentL = agents(i).home;
    end
end

% Results
s1 = stores(13).incrementor/5; %City Center
s2 = (stores(12).incrementor + stores(11).incrementor)/8; %Neighborhood Center
s3 = 0;
for i = 1:10
    s3 = s3 + stores(i).incrementor;
end
s3 = s3/10;
data = [s1,s2,s3];

% Create the bar graph with customizations
figure; % Opens a new figure window
bar(data, 'FaceColor', [0.2, 0.2, 0.5], 'EdgeColor', 'none', 'BarWidth', 0.7);

% Optional: Add labels and title
xlabel('Strategies');
ylabel('Num Customers Over 30 days');
title('Strategy Analysis');

