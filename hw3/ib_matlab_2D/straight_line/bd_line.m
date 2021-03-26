function Z=bd_line(theta0)
global Nb dtheta Lp L
Z=zeros(Nb,2);
for k=0:(Nb-1)
    theta=(k+1/2)*dtheta;
    Z(k+1,1)=(L/2)+(theta-Lp)*cos(theta0);
    Z(k+1,2)=(L/2)+(theta-Lp)*sin(theta0);
end
