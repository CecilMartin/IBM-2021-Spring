% ib2D.m
% This script is the main program.

clear; close all;clc;

addpath('../')
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global L0 L;
initialize
init_a

video=VideoWriter(['mov/S_line_theta=',num2str(theta0),...
    '_mass=',num2str(m0),'.avi']);
video.FrameRate=10;
open(video);



for clock=1:clockmax
    XX=X+(dt/2)*interp(u,X);
    theta00=theta0+(dt/2)*omega;
    ZZ=bd_line(theta00);
    tau_half=torque(theta00,XX,ZZ); %TO Check
    omega_half=omega+dt/2/I0*tau_half;
    
    ff=spread(Force(XX,ZZ),XX); %To Check;Force density or discrete Force?
    ff(:,:,1)=ff(:,:,1)+f0; % uniform force in x-direction
    [u,uu]=fluid(u,ff);
    
    u_max=sqrt(max(u(:,:,1).^2+u(:,:,2).^2,[],'all'));
    if u_max*dt/h>1/2 || mu*dt/h^2>1/2
        fprintf(['CFL=',num2str(u_max*dt/h),'\n']);
        fprintf(['CFL_viscousity=',num2str(mu*dt/h^2),'\n']);
    end
    % Update
    X=X+dt*interp(uu,XX);
    theta0=theta0+omega*dt;
    omega=omega+dt/I0*tau_half;
    Z=bd_line(theta0);
    
    %animation:
%     vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
%     contour(xgrid,ygrid,vorticity,values)
    if dt*clock-T*v_dt>=v_dt
        T=T+1;
        plot(Z(:,1),Z(:,2),'ko')
        hold on
        plot(X(:,1),X(:,2),'b*')
        plot(L/2,L/2,'ro','MarkerFaceColor','r')
        quiver(xgrid(1:sv:end,1:sv:end),ygrid(1:sv:end,1:sv:end),...
            u(1:sv:end,1:sv:end,1),u(1:sv:end,1:sv:end,2))
        axis([0,L,0,L])
        %     caxis(valminmax)
        axis equal
        axis manual
        title(sprintf('t=%.2f',dt*clock))
        drawnow
        hold off
        writeVideo(video,getframe(gcf));
    end
end
close(video);
