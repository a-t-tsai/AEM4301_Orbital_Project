function [Vout,DeltaMin]=flyby(Vp,Vsc,Delta,mu,rp,ccw)
%function [Vout,DeltaMin]=flyby(Vp,Vsc,Delta,mu,rp,ccw)
%Calculate the heliocentric spacecraft velocity after the flyby 
%for given values of:
% Vp= planet velocity vector
% Vsc= spacecraft heliocentric velocity 
% Delta = aiming radius
% mu = planet gravitational parameter
% rp = planet radius
% ccw = 1 for counterclockwise turn, 0 othrwise

VinfIn=Vsc-Vp;

thetaIn=atan2(VinfIn(2),VinfIn(1));
vinf = norm(VinfIn);
h=vinf*Delta;
En=vinf^2/2;
e=sqrt(1+2*En*h^2/mu^2);
turn=2*asin(1/e);
if ccw == 1
    thetaOut=thetaIn + turn;
else
    thetaOut=thetaIn - turn;
end
DeltaMin = sqrt(2*mu/rp/vinf^2+1)*rp;
if Delta<DeltaMin
    s=sprintf('You crashed! DeltaMin= %f',DeltaMin);
    error(s)
end
VinfOut=vinf*[cos(thetaOut),sin(thetaOut),0];
Vout=Vp+VinfOut;
