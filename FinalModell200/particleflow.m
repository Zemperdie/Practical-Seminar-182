function [ZSOL,Events]=particleflow(Z0s,tstart,dt,pos_islands,rv)
Border=max(pos_islands(:,1))+10;

tspan=tstart:dt:12;
Modell=@(t,Z)Velocity(Z(1),Z(2),t,pos_islands,rv);
%%

ZSOL=ones(length(0:dt:12),2,size(Z0s,1));
Events=ones(size(Z0s,1),3)*nan;
    parfor Z0i=1:size(Z0s,1)
        Z0=Z0s(Z0i,:);

        options=odeset(Events=@(tsol,Zsol)stopSim(tsol,Zsol,Border,pos_islands,rv,tstart));
        sol=ode45(Modell,tspan,Z0,options);
        %%
        Zneu=[NaN,NaN];
        while sol.x(end) < tspan(end)                                           % solange Endzeit nicht erreicht...
            sol = odextend(sol, Modell, tspan(end), Zneu,odeset());                 % ...setze Simulation mit V = Vneu fort
            [Zneu]=[NaN,NaN];        % berechne Vneu
        end
        Zsol   = deval(sol,tspan);                        % zugehoerige Zustaende
    
    
    %
    
    ZSOL(:,:,Z0i)=[NaN(length(0:dt:tstart-dt),2);Zsol'];
    Events(Z0i,:)=[sol.xe(end),sol.ye(1,end),sol.ye(2,end)];
   
%%
    end

end


function [position,isterminal,direction] = stopSim(tsol,Zsol,Border,pos_islands,rv,tstart)
    
    position =any(Zsol(1,end)>(Border)| ...
                norm(Zsol(:,end)-pos_islands(3,:)')<(0.2+rv(3))| ...
                tsol-tstart>=2.5); % The value that we want to be zero
    isterminal = 1;  % Halt integration 
    direction = 0;   % The zero can be approached from either direction
end












