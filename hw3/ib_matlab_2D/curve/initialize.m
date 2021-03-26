%initialize.m
L=1.0
L0=L/4 % projected length of the S shape
theta0=pi*1/2

N=64
h=L/N
ip=[(2:N),1]
im=[N,(1:(N-1))]
% Nb=ceil(pi*(L/2)/(h/2))
dtheta=h/2
Nb = ceil(L0/2*pi/(dtheta))

kp=[(2:Nb),1]
km=[Nb,(1:(Nb-1))]
K=500
rho=1
mu=0.01
tmax=20
dt=0.001/2
clockmax=ceil(tmax/dt)

m0=4
I0=4*pi*m0*(L0/4)^3;
f0=1;

X=bd_line(theta0);

Z=X;

u=zeros(N,N,2);
ff=zeros(N,N,2);
ff(:,:,1)=f0;
[u,uu]=fluid(u,ff);
u_max=sqrt(max(u(:,:,1).^2+u(:,:,2).^2,[],'all'))
omega=0;

% for j1=0:(N-1)
%   x=j1*h;
%   u(j1+1,:,2)=sin(2*pi*x/L);
% end

% 

v_dt = 0.1;
T=0

% vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
% dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
% values= (-10*dvorticity):dvorticity:(10*dvorticity);
% valminmax=[min(values),max(values)];
xgrid=zeros(N,N);
ygrid=zeros(N,N);
for j=0:(N-1)
  xgrid(j+1,:)=j*h;
  ygrid(:,j+1)=j*h;
end
%
set(gcf,'double','on')
% set(gcf,'position',[10,10,500,500])
% contour(xgrid,ygrid,vorticity,values)
hold on
plot(Z(:,1),Z(:,2),'ko')
plot(L/2,L/2,'ro','MarkerFaceColor','r')
sv=floor(N/10);
quiver(xgrid(1:sv:end,1:sv:end),ygrid(1:sv:end,1:sv:end),...
    u(1:sv:end,1:sv:end,1),u(1:sv:end,1:sv:end,2))
axis([0,L,0,L])
% caxis(valminmax)
axis equal
axis manual
title(sprintf('t=%.2f',0))
% title(['t=',num2str(0)])
drawnow
hold off

