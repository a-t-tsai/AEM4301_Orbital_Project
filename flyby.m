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

%\\\\\\\\\\\\code testing
% figure
% hold on
% plot([0,Vp(1)],[0,Vp(2)],'r')
% plot([0,Vsc(1)],[0,Vsc(2)],'g')
% plot([0,VinfIn(1)],[0,VinfIn(2)],'b')
% plot([0,VinfOut(1)],[0,VinfOut(2)],'m')
% legend('Planet','Spacecraft','VinfIn','VinfOut')
% axis equal
% hold off

figure
hold on
quiver(0,0,Vp(1),Vp(2),0,'r','LineWidth',2)
quiver(Vp(1),Vp(2),VinfIn(1),VinfIn(2),0,'b','LineWidth',2)
quiver(0,0,Vout(1),Vout(2),0,'g','LineWidth',2)
plot(0,0,'ko','MarkerSize',10)
% add labels
text(Vp(1)/2,Vp(2)/2,'Vp')
text(Vp(1)+VinfIn(1)/2,Vp(2)+VinfIn(2)/2,'VinfIn')
text(Vout(1)/2,Vout(2)/2,'Vout')

