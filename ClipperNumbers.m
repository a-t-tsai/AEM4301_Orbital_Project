mu = 1.327E11;
r1 = 1.496E8;
r2 = 338.22E6;
n = sqrt(mu/r2^3);
t12 = pi * sqrt(((r1+200) + r2)^3 / (8 * mu));
TofDay = t12 / 1.15741*10^-5;
Lead_angle = (pi - n*t12) * (180/pi)
% Vinf
dv = sqrt((2*mu/r1)-(2*mu/(r1+r2))) - sqrt(mu/r1)
