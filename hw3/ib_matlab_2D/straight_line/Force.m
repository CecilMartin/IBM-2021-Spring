function F=Force(X,Z)
global kp km dtheta K;

% F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
F=K*(Z-X);