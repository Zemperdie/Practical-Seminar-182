clc
clear all
close all

%% Parameters

pos_islands=[0,1;10,-1;20,0];
rv=[0.5,1,1.5];
dt=0.01;

n_particles=67;


delay=100*dt;
n_reps=10;

%% Startpositions
% c=1: before island 1
% c=2: at island 1
% c=3: at island 2
c=3;
Z0s=startpositions(n_particles,n_reps,pos_islands,rv,c);


%%


starttimes_v=(0:n_reps-1)*delay;
ZSOL=ones(length(0:dt:12),2,n_particles*length(starttimes_v));
Events=ones(length(starttimes_v),n_particles,3);
for tstarti=1:length(starttimes_v)
    tstart=starttimes_v(tstarti);
    [ZSOL(:,:,((tstarti-1)*n_particles)+1:tstarti*n_particles'),tmp]=particleflow(Z0s(:,:,tstarti),tstart,dt,pos_islands,rv);
    Events(tstarti,:,:)=tmp;
end

ik=1;

for ii= 1:(n_reps)
for ij= 1:n_particles

tmp2(:,ik)=permute(Events(ii,ij,:),[3,2,1]);
ik=ik+1;


end
end
Events=tmp2;

%% change dimensions

for ii=1:n_reps
Z0s(:,3,ii)=repelem(starttimes_v(ii),n_particles);
end
temp=Z0s(:,3,:);
Z0s(:,3,:)=Z0s(:,2,:);
Z0s(:,2,:)=Z0s(:,1,:);
Z0s(:,1,:)=temp;


startpoints=permute(Z0s,[3,1,2]);


ik=1;
for ii= 1:(n_reps)
for ij= 1:n_particles

tmp3(:,ik)=permute(startpoints(ii,ij,:),[3,2,1]);
ik=ik+1;


end
end

startpoints=tmp3;
%% save
load Loesungen.mat
c(size(c,1)+1,1:6)={ZSOL,startpoints,Events,dt,pos_islands,rv};
save("Loesungen.mat","c")

%%
clc
clear all
load Loesungen.mat



