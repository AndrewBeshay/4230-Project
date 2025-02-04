function [Shape, Centroid, Orientation] = identifyAllGreenShapes2(myPatternBW, ...
    table_ImgBW)

    circle = 2.1;
    flower = 2.2;
    diamond = 2.3;
    square = 2.4;
    star4 = 2.5;
    star6 = 2.6;
    
    % identify all the shapes that exist in the pattern for that colour
    s = regionprops(myPatternBW, 'Centroid');
    centroids = vertcat(s.Centroid);
    Shape = [];
    Centroid = [];
    Orientation = [];
    
    for i = 1: size(centroids,1)
        blockBW = removeOtherShapes(table_ImgBW, centroids(i,:));
        shapeBW = removeOtherShapes(myPatternBW, centroids(i,:));
        s = regionprops(shapeBW, 'Area', 'Perimeter', 'MajorAxisLength', 'EquivDiameter');
        diff = abs(s.MajorAxisLength - s.EquivDiameter);
        if s.Area > 1300
            % either circle or flower
            
            if diff < 2
                Shape = [Shape; circle];
            else 
                Shape = [Shape; flower];
            end
            
        elseif s.Area > 925 
            % either flower, diamond or square            
            if diff > 2.77
                Shape = [Shape; flower];
            else 
                shapeBW = rotateToOriginal(shapeBW, blockBW);
                seSquare = strel('Square', 26);
                shapeBW2 = imopen(shapeBW, seSquare);
                a = find(shapeBW2);
                
                if length(a) > 0
                    Shape = [Shape; square];
                else 
                    Shape = [Shape; diamond];
                end
                
            end
            
        else 
            % 4 star or 6 star
            if s.MajorAxisLength > 38.5
                Shape = [Shape; star4];
            else
                Shape = [Shape; star6];
            end
            
        end
        
        Centroid = [Centroid; centroids(i,:)];
        angle = calculateAngle(blockBW);
        Orientation = [Orientation; angle];
    end
    
end