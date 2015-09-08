function [h] = histogram(img)
    [M N z] =  size(img)
    x = 0:255
    H = zeros(255, 1)
    for m = 1:M
        for n = 1:N
            H(img(m, n)) = H(img(m, n)) + 1;
        end
    end
    bar(H)
        
    

end