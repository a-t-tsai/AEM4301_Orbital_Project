%% Variables
mu = 1.327E11;
r1 = 1.496E8;
r2 = 778.6E6;

%% Calculations for the jupiter hohmann transfer
n = sqrt(mu/r2^3);
t12 = pi * sqrt(((r1+200) + r2)^3 / (8 * mu));
TofDay = t12 / 1.15741*10^-5;
Lead_angle = (pi - n*t12) * (180/pi);

dv = sqrt((2*mu/r1)-(2*mu/(r1+r2))) - sqrt(mu/r1);
% change the dv to 8.725: to make it go halfway for an actual
% change the time of flight to 791 days to intercept it from halfway

%% Calculations for the Juno flyby

% trajectory to get outside mars orbit









