clc
clear all
close all

%% Import
load("Loesungen.mat","c")



%ZSOL=c{Select,1};
%startpoints=c{Select,2};
Events1=c{1,3};
Events2=c{2,3};
Events3=c{3,3};


%dt=c{Select,4};
pos_islands=c{1,5};
rv=c{1,6};
%Border=max(pos_islands(:,1))+10;
%%
%%
figure(2)
subplot(3,1,1)
histogram(Events1(1,vecnorm(Events1(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),20)
xlabel('t')
ylabel('N Particles')
xlim([0,12])
ylim([0,10])
title('Ocean')
grid on

subplot(3,1,2)
histogram(Events2(1,vecnorm(Events2(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),20)
xlabel('t')
ylabel('N Particles')
xlim([0,12])
ylim([0,10])
title('Island 1')
grid on
subplot(3,1,3)

histogram(Events3(1,vecnorm(Events3(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),20)
xlabel('t')
ylabel('N Particles')
xlim([0,12])
ylim([0,10])
grid on
title('Island 2')

sgtitle('Temporal Distribution of particles at Island 3; by spawn-location; \omega=100')






