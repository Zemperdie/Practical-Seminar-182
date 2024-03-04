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
%pos_islands=c{Select,5};
%rv=c{Select,6};
%Border=max(pos_islands(:,1))+10;


figure(1)
subplot(3,1,1)
histogram(Events1(3,Events1(2,:)>=30),20)
ylim([0,100])
xlim([-3,3])
grid on
xlabel('y')
ylabel('N Particles')
title('Ocean')

subplot(3,1,2)
histogram(Events2(3,Events2(2,:)>=30),20)
ylim([0,100])
xlim([-3,3])
grid on
xlabel('y')
ylabel('N Particles')
title('Island 1')

subplot(3,1,3)
histogram(Events3(3,Events3(2,:)>=30),20)
ylim([0,100])
xlim([-3,3])
grid on
xlabel('y')
ylabel('N Particles')
title('Island 2')
sgtitle('Spatial Distribution of particles at the coast  by spawn-location \omega=100')


figure(2)
subplot(3,1,1)
histogram(Events1(1,Events1(2,:)>=30),20)
ylim([0,60])
xlim([0,12])

grid on
xlabel('t')
ylabel('N Particles')
title('Ocean')

subplot(3,1,2)
histogram(Events2(1,Events2(2,:)>=30),20)
xlim([0,12])
ylim([0,60])
grid on
xlabel('t')
ylabel('N Particles')
title('Island 1')

subplot(3,1,3)
histogram(Events3(1,Events3(2,:)>=30),20)
xlim([0,12])
ylim([0,60])
grid on
xlabel('t')
ylabel('N Particles')
title('Island 2')
sgtitle('Temporal Distribution of particles at the coast  by spawn-location \omega=100')







