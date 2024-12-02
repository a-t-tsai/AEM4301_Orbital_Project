function [rsc,vsc] = propagate(h,a,e,w,E0,days1,days2,rsc,vsc)
mu = 1.327e11;
for k=days1:days2
    M=sqrt(mu/a^3)*(k-days1)*3600*24+E0-e*sin(E0);
    E=kepler_E(e,M);
    Rot=[cos(-w) sin(-w) 0;-sin(-w) cos(-w) 0;0 0 1];
    rv=Rot*[a*cos(E)-e*a;a*sqrt(1-e^2)*sin(E);0]; %postion vector
    vv=Rot*mu/h*[-sqrt(1-e^2)*sin(E);(1-e^2)*cos(E);0]/(1-e*cos(E));
    rsc(k,:)=[rv(1), rv(2),0];
    vsc(k,:)=[vv(1), vv(2),0];
end