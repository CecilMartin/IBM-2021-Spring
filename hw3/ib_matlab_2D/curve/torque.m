function tau = torque(theta,X,Z)
global Nb K dtheta L0;
arc_length=[0:(Nb-1)]*dtheta;
ind_1=arc_length/(L0/4)<=pi;
int_1=sum(ind_1);
% fprintf(num2str(int_1/Nb));
tau=0;
f=K*(X-Z);
for i = 1:int_1
    r = [-L0/4*cos(theta)-L0/4*cos(theta-arc_length(i)/(L0/4)),...
        -L0/4*sin(theta)-L0/4*sin(theta-arc_length(i)/(L0/4))];
    tau=tau+(r(1)*f(i,2)-r(2)*f(i,1))*dtheta;
end
for i = int_1+1:Nb
    r = [L0/4*cos(theta)-L0/4*cos(theta+arc_length(i)/(L0/4)-pi),...
        L0/4*sin(theta)-L0/4*sin(theta+arc_length(i)/(L0/4)-pi)];
    tau=tau+(r(1)*f(i,2)-r(2)*f(i,1))*dtheta;
end
end
