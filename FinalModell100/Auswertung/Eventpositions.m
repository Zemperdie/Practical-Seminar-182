clc
clear all
close all

%% Import
load("Loesungen.mat","c")


Select=1;
ZSOL=c{Select,1};
startpoints=c{Select,2};
Events=c{Select,3};
dt=c{Select,4};
pos_islands=c{Select,5};
rv=c{Select,6};
Border=max(pos_islands(:,1))+10;


%% plots

% plot EventLocations
figure(1)
    plot(Events(2,vecnorm(Events(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),Events(3,vecnorm(Events(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),'x')
    hold on
    for ii=1:size(pos_islands,1)
        fill(rv(ii).*sin(linspace(0,2*pi))+pos_islands(ii,1),rv(ii).*cos(linspace(0,2*pi))+pos_islands(ii,2),'k')
    end
    axis equal
    xlim([-5,35])
    ylim([-3,3])
    grid on
    hold off

