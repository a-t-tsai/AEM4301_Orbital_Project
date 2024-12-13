% Load flyby data from app
load venusFB1.mat
% Calculate the velocity after the flyby
%function [Vout,DeltaMin]=flyby(Vp,Vsc,Delta,mu,rp,ccw)
[Vsc1,DeltaMin]=flyby(Vp1,Vsc1,5.25e3,42828,3396,0);
DeltaMin %Can output Deltamin to keep the aiming radius above this value
%Calculate the orbital elements for the spacecraft after the flyby
[h,a,e,w,E0]=scElements(R1,Vsc1);
%propagate orbit to end
[rsc,vsc]=propagate(h,a,e,w,E0,fbday1+1,maxDays,rsc,vsc);



