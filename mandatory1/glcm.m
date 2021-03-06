function p = glcm2(img, dy, dx, G)
    [M, N, z] = size(img);
    img1 = double(img(:,:,1));
    goal = log2(G);    
    currentlevel = ceil(log2(max(img1(:))));
    shift = floor(goal-currentlevel);
    
    img2 = bitshift(img1, shift);
    %Shifting complete. 
    
    
    p = zeros(G);
    
    start_m = max(1, 1-dy);
    start_n = max(1, 1-dx);
    stop_m = min(M, M-dy);
    stop_n = min(N, N-dx);
    % Indexing start and stop complete
    for m = start_m:stop_m
        for n = start_n:stop_n
          
            p(img2(m, m+dy)+1, img2(n, n+dx)+1) =   p(img2(m, m+dy)+1, img2(n, n+dx)+1) +1;
   
        end
    end
 
    
    p = p/((stop_m-start_m+1)*(stop_n-start_n+1));

end