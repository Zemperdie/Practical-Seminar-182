clc
clear all
close all

%% Import
 load("Loesungen.mat","c")
% 
% 
 Select=1;
% ZSOL=c{Select,1};
 startpoints=c{Select,2};
% Events=c{Select,3};
 dt=c{Select,4};
 pos_islands=c{Select,5};
 rv=c{Select,6};
 Border=max(pos_islands(:,1))+5;

clear c
[X,Y]=meshgrid(linspace(-5,Border+5,(Border+10)*20+1),linspace(-3,3,121));

%% Vorticity


figure(1)
timestepv=[400,425,450,475];
for timestepi=1:size(timestepv,2)
    timestep=timestepv(timestepi);
    subplot(4,1,timestepi)
    hold on

     su=pcolor(X,Y,curl(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2)));
     hold on
     su.EdgeColor="none";
     colormap("hsv")
     colorbar
     clim([-380,380])
    % quiver(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2))
  %   streamline(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2),startpoints(2,1:50),startpoints(3,1:50))





    for ii=1:size(pos_islands,1)
    fill(rv(ii).*sin(linspace(0,2*pi))+pos_islands(ii,1),rv(ii).*cos(linspace(0,2*pi))+pos_islands(ii,2),'k')
    end
    
    grid on
    axis equal
    xlabel('x')
    ylabel('y')
    xlim([-5,Border+5])
    ylim([-3,3])
    title(sprintf('t=%.2f',timestep.*dt))
    sgtitle('Vorticity \omega=100')




end

%% Vectorfield

figure(2)
timestepv=[400,425,450,475];
for timestepi=1:size(timestepv,2)
    timestep=timestepv(timestepi);
    subplot(4,1,timestepi)
    hold on

     % su=pcolor(X,Y,curl(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2)));
     % hold on
     % su.EdgeColor="none";
     % colormap("summer")
     % colorbar
     quiver(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2))
  %   streamline(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2),startpoints(2,1:50),startpoints(3,1:50))





    for ii=1:size(pos_islands,1)
    fill(rv(ii).*sin(linspace(0,2*pi))+pos_islands(ii,1),rv(ii).*cos(linspace(0,2*pi))+pos_islands(ii,2),'k')
    end
    
    grid on
    axis equal
    xlabel('x')
    ylabel('y')
    xlim([-5,Border+5])
    ylim([-3,3])
    title(sprintf('t=%.2f',timestep.*dt))
    sgtitle('Vectorfields \omega=100')




end


%% Streamlines

figure(3)
timestepv=[400,425,450,475];
for timestepi=1:size(timestepv,2)
    timestep=timestepv(timestepi);
    subplot(4,1,timestepi)
    hold on

     % su=pcolor(X,Y,curl(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2)));
     % hold on
     % su.EdgeColor="none";
     % colormap("summer")
     % colorbar
     % quiver(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2))
     streamline(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2),ones(1,30).*-5,linspace(-3,3,30),[0.1,200000])





    for ii=1:size(pos_islands,1)
    fill(rv(ii).*sin(linspace(0,2*pi))+pos_islands(ii,1),rv(ii).*cos(linspace(0,2*pi))+pos_islands(ii,2),'k')
    end
    
    grid on
    axis equal
    xlabel('x')
    ylabel('y')
    xlim([-5,Border+5])
    ylim([-3,3])
    title(sprintf('t=%.2f',timestep.*dt))
    sgtitle('Streamlines \omega=100')




end





