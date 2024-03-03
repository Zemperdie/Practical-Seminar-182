function out=startpositions(n_particles,n_reps,pos_islands,rv,c)
%%

xoff=[pos_islands(1,1),pos_islands(2,1)];
yoff=[pos_islands(1,2),pos_islands(2,2)];
R=@(n_particles)rand(1,n_particles).*0.2+0.2;
Z0s=zeros(n_particles,2,n_reps);


for ii=1:n_reps
    % n1=randi(round(n_particles/3)-1,1,1);
    % n2=randi(round(n_particles/3)-1,1,1);
    % n3=n_particles-(n1+n2);
    Z1=rand(1,n_particles);
    Z2=rand(1,n_particles);
    switch c
        case 1
            Z0s(:,1,ii)=ones(1,n_particles).*-5;
            Z0s(:,2,ii)=rand(1,n_particles).*6-3;
        case 2
            Z0s(:,1,ii)=(rv(1)+R(n_particles)).*cos(2*pi*Z1)+xoff(1);
            Z0s(:,2,ii)=(rv(1)+R(n_particles)).*sin(2*pi*Z1)+yoff(1);
        case 3
            Z0s(:,1,ii)=(rv(2)+R(n_particles)).*cos(2*pi*Z2)+xoff(2);
            Z0s(:,2,ii)=(rv(2)+R(n_particles)).*sin(2*pi*Z2)+yoff(2);
    end
    
    
    
end
%%
out=Z0s;
end









