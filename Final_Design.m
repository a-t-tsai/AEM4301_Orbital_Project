mu = 1.327E11;
r1 = 1.496E8;
r2 = 7.786E8;
n = sqrt(mu/r2^3);
t12 = pi * sqrt( (r1 + r2)^3 / (8 * mu));

phi = pi - n*t12

dv = sqrt((2*mu/r1)-(2*mu/(r1+r2))) - sqrt(mu/r1)
