clc
clear all
close all

%% Import
load("Loesungen.mat","c")
pos_islands=c{1,5};
rv=c{1,6};


%ZSOL=c{Select,1};
%startpoints=c{Select,2};
Events1=c{1,3};
Events2=c{2,3};
Events3=c{3,3};

vecnorm(Events1(2:3,:)-pos_islands(3,:)')<(0.4+rv(3));
Coast1=size(Events1(Events1(2,:)>=30),2)/size(Events1,2)*100;
Island1=size(Events1(vecnorm(Events1(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),2)/size(Events1,2)*100;
Dead1=100-Coast1-Island1;

Coast2=size(Events2(Events2(2,:)>=30),2)/size(Events2,2)*100;
Island2=size(Events2(vecnorm(Events2(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),2)/size(Events2,2)*100;
Dead2=100-Coast2-Island2;

Coast3=size(Events3(Events3(2,:)>=30),2)/size(Events3,2).*100;
Island3=size(Events3(vecnorm(Events3(2:3,:)-pos_islands(3,:)')<(0.4+rv(3))),2)/size(Events3,2)*100;
Dead3=100-Coast3-Island3;

%%
figure(1)
plot(Events3(2,:),Events3(3,:),'x')


figure(2)
X = {'Ocean','Island 1','Island 2'};
bar(X,[Coast1,Island1,Dead1;Coast2,Island2,Dead2;Coast3,Island3,Dead3],'grouped')
legend('Coast','Island 3','Lifetime Expired')
title('Connectivity; \omega=100')
grid on
ylabel('%')
