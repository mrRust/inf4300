function p = glcm2(img, dx, dy, g)
    img1 = double(img);
    goal = log2(g)    
    currentlevel = ceil(log2(max(img1(:))))
    shift = goal-currentlevel
    img2 = bitshift(img1, shift);
    %Shifting complete. 
    
    
    
    
    
    
    
end