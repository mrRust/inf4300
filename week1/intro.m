%% A quick introduction to MATLAB for image analysis.

% If you are on a Red Hat machine, MATLAB can be launched by the command
% 'matlab' (without the quotes) at the command prompt. In Windows
% there should be a MATLAB icon in the start-menu or on the desktop.

% To get started: Type F1 and click 'Getting Started'.

%% A 'double comment' like this creates what MATLAB refers to as a block.

% Make a folder named 'INF4300' and set this as the 'current directory'
% using the UI or using the MATLAB-function 'cd'.

% When using the CD function and to use MATLAB more efficiently,
% the autocompletion is often handy. Activate it by hitting 'Tab'.

% Save a copy of this file in that folder, and open it in MATLAB.

% To run a part of the code, select the code and hit F9.

% To run the selected block (the block with the caret), hit 'Ctrl+Enter'.

% To run an entire file, you can:
%  - type the name of the file, e.g. 'intro', at the command prompt, or
%  - select the file and hit F9, or
%  - open the file and hit F5.

%% 1. Matrices

% The matrix | 1 0 0 |
%            | 0 1 0 |
%            | 0 0 1 |
% may be created like this:
someMatrix = [1 0 0 ; 0 1 0 ; 0 0 1]
% e.g. [row1 ; row2 ; ... ; rowM], where a row can be defined as
% [number1 number2 ... numberN] or [number1, number2, ..., numberN]

% MATLAB comes built-in with function for many common operations,
% for the case above we could have typed:
someMatrix = diag([1 1 1])

% If you wonder how a function/operator works, type 'help <function name>'
% or for (a sometimes more thorough) description in a separate window,
% type 'doc <function name>'

% MATLAB matrices are dynamic objects, meaning one need not know the exact
% size of a matrix in advance. Initially a simple matrix can be made, and
% and later rows or colums may be added or removed. If, however, the size
% is known in advance and the matrix is large, it is wise to preallocate
% memory for the matrix before you start using it. This may greatly improve
% performance.

% E.g. allocate memory for 100*100 matrix and fill it with 1's:
big_1 = ones(100); %<-- Terminating a line with ';' will suppress output.

% Or, allocate a 50*40*3 matrix and fill it with 0's:
big_0 = zeros([50 40 3]);

% A vector can be created using the '<from>:<step>:<to>' syntax:
steg1 = 1:2:50;

% The <step> is optional. If omitted the step defaults to 1:
steg2 = 1:50;

% The standard plotting function is PLOT, e.g.:
plot(steg1);
% An alternative is STEM. Look up how it works using 'help stem'.

% Extracting a value, or a series of values, from a matrix is easily
% achieved like this:
mat = [1 7 4 ; 3 4 5]
mat(2,1) % retrives the '3'. NOTE: The first index is 1 in MATLAB!

% MATLAB lays out a column at a time in memory, hence the value '7' can
% either be retrieved using linear index:
mat(3)
% or using (row,column)-index:
mat(1,2)

% A range of elements may be using the <from>:<to> syntax:
mat(1:2,1)     % First column
mat(1:end,1)   % The same, since n = 2
mat(:,1)       % The same, : is here 'all rows'

% We can use the same syntax to set a range of elements:
mat(1:2,1:2) = 0

% Note that a matrix can be stored in various formats, e.g. UINT8, INT8 or
% DOUBLE. They all have their conversion functions, see e.g. 'help uint8'.
% If your result looks fishy, and you have a hard time figuring out why,
% a type conversion (of lack of one) may be the reason!

%% 2. Matrix operations

mat1 = [2 3; 5 7];
mat2 = [4 5; 1 9];

% Elementwise addition and subtraction.
mat1 + mat2
mat1 - mat2

% Transpose.
mat1.'
% Complex conjugate transpose (same as transpose when the matrix is real).
mat1'

% Multiplication, division and power.
mat1 * mat2
mat1 / mat2
mat1^2

% Elementwise multiplication, division and power
% (add '.' in front of the operator).
mat1 .* mat2
mat1 ./ mat2
mat1 .^ mat2

%% 3. Control structures

% While and for loops.
% Can often be used instead of matrix operations, but tend to lead to a
% slightly inferior perfomance, especially in older versions of MATLAB.
%
% For some tips on how to write fast MATLAB-code:
% http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=5685
%
% The reason for introducing performance-tips already is because we will be
% storing images as matrices, and these tend to be large. If we also
% consider that the algorithms we use are computationally intensive,
% writing somewhat optimised code is often worth the extra effort.

% E.g. can this simple loop:
A = zeros(1,100);
for i = 100
    A(i) = 2;
end
% be replaced by a single and more efficient command:
A = ones(1,100) * 2;

% And why write:
for i = 1:100
    for j = 1:100
        stor_1(i,j) = i^2; % MATLAB warning: consider preallocating for speed
    end
end
% when you can do this:
big_1_temp = repmat((1:100)'.^2, 1,100);
% or alternatively:
big_1_temp2 = (1:100)'.^2 * ones(1,100);

% Note:
% If you are not used to 'doing everything with vectors', you'll likely
% want to use loops far more often than you need to. When you get the hang
% of it, typing vector-code is faster and often less error-prone than the
% loop-equivalents, but loops offer better flexibility.
 
% As always, add lots of COMMENTS, especially for complex one-liners!

% Logical structures: if-elseif-else. Which number is displayed?
if -1
    1
elseif -2
    2
else 
    3
end

% Logical structures: switch-case.
var = 't';
switch var
    case 't'
        1
    case 2
        2
end

%% 4. The FIND function - see 'help find'

% A very handy method, but may initially seem a bit tricky.

% Example: Find elements which are equal to 4.
M = [1 2 3 ; 4 4 5 ; 0 0 2]
M == 4                 % a logical map
I = find(M == 4)       % the linear indices
[II, J] = find(M == 4) % the (row,column)-indices
M(M == 4) = 3          % change them to 3
M(I) = 4               % and back to 4


%% 5. Images

% Open a couple of images.
img1 = imread('football.jpg');
img2 = imread('coins.png');

% Display the first image.
imshow(img1)

% Display the second image in a new figure.
figure, imshow(img2)

% Another function for displaying the images is:
figure, imagesc(img1), colorbar

% Histogram the image intensity values.
H = imhist(img2);
plot(H)

% Converting a colour image with 3 colour channels to a greyscale image
% (the Y in the YIQ colour model).
img1 = imread('football.jpg');
img3 = rgb2gray(img1);
figure, imshow(img3)

%% 6. Some basic filtering in the image domain.

% 2D correlation: FILTER2
% 2D convolution: CONV2
% With IMFILTER you can choose either 2D correlation (default) and 2D
% convolution, and it also has some boundary options.

% Filter IMG3 using a 5x5 mean filter.
h1 = ones(5,5) / 25;
img4 = imfilter(img3,h1); % symmetric filter => correlation = convolution
imshow(img3), title('Original image');
figure, imshow(img4), title('Filtered image')

% Find the gradient magnitude of IMG3.
h2x = [-1 -2 -1 ;  0  0  0 ;  1  2  1]
h2y = [-1  0  1 ; -2  0  2 ; -1  0  1]
resX = conv2(double(img3), h2x); % NOTE: DOUBLE type conversion
resY = conv2(double(img3), h2y);
resXY = sqrt(resX.^2 + resY.^2);

% Display the gradient magnitude, but not like this:
figure, imshow(resXY);
% because the assumed range of the DOUBLE type is [0,1],
% but e.g. one of these ways:
figure, imshow(resXY, []);
figure, imshow(resXY, [min(resXY(:)) max(resXY(:))]);
figure, imshow(resXY/max(resXY(:)));
figure, imshow(uint8(resXY/max(resXY(:)).*255));


%%%%%%%%%%%%%%%%
%% EXERCISE 1 %%
%%%%%%%%%%%%%%%%

% Above, we loaded the image 'football.jpg', converted it to a greyscale
% image and applied a 5x5 mean filter, by using the commands:
img1 = imread('football.jpg');
img3 = rgb2gray(img1);
%figure, imshow(img3)
h1 = ones(5,5) / 25;
img4 = imfilter(img3,h1);
%imshow(img3), title('Original image');
%figure, imshow(img4), title('Filtered image')

% The filtered image have a two pixel wide black frame.
% a) Use the indexing techniques described above to remove these.
figure(1)
title('Removing black boarders')
[M N w] = size(img4)
img5 = img4(3:M-2, 3:N-2);
subplot(221)
imshow(img5)
title('Index fixing')

% b) Use FILTER2 and CONV2 with the option 'valid' to remove these.
%    Hint 1: Type convert IMG3 to DOUBLE.
%    Hint 2: The image should be the second argument to FILTER2,
%            not the first as it is to CONV2 and IMFILTER.

cutfilter = zeros(5)
cutfilter(3, 3) = 1

img6 = double(img4);
img7 = filter2(cutfilter, img6, 'valid');
img8 = uint8(img7);
subplot(222)
imshow(img8)
title('filter2 fixing')
img9 = conv2(img6, cutfilter, 'valid')
img10 = uint8(img9)
subplot(223)
imshow(img10)
title('conv2 fixing')

% c) Use the boundary option of IMFILTER to get a same-sized image without
%    the black frame.

help imfilter
img11 = imfilter(img6, cutfilter, 'replicate')
img12 = uint8(img11)
subplot(224)
imshow(img12)

%%%%%%%%%%%%%%%%
%% EXERCISE 2 %%
%%%%%%%%%%%%%%%%

% Make a function that returns the same as IMHIST when the parameter is a
% 8-bits greyscal image.
%
% Although it is allowed to use loops, try to avoid using them where
% it is possible. One loop should suffice.
%
% Hint: How to create and use the function
% A function is stored in .m files with the same name as the function.
% 1. Create an m-file named 'histogram.m', e.g. using 'edit histogram.m'
figure(1)
subplot(221)

I = imread('football.jpg');
imhist(I(:,:,1)), title('imhist solution')
subplot(222)
histogram(I)
title('My simple histogram')

% 2. The first line should be 'function h = histogram(img)'
% 3. Write the code to produce a histogram of IMG below the function
%    declaration. The histogram should be stored in a variable named H.
% 4. Save the file.
% 5. From another m-file, or from the command line call HISTOGRAM(IMG)
%    where IMG is a greyscale image.

%%%%%%%%%%%%%%%%
%% EXERCISE 3 %%
%%%%%%%%%%%%%%%%

% Above, we loaded the image 'coins.png' using the command:
img2 = imread('coins.png');
%
% a)
% Use the operators >, <, >=, <= to threshold IMG2 using an arbitrary
% threshold.
figure(1)
img3 = (img2 > 85);
subplot(121)
imshow(img3);

% b)
% Image Processing Toolbox (IPT) in MATLAB have a function for computing
% the 'optimal' threshold based on Otsu's algorithm.
%  - Find this function using MATLAB's help system.
%  - Use it to with the 'optimal' threshold.
%  - Use the threshold and the function IM2BW to threshold IMG2.
thresh = multithresh(img2)
thresh = double(thresh)
img4 = im2bw(img2, thresh/255);
subplot(122)
imshow(img4)
% c)
% Compare the binary image resulting from part a with the one from part b
% by displaying the images. Do you notice any differences?
% Display also the difference between the images.

%%%%%%%%%%%%%%%%
%% EXERCISE 4 %%
%%%%%%%%%%%%%%%%

img1 = imread('rice.png');
img1 = double(img1);
v1 = min(img1(:));
v2 = max(img1(:));
dist = v2-v1;
img2 = img1-v1;
img2 = img2*(255/dist);
img2 = uint8(img2);
imhist(img2)
figure(1)
subplot(221)
imhist(uint8(img1));
subplot(222)
imhist(img2)
subplot(223)

img3 = (img2 < 150);
subplot(223)
imshow(img3)
% Normalize resXY such that max(resXY(:)) = 255 and min(resXY(:)) = 0.
% Threshold the result with T = 100.
%
% What would you do if you wanted to obtain an image containing
% only the seam, and the entire seam, of the the ball?
