%% GLCM window test
clear all;
img= imread('zebra_1.tif');
img1 = img(190:200, 190:200)
img2 = glcm2(img1, 2, 0, 8);

%% GLCM Features test
[M N] = size(img2);

img_v = 0; %Variace
img_c = 0; %Contrast
img_e = 0; %Entropy
avg = 1/(M*N);
for m = 1:M
    for n = 1:N        
        img_v = img_v + (avg-img2(m,n))^2;
        if (m ~= n)
            img_c = img_c + (img2(m, n)*(m-n)^2);
        end
        if(img2(m,n) ~= 0)
            img_e = img_e -(img2(m, n)*log(img2(m,n)))
        end
    end
end

img_v = img_v/(M*N)
img_c = img_c/(M*N)
img_e = img_e/(M*N)
%% Computing GLCM features sliding window
ws = 7;
cutoff = 2;
dx = 2;
dy = 2;
levels = 8;
glcm_img = zeros(ws);
img = imread('zebra_1.tif');
img2 = double(img);
[M N] = size(img2);
var_img = zeros(M,N);
con_img = zeros(M,N);
ent_img = zeros(M,N);

for m=1+cutoff:M-cutoff-ws
    for n=1+cutoff:N-cutoff-ws
        glcm_img = glcm2(img2(m:m+ws, n:n+ws), dx, dy, ws);
        % GLCM features
        img_v = 0;
        img_c = 0;
        img_e = 0;
        for k = 1:ws
            for j = 1:ws        
                img_v = img_v + (avg-glcm_img(k,j))^2;
                if (k ~= j)
                    img_c = img_c + (glcm_img(k, j)*(k-j)^2);
                end
                if(glcm_img(k,j) ~= 0)
                    img_e = img_e -(glcm_img(k, j)*log(glcm_img(k,j)));
                end
            end
        end
        var_img(m,n) = img_v;
        ent_img(m,n) = img_e;
        con_img(m,n) = img_c;
        
    end
end
%%
img3 = img2/256;

figure(1)
subplot(221)
imshow(img3)
subplot(222)
imshow(var_img)
subplot(223)
imshow(ent_img)
subplot(224)
imshow(con_img)
avg_var = mean(var_img(:))
avg_con = mean(con_img(:))
avg_ent = mean(ent_img(:))
figure(2)


img4 = ((var_img < 0.5)+0);
img5 = ((con_img > 0.5)+0);
img6 = ((ent_img > 0.7)+0);
subplot(222)
imshow(img4)
subplot(223)
imshow(img5)
subplot(224)
imshow(img6)
figure(3)
[M N] = size(img6)


