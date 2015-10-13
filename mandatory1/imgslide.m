function [contrastimg, corrimg, energyimg, homoimg] = imgslide(img, offset , G, speedup)
    % Assigning variables
    padsize = (G-1)/2;
    imgpad =  padarray(img,[padsize, padsize]);
    [M,N]=size(img);
    
    corrimg = zeros(M, N);
    contrastimg = zeros(M, N);
    energyimg = zeros(M, N);
    homoing = zeros(M, N);
    contrast = 0;
    corr = 0;
    energy = 0;
    homo = 0;
    
    for m = 1:M
        for n = 1:N
            %{
            When speedup >1, the algoritem will reuse values to run faster.
            The result will be less accurate, used for testing. What values
            that are reused, will be chosen randomly.
            %}
            if ((1/speedup) > rand)
                % Find glcm new values
                window = imgpad(m:m+G-1, n:n+G-1);
                glcms = graycomatrix(window,'Offset',offset);
                stats = graycoprops(glcms,'all');
                
                %Contrast
                contrast = mean(stats.Contrast);
                contrastimg(m, n) = contrast;
                
                %Correlation
                if not(isnan(stats.Energy));
                    corr = mean(stats.Correlation);
                    corrimg(m, n) = corr;
                end
                %Energy
                energy = mean(stats.Energy);
                energyimg(m, n) = energy;
                
                %Homogeneity
                homo = mean(stats.Homogeneity);
                homoimg(m, n) = homo;
            else
                % Values are beeing reused. 
                contrastimg(m, n) = contrast;
                corrimg(m, n) = corr;
                energyimg(m, n) = energy;
                homoimg(m, n) = homo;
            end
        end
    end
    % Normalize then histogramequalize then median filter on each picture.
    
    contrastimg = histeq(mat2gray(contrastimg));
    corrimg = histeq(mat2gray(corrimg));
    energyimg = histeq(mat2gray(energyimg));
    homoimg = histeq(mat2gray(homoimg));
   


    