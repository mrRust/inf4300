function [img3] = glcm(img, g)
    [M N z] = size(img);
    M = M-mod(M, g);
    N = N-mod(N, g);
    
    img1 = img(1:M, 1:N, 1);
    img2 = bitshift(img1, -5);
       
    img3 = zeros(M,N);

    for m = 1:g:(M-g)
        for n = 1:g:(N-g)
            % Double forloop for each g*g square om the picture.
            for p = m:m+8
                for q = n:n+7
                % Running throug each square on picture
                    v1 = double(img2(p, q));
                    v2 = double(img2(p, q+1));
            
                    img3(m+v1, n+v2) = img3(m+v1, n+v2) + 1;                  
                end
            end 
        end
    end
    img3 = img3/((g-1)*(g-1))
end