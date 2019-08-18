function [patternProps, conveyorList] = Main5_RemoveFromList(patternProps, conveyorList, coordinatePattern, coordinateConveyor)

distance = sqrt( (patternProps.Centroid(:,1) - coordinatePattern.Centroid(1)).^2 + (patternProps.Centroid(:,2) - coordinatePattern.Centroid(2)).^2 );
furthestIdx = find(distance == min(distance));
patternProps.Colour(furthestIdx) = [];
patternProps.Shape(furthestIdx) = [];
patternProps.Centroid(furthestIdx,:) = [];
patternProps.Orientation(furthestIdx) = [];

distance = sqrt( (conveyorList(:,1) - coordinateConveyor(1)).^2 + (conveyorList(:,2) - coordinateConveyor(2)).^2 );
furthestIdx = find(distance == min(distance));
conveyorList(furthestIdx,:) = [];

end