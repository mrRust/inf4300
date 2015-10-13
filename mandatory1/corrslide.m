function [contrastimg, corrimg, energyimg, homoimg] = slide(img, offset , G, speedup)

    padsize = (G-1)/2;
    [M,N]=size(img);
    corrimg = zeros(M, N);
    imgpad =  padarray(img,[padsize, padsize]);
    energy = 0;
    parfor m = 1:M-1
        for n = 1:N-1
            %{
            When speedup >1, the algoritem will reuse values to run faster.
            The result will be less accurate, used for testing. What values
            that are reused, will be chosen randomly.
            %}
            if ((1/speedup) > rand)
                % Find glcm new values
                window = imgpad(m:m+G, n:n+G);
                glcms = graycomatrix(window,'Offset',offset);
                stats = graycoprops(glcms,'all');
                
                %Contrast
                contrast = var(stats.Contrast)
                contrastimg(m, n) = contrast
                
                %Correlation
                if not(isnan(stats.Energy))
                    corr = var(stats.Correlation);
                    corrimg(m, n) = corr;
                end
                %Energy
                energy = var(stats.Energy)
                energyimg(m, n) = energy
                
                %Homogeneity
                homo = var(stats.Homogeneity)
                homoimg(m, n) = homo
            else
                % Values are beeing reused. 
                contrastimg(m, n) = contrast
                corrimg(m, n) = corr;
                energyimg(m, n) = energy
                homoimg(m, n) = homo
            end
        end
    end
   


    