% [Ht, G]=ComputeLKFlowParmsAffine(img)
%
% Computes the optical flow parameters. The image is derived in DX and DY
% directions and matrix G is computed.
%
% Inputs:
% img - The image to compute optical flow parameters. Note that the image
%       must contain a border of size 1 since the DX and DY operation work
%       on 3x3 regions.
%
% Outpus:
% Ht - The transpose of matrix H, which defines the LK affine approximation of an shifted
% image
%
% G  - The matrix G=H'*H
%
function [Ht, G]=ComputeLKFlowParmsAffine(img)

% Compute Ix and Iy derivatives using sobel operator
Hdy = fspecial('sobel');
Hdx = Hdy';

Ix=imfilter(img, Hdx);
Iy=imfilter(img, Hdy);

Ix=Ix(2:end-1,2:end-1);
Iy=Iy(2:end-1,2:end-1);

% Compute coordiates of X and Y
[X,Y]=meshgrid(1:size(Ix,2),1:size(Ix,1));

% Reshape matrixes
Ix=Ix(:);
Iy=Iy(:);
X=X(:);
Y=Y(:);

% Compute G (according to parameter vector: [a d b e c f])
H = [Ix.*X Iy.*X Ix.*Y Iy.*Y Ix Iy];
Ht=H';
G=Ht*H;
