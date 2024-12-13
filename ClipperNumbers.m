mu = 1.327E11;
r1 = 1.496E8;
r2 = 227.9E6;
% r2 = 338.22E6;

%First Delta V
n1 = sqrt(mu/r2^3);
t12 = pi * sqrt(((r1+200) + r2)^3 / (8 * mu));
TofDay1 = t12 / 1.15741*10^-5;

Lead_angle1 = (pi - n*t12) * (180/pi);
dv1 = sqrt((2*mu/r1)-(2*mu/(r1+r2))) - sqrt(mu/r1);

% Second Delta V
n2 = sqrt(mu/r2^3);
t23 = pi * sqrt(((r1+200) + r2)^3 / (8 * mu));
TofDay2 = t12 / 1.15741*10^-5;

Lead_angle2 = (pi - n*t12) * (180/pi);
dv2 = sqrt((2*mu/r1)-(2*mu/(r1+r2))) - sqrt(mu/r1);