function [zoomed] = zoom20(img)
    img = uint8(img)
    zoomed = uint8(kron(double(img),ones(20)));