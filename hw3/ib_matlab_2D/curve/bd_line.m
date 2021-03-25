function Z=bd_line(theta0)
global Nb dtheta L0 L
Z=zeros(Nb,2);
arc_length=[0:(Nb-1)]*dtheta;
ind_1=arc_length/(L0/4)<=pi;
ind_2=arc_length/(L0/4)>pi;
Z(ind_1,1)=L/2-L0/4*cos(theta0)-L0/4*cos(theta0-arc_length(ind_1)/(L0/4));
Z(ind_1,2)=L/2-L0/4*sin(theta0)-L0/4*sin(theta0-arc_length(ind_1)/(L0/4));
Z(ind_2,1)=L/2+L0/4*cos(theta0)-L0/4*cos(theta0+arc_length(ind_2)/(L0/4)-pi);
Z(ind_2,2)=L/2+L0/4*sin(theta0)-L0/4*sin(theta0+arc_length(ind_2)/(L0/4)-pi);