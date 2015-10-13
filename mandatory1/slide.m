function [contrast, corr, energy, homo] = slide(img, offset , G, cutoff)
    

    padsize = (G-1)/2;
   
    [M,N]=size(img);
    imgpad =  padarray(img,[padsize, padsize],'symmetric');

    tempglcm = zeros(G);
    
    
    contrast = 0;
    corr = 0;
    energy = 0;
    homo = 0;
  
    
    iters = 0;
    for m = 1:M-G
        for n = 1:N-G
            if (cutoff > rand)
                window = imgpad(m:m+G, n:n+G);
                glcms = graycomatrix(window,'Offset',offset);

                stats = graycoprops(glcms,'all');

                
                contrast=contrast + stats.Contrast;
                if not(isnan(stats.Correlation))
                    corr = corr + stats.Correlation;
                end
                energy = energy + stats.Energy;
                homo = homo + stats.Homogeneity;
                iters = iters + 1;
            end 
        end
        
    end
    contrast = var(contrast/(iters));
    corr = var(corr/(iters));
    energy = var(energy/(iters));
    homo = var(homo/(iters));

    
    
    