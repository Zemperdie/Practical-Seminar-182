clc
clear all
close all

%% Import
load("Loesungen.mat","c")


Select=4;
ZSOL=c{Select,1};
startpoints=c{Select,2};
Events=c{Select,3};
dt=c{Select,4};
pos_islands=c{Select,5};
rv=c{Select,6};
Border=max(pos_islands(:,1))+10;

%% Settings
TraceLength=0;

%% Calculation




%% Animation


[X,Y]=meshgrid(linspace(-5,Border+5,Border*150+1),linspace(-3,3,101));

f1=figure(2);
f1.WindowState='maximized';
for timestep=1:size(ZSOL,1)

    if timestep-TraceLength<1
        tmp=1;
    else
        tmp=timestep-TraceLength;
    end
    t=tmp:timestep-1;
    
    
    
      % su=pcolor(X,Y,curl(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2)));
      % hold on
      % su.EdgeColor="none";
      % colormap("summer")
      % colorbar
     %quiver(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2))
     %streamline(X,Y,Velocity(X,Y,timestep.*dt,pos_islands,rv,1),Velocity(X,Y,timestep.*dt,pos_islands,rv,2),startpoints(2,1:50),startpoints(3,1:50))
     plot(0,1)
     hold on

    for ii=1:size(pos_islands,1)
    fill(rv(ii).*sin(linspace(0,2*pi))+pos_islands(ii,1),rv(ii).*cos(linspace(0,2*pi))+pos_islands(ii,2),'k')
    end
    
    grid on
    axis equal
    xlabel('x')
    ylabel('y')
    xlim([-5,Border+10])
    ylim([-3,3])
    title(sprintf('t=%.3f',timestep.*dt))
    % xlim([1,7])
    % ylim([-2,2])



    plot(permute(ZSOL(timestep,1,:),[1,3,2]),permute(ZSOL(timestep,2,:),[1,3,2]),'o',Color='red',MarkerSize=2)
    plot(permute(ZSOL(t,1,:),[1,3,2]),permute(ZSOL(t,2,:),[1,3,2]),'.',Color='green',MarkerSize=1)
    hold off
    waitforbuttonpress
end








