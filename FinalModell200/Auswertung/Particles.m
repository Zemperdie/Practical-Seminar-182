clc
clear all
close all

%% Import
 load("Loesungen.mat","c")
% 
% 
 Select=1;
 ZSOL1=c{1,1};
 ZSOL2=c{2,1};
 ZSOL3=c{3,1};



% startpoints=c{Select,2};
% Events=c{Select,3};
 dt=c{Select,4};
 pos_islands=c{Select,5};
 rv=c{Select,6};
 Border=max(pos_islands(:,1))+10;

clear c
[X,Y]=meshgrid(linspace(-5,Border+5,Border*150+1),linspace(-3,3,101));

%% Vorticity


figure(1)
timestepv=[401,426,451,476];
for timestepi=1:size(timestepv,2)
    timestep=timestepv(timestepi);
    subplot(4,1,timestepi)
    hold on
    plot(permute(ZSOL1(timestep,1,:),[1,3,2]),permute(ZSOL1(timestep,2,:),[1,3,2]),'.',Color='red',MarkerSize=3)
    plot(permute(ZSOL2(timestep,1,:),[1,3,2]),permute(ZSOL2(timestep,2,:),[1,3,2]),'.',Color='green',MarkerSize=3)
    plot(permute(ZSOL3(timestep,1,:),[1,3,2]),permute(ZSOL3(timestep,2,:),[1,3,2]),'.',Color='blue',MarkerSize=3)

    for ii=1:size(pos_islands,1)
    fill(rv(ii).*sin(linspace(0,2*pi))+pos_islands(ii,1),rv(ii).*cos(linspace(0,2*pi))+pos_islands(ii,2),'k')
    end
    
    grid on
    axis equal
    xlabel('x')
    ylabel('y')
    xlim([-5,Border+5])
    ylim([-3,3])
    title(sprintf('t=%.2f',(timestep-1).*dt))
    sgtitle('Particlepositions \omega=200')
    legend({'Ocean', 'Island 1','Island 2'})




end

