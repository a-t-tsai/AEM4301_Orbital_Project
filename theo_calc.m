% theoretical calculation of the required Delta V and lead angle for a
% Earth to Jupiter Hohmann Transfer

% \\\\\\\ assuming ideal Hohmann transfer i.e. the orbits of earth and
% jupiter are circluar \\\\\\\\

mu1 = 398600; % Gravitational parameter for the departure planet (km^3/s^2)
r1 = 149.6*10^6; % Orbital radius of the departure planet (km)
p1 = 200 + 6378; % Parking orbit radius around the departure planet (km)
mu2 = 126686534; % Gravitational parameter for the arrival planet (km^3/s^2)
r2 = 778.6*10^6; % Orbital radius of the arrival planet (km)
p2 = 200 + 71490; % Parking orbit radius around the arrival planet (km)
muSun = 132712441018; % Gravitational parameter for the Sun (km^3/s^2)

% Functions
Vdepart = @(r1, r2) sqrt(muSun/r1)*(sqrt((2*r2)/(r1+r2))-1);
Varrive = @(r1, r2) sqrt(muSun/r2)*(1-sqrt((2*r1)/(r1+r2)));
Vp = @(V, mu, r) sqrt((V^2) + (2*mu)/r);
Vsc = @(mu, r) sqrt(mu/r);

% Calculations for the delta V
Vd = Vdepart(r1, r2);
Va = Varrive(r1, r2);
Vp1 = Vp(Vd, mu1, r1);
Vp2 = Vp(Va, mu2, r2);
Vsc1 = Vsc(mu1, p1);
Vsc2 = Vsc(mu2, p2);

deltaV1 = abs(Vp1 - Vsc1);
deltaV2 = abs(Vp2 - Vsc2);
deltaVtot = abs(deltaV1 + deltaV2);

% Calculations for the lead angle
T_E = 2*pi*sqrt(r1^3/mu1);
T_J = 2*pi*sqrt(r2^3/mu2);

One_way_t = (pi/sqrt(muSun))*(((r1+r2)/2)^(3/2));
n = @(T) (2*pi)/T;
si = pi-n(T_E)*One_way_t;

% Output results
fprintf('Delta-V for departure: %.2f km/s\n', deltaV1);
fprintf('Delta-V for arrival: %.2f km/s\n', deltaV2);
fprintf('Total Delta-V: %.2f km/s\n', deltaVtot);
fprintf('Departure Lead Angle: %.2f degrees\n', rad2deg(si));