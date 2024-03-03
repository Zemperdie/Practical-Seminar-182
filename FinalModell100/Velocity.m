%% Calculate Flowfield


function [v]=Velocity(X,Y,t,pos_islands,radiusv,xy)
    %%
    if nargin==5
        xy=3;
    end
    
    load par.mat L Tc alpha w u0 a 
    n_islands=size(pos_islands,1);
    
    %% Functions
    y0=@(t,r)r/2;
    
    x1=@(t,xoff,r) xoff+r+L.*mod(t./Tc,1);
    x2=@(t,xoff,r) x1(t-Tc./2,xoff,r);
    
    
    y1=@(t,yoff,r)  y0(t,r)+yoff;
    y2=@(t,yoff,r) -y0(t,r)+yoff;
    
    h1=@(t) sin(pi.*t./Tc).^2;
    h2=@(t) h1(t-Tc./2);
    
    k0=@(r) 1./r.^2;
    
    s=@(x,y,xoff,yoff,r) 1-exp(-(x-r-xoff).^2./alpha.^2-(y-yoff).^2);
    sdx=@(x,y,xoff,yoff,r) ...
        (2.*(x-r-xoff).*exp(-(x-r-xoff).^2./alpha.^2-(y-yoff).^2))./alpha.^2;
    sdy=@(x,y,xoff,yoff,r) ...
        2.*(y-yoff).*exp(-(x-r-xoff).^2./alpha.^2-(y-yoff).^2);
    
    
    g1=@(x,y,t,xoff,yoff,r) ...
        exp(-k0(r).*((x-x1(t,xoff,r)).^2+alpha.*(y-y1(t,yoff,r)).^2));
    g1dx=@(x,y,t,xoff,yoff,r) ...
        -2.*k0(r).*(x-x1(t,xoff,r)).*exp(-k0(r).*((x-x1(t,xoff,r))...
        .^2+alpha.*(y-y1(t,yoff,r)).^2));
    g1dy=@(x,y,t,xoff,yoff,r) ...
        -2.*alpha.*k0(r).*(y-y1(t,yoff,r)).*exp(-k0(r).*((x-x1(t,xoff,r))...
        .^2+alpha.*(y-y1(t,yoff,r)).^2));
    
    g2=@(x,y,t,xoff,yoff,r) ...
        exp(-k0(r).*((x-x2(t,xoff,r)).^2+alpha.*(y-y2(t,yoff,r)).^2));
    g2dx=@(x,y,t,xoff,yoff,r) ...
        -2.*k0(r).*(x-x2(t,xoff,r)).*exp(-k0(r).*((x-x2(t,xoff,r))...
        .^2+alpha.*(y-y2(t,yoff,r)).^2));
    g2dy=@(x,y,t,xoff,yoff,r) ...
        -2.*alpha.*k0(r).*(y-y2(t,yoff,r)).*exp(-k0(r).*((x-x2(t,xoff,r))...
        .^2+alpha.*(y-y2(t,yoff,r)).^2));
    
    g=@(x,y,t,xoff,yoff,r) ...
        -w.*h1(t).*g1(x,y,t,xoff,yoff,r)+w.*h2(t).*g2(x,y,t,xoff,yoff,r)...
        +u0.*s(x,y,xoff,yoff,r).*(y-yoff);
    gdx=@(x,y,t,xoff,yoff,r) ...
        -w.*h1(t).*g1dx(x,y,t,xoff,yoff,r)+w.*h2(t).*g2dx(x,y,t,xoff,yoff,r)...
        +u0.*sdx(x,y,xoff,yoff,r).*(y-yoff);
    gdy=@(x,y,t,xoff,yoff,r) ...
        -w.*h1(t).*g1dy(x,y,t,xoff,yoff,r)+w.*h2(t).*g2dy(x,y,t,xoff,yoff,r)...
        +u0.*sdy(x,y,xoff,yoff,r).*(y-yoff)+u0.*s(x,y,xoff,yoff,r);
    
    
    f=@(x,y,xoff,yoff,r)    1-exp(-a.*(sqrt((x-xoff).^2+(y-yoff).^2)-r).^2);
    fdx=@(x,y,xoff,yoff,r) ...
        (2.*a.*(x-xoff).*(sqrt((x-xoff).^2+(y-yoff).^2)-r)...
        .*(1-f(x,y,xoff,yoff,r)))./sqrt((x-xoff).^2+(y-yoff).^2);
    fdy=@(x,y,xoff,yoff,r) ...
        (2.*a.*(y-yoff).*(sqrt((x-xoff).^2+(y-yoff).^2)-r)...
        .*(1-f(x,y,xoff,yoff,r)))./sqrt((x-xoff).^2+(y-yoff).^2);
    
    
    
    %% Linear Combination: Backgroundflow + Flow arround Islands
    
    vx=0;
    vy=0;
    
    for ii=1:n_islands
        vx=vx+fdy(X,Y,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii))...
            .*g(X,Y,t,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii))...
             +f(X,Y,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii)) ...
            .*gdy(X,Y,t,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii));
        vy=vy+(-fdx(X,Y,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii))...
            .*g(X,Y,t,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii)) ...
             -f(X,Y,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii)) ...
            .*gdx(X,Y,t,pos_islands(ii,1),pos_islands(ii,2),radiusv(ii)));
    end
    
        vx=vx-u0.*(n_islands-1);
    
    %% Generate Output
    
    if xy==1
        v=vx;
    elseif xy==2
        v=vy;
    else
        v=[vx;vy];
end