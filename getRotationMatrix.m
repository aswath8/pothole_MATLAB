function R = getRotationMatrix(x1,y1,z1,x2,y2,z2)
mag1=x1^2+y1^2+z1^2;
theta1=acosd(x1/mag1);
phi1=acosd(y1/mag1);
sy1=acosd(z1/mag1);

mag2=x2^2+y2^2+z2^2;
theta2=acosd(x2/mag2);
phi2=acosd(y2/mag2);
sy2=acosd(z2/mag2);
%eul=[theta1-theta2 phi1-phi2 sy1-sy2];
%rotm = eul2rotm(eul,"XYZ")
R=rotx(theta1-theta2)
R=R*roty(phi1-phi2)
R=R*rotz(sy1-sy2)
end