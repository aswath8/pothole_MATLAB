%function [x,y,z]=getTransformation(R,x1,y1,z1)
%X=[x1 y1 z1]';
T=Rotm*X
%end