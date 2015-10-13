%% Assigning variables
clear all;
img1 = imread('mosaic1.png');
img2 = imread('mosaic2.png');
t1offsets = [3, 4;2, 2]
t2offsets = [10, -1; -1, 10]
t3offsets = [10, -3]
t4offsets = [10, 0; 0, 10]
t5offsets = [6, 6; -6, 6]
t6offsets = [-10, 20; 0, 10]
t7offsets = [10, 1]
t8offsets = [4, 4]
G = 31    %Window size

%% Spitting up windows. 
[M, N] = size(img1);
cord1 = 1;
cord2 = M/2;
cord3 = M/2+1;
cord4 = M;
q1 = img1(cord1:cord2, cord1:cord2);
q2 = img1(cord1:cord2, cord3:cord4);
q3 = img1(cord3:cord4, cord1:cord2);
q4 = img1(cord3:cord4, cord3:cord4);
q5 = img2(cord1:cord2, cord1:cord2);
q6 = img2(cord1:cord2, cord3:cord4);
q7 = img2(cord3:cord4, cord1:cord2);
q8 = img2(cord3:cord4, cord3:cord4);
figure(1)
subplot(421)
imhist(q1)
subplot(422)
imhist(q2)
subplot(423)
imhist(q3)
subplot(424)
imhist(q4)
subplot(425)
imhist(q5)
subplot(426)
imhist(q6)
subplot(427)
imhist(q7)
subplot(428)
imhist(q8)
t1 = histeq(q1);
t2 = histeq(q2);
t3 = histeq(q3);
t4 = histeq(q4);
t5 = histeq(q5);
t6 = histeq(q6);
t7 = histeq(q7);
t8 = histeq(q8);
print('-f1','detailhist','-dpng')
    
%% Testing to algoritm with cutoff 
index = 1
summary = zeros(4, 2)
x = 0.005:0.005:0.05
for percent = x
    percent
    [corr, contrast, energy, homo] = slide(t1, offsets, G, percent);
    summary(index,1)= corr;
    summary(index,2)= contrast;
    summary(index,3)= energy;
    summary(index,4)= homo;
    index = index + 1;
end
%% Percent test run plot
figure(2)
semilogy(x*100, summary)
legend('Correlation', 'Contrast', 'Energy', 'Homogenity')
xlabel('Percent of algoritm run')
ylabel('Values')
print('-f2','Percent_test_run','-dpng')

%% Testing what spesification to use on picture 1 
offsets = [1,0; 7, 2; 0,4]
res = zeros(4);
[res(1, 1), res(1, 2), res(1, 3), res(1,4)]  = slide(t1, offsets, G, 0.04)
[res(2, 1), res(2, 2), res(2, 3), res(2,4)]  = slide(t2, offsets, G, 0.04)
[res(3, 1), res(3, 2), res(3, 3), res(3,4)]  = slide(t3, offsets, G, 0.04)
[res(4, 1), res(4, 2), res(4, 3), res(4,4)]  = slide(t4, offsets, G, 0.04)
semilogy(res')
figure(3)
semilogy(res')

%% Testing spesification on picture 2
offsets = [3, 3];
res = zeros(4);
[res(1, 1), res(1, 2), res(1, 3), res(1,4)]  = slide(t5, offsets, G, 0.01);
[res(2, 1), res(2, 2), res(2, 3), res(2,4)]  = slide(t6, offsets, G, 0.01);
[res(3, 1), res(3, 2), res(3, 3), res(3,4)]  = slide(t7, offsets, G, 0.01);
[res(4, 1), res(4, 2), res(4, 3), res(4,4)]  = slide(t8, offsets, G, 0.01);
res(:,3)*100
figure(4)
semilogy(res')


%{
Part B
%}
%% GLCM - Texture 1
[contrast1, corr1, energy1, homo1] = imgslide(t1, t1offsets, G, 1);

%% Result - Texture 1
figure(5)
imagesc(energy1)
colorbar
colormap('jet')
title('Texture 1, energy')
print('-f5','t1Plot','-dpng')

%% GLCM - Texture 2
[contrast3, corr3, energy3, homo3] = imgslide(t2, t2offsets, G, 1);

%% Result texture 2
figure(6)
imagesc(energy3)
colorbar
colormap('jet')
title('Texture 2 - Energy')
print('-f6','t2Plot','-dpng')

%% GLCM - Texture 3
[contrast5, corr5, energy5, homo5] = imgslide(t3, t3offsets, G, 1);

%% Result - Texture 3
figure(7)
imagesc(corr5)
colorbar
colormap('jet')
title('Texture 3 - Correlation')
print('-f7','t3Plot','-dpng')
%% GLCM - Texture 4

[contrast7, corr7, energy7, homo7] = imgslide(t4, t4offsets, G, 1);

%% Tecture 4 - Results 

figure(8)
title('Texture 4 - Energy')
imagesc(energy7)
colorbar
colormap('jet')
title('Texture 4 - Energy')
print('-f8','t4Plot','-dpng')


%% GLCM - Texture 5

[contrast9, corr9, energy9, homo9] = imgslide(t5, t5offsets, G, 1);

%% Tecture 5 - Results 

figure(9)
title('Texture 5 - Correlation')
imagesc(corr9)
colorbar
colormap('jet')
print('-f9','t5Plot','-dpng')




%% GLCM - Texture 6

[contrast11, corr11, energy11, homo11] = imgslide(t6, t6offsets, G, 1);

%% Tecture 6 - Results 


figure(10)
imagesc(energy11)
colorbar
title('Texture 2 - Energy')
colormap('jet')
print('-f10','t6Plot','-dpng')


%% GLCM - Texture 7

[contrast13, corr13, energy13, homo13] = imgslide(t7, t7offsets, G, 1);

%% Tecture 7  - Results 
figure(11)
imagesc(energy13)
colorbar
title('Texture 7 - Energy')
colormap('jet')
print('-f11','t7Plot','-dpng')

%% GLCM - Texture 8
[contrast15, corr15, energy15, homo15] = imgslide(t8, t8offsets, G, 1);

%% Texture 8 - Results
figure(12)
imagesc(energy15)
colorbar
title('Texture 8 - Energy')
colormap('jet')
print('-f12','t8Plot','-dpng')


%{
Part C
%}

%% GLCM for local window. Texture 1
G = 11
tw1 = t1(105:115, 105:115)
[contrast21, corr21, energy21, homo21] = imgslide(tw1, t1offsets, G, 1);
figure(21)
subplot(141)
imshow(tw1)
title('Texture 1 window')
subplot(142)
imshow(homo21)
title('GLCM homogeneity')
subplot(143)
imshow(contrast21)
title('GLCM inerita')
subplot(144)
imshow(energy21)
title('GLCM energy')
colormap('gray')
print('-f21','tw1Plot','-dpng')
%% Texture 2 window
G = 21
tw2 = t2(150:180, 210:240);
[contrast22, corr22, energy22, homo22] = imgslide(tw2, t2offsets, G, 1);
figure(22)
subplot(141)
imshow(tw2)
title('Texture 2 window')
subplot(142)
imshow(homo22)
title('GLCM homogeneity')
subplot(143)
imshow(contrast22)
title('GLCM inerita')
subplot(144)
imshow(energy22)
title('GLCM energy')
colormap('gray')
print('-f22','tw2Plot','-dpng')
%% Texture 3 window
G = 21
tw3 = t3(100:150, 200:250);
[contrast23, corr23, energy23, homo23] = imgslide(tw3, t3offsets, G, 1);
figure(23)
subplot(141)
imshow(tw3)
title('Texture 3 window')
subplot(142)
imshow(homo23)
title('GLCM homogeneity')
subplot(143)
imshow(contrast23)
title('GLCM inerita')
subplot(144)
imshow(energy23)
title('GLCM energy')
colormap('gray')
print('-f23','tw3Plot','-dpng')
%% Texture 4 window
G = 15
tw4 = t4(10:25, 10:25);
[contrast24, corr24, energy24, homo24] = imgslide(tw4, t4offsets, G, 1);
figure(24)
subplot(141)
imshow(tw4)
title('Texture 4 window')
subplot(142)
imshow(homo24)
title('GLCM homogeneity')
subplot(143)
imshow(contrast24)
title('GLCM inerita')
subplot(144)
imshow(energy24)
title('GLCM energy')
colormap('gray')
print('-f24','tw4Plot','-dpng')

%% Texture 5 window
G = 15
tw5 = t5(130:170, 140:180);
[contrast25, corr25, energy25, homo25] = imgslide(tw5, t5offsets, G, 1);
figure(25)
subplot(141)
imshow(tw5)
title('Texture 5 window')
subplot(142)
imshow(homo25)
title('GLCM homogeneity')
subplot(143)
imshow(contrast25)
title('GLCM inerita')
subplot(144)
imshow(energy25)
title('GLCM energy')
colormap('gray')
print('-f25','tw5Plot','-dpng')

%% Texture 6 window
G = 15
tw6 = t6(120:150, 155:185);
[contrast26, corr26, energy26, homo26] = imgslide(tw6, t6offsets, G, 1);
figure(26)
subplot(141)
imshow(tw6)
title('Texture 6 window')
subplot(142)
imshow(homo26)
title('GLCM homogeneity')
subplot(143)
imshow(contrast26)
title('GLCM inerita')
subplot(144)
imshow(energy26)
title('GLCM energy')
colormap('gray')
print('-f26','tw6Plot','-dpng')

%% Texture 7 window
G = 15
tw7 = t7(50:70, 165:185);
[contrast27, corr27, energy27, homo27] = imgslide(tw7, t7offsets, G, 1);
figure(27)
subplot(141)
imshow(tw7)
title('Texture 7 window')
subplot(142)
imshow(homo27)
title('GLCM homogeneity')
subplot(143)
imshow(contrast27)
title('GLCM inerita')
subplot(144)
imshow(energy27)
title('GLCM energy')
colormap('gray')
print('-f27','tw7Plot','-dpng')

%% Texture 8 window
G = 15
tw8 = t8(70:85, 70:85);
[contrast28, corr28, energy28, homo28] = imgslide(tw8, t8offsets, G, 1);
figure(28)
subplot(141)
imshow(tw8)
title('Texture 8 window')
subplot(142)
imshow(homo28)
title('GLCM homogeneity')
subplot(143)
imshow(contrast28)
title('GLCM inerita')
subplot(144)
imshow(energy28)
title('GLCM energy')
colormap('gray')
print('-f28','tw8Plot','-dpng')


%{
Part D
%}
%% Mosiac 1 GLCM
img1offsets = vertcat(t1offsets,t2offsets, t3offsets, t4offsets)
[contrast101, corr101, energy101, homo101] = imgslide(img1, img1offsets, G, 1);
%% Mosaic 1 - Results
figure(101)
subplot(221)
imshow(contrast101)
title('Contrast')
subplot(222)
imshow(corr101)
title('Corrulation')
subplot(223)
imshow(energy101)
title('Energy')
subplot(224)
imshow(homo101)
title('Homogenity')
colormap('jet')
print('-f101','img1Plot','-dpng')
%% Applying 50x50 median filter for clearer results
contrast102 = medfilt2(double(contrast101), [50, 50]);
corr102 = medfilt2(corr101, [50, 50]);
energy102 = medfilt2(energy101, [50, 50]);
homo102 = medfilt2(homo101, [50, 50]);
%% Plotting results
figure(102)
subplot(221)
imshow(contrast102)
colorbar
title('Contrast equalized')
subplot(222)
imshow(corr102)
colorbar
title('Corrulation equalized')
subplot(223)
imshow(energy102)
colorbar
title('Energy equalized')
subplot(224)
imshow(homo102)
colorbar
title('Homogenity equalized')
colormap('jet')
print('-f102','img1ePlot','-dpng')
%% Filtering out textures:
figure(103)
subplot(221)
imshow(img1.*uint8(energy102<0.25).*uint8(homo102<0.45))
title('Texture 1:  energy < 0.25 and homogenity > 0.43')
subplot(222)
imshow(img1.*uint8(contrast102<0.24))
title('Texture 2: contrast < 0.24')
subplot(223)
imshow(img1.*uint8(contrast102>0.3).*uint8(energy102>0.4))
title('Texture 3: corrulation < 0.6 and energy > 0.62')
subplot(224)
imshow(img1.*uint8(corr102<0.45).*uint8(energy102>0.20).*uint8(energy102<0.45))
title('Texture 4: corrulation < 0.45 and 0.2 < energy < 0.45')
print('-f103','img1tPlot','-dpng')
%% Mosiac 2 GLCM
img2offsets = vertcat(t5offsets,t6offsets, t7offsets, t8offsets)

[contrast201, corr201, energy201, homo201] = imgslide(img2, img2offsets, G, 1);
%% Mosaic 2 - Results
figure(201)
subplot(221)
imshow(contrast201)
title('Contrast')
subplot(222)
imshow(corr201)
title('Corrulation')
subplot(223)
imshow(energy201)
title('Energy')
subplot(224)
imshow(homo201)
title('Homogenity')
colormap('jet')
print('-f201','img2Plot','-dpng')
%% Applying 50x50 median filter for clearer results
contrast202 = medfilt2(double(contrast201), [50, 50]);
corr202 = medfilt2(corr201, [50, 50]);
energy202 = medfilt2(energy201, [50, 50]);
homo202 = medfilt2(homo201, [50, 50]);
%% Plotting results
figure(202)
subplot(221)
imshow(contrast202)
colorbar
title('Contrast equalized')
subplot(222)
imshow(corr202)
colorbar
title('Corrulation equalized')
subplot(223)
imshow(energy202)
colorbar
title('Energy equalized')
subplot(224)
imshow(homo202)
colorbar
title('Homogenity equalized')
colormap('jet')
print('-f202','img2ePlot','-dpng')
%% Filtering out textures:
figure(203)
subplot(221)
imshow(img2.*uint8(corr202>0.70))
title('Texture 5: corrolation > 0.7')
subplot(222)
imshow(img2.*uint8((corr202<0.4)).*uint8((contrast202<0.7)))
title('Texture 6: corrolaton < 0.4 and contrast < 0.7')
subplot(223)
imshow(img2.*uint8(contrast202<0.34))
title('Texture 7: contrast < 0.34')
subplot(224)
imshow(img2.*uint8(contrast202>0.64).*uint8(corr202<0.6))
title('Texture 8: contrast > 0.64 and corrolation < 0.6')
print('-f203','img2tPlot','-dpng')


