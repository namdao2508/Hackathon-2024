function closestStore = findShortestLocation(currentL, stores)

xA = currentL(1); 
yA = currentL(2);

closestStore = -1;
closest = 500000;
for i = 1:length(stores)
    xB = stores(i).location(1);
    yB = stores(i).location(2);

    distance = sqrt((xB - xA)^2 + (yB - yA)^2);

    if distance < closest
        closest = distance;
        closestStore = i;
    end
end

