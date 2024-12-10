function [rsc,vsc,finalDate] = spacecraft_a(initialDate)
%function [rsc,vsc,finalDate] = spacecraft(initialDate)
mu = 1.327E11;
r1 = 1.496E8;
r2 = 7.786E8;
n = sqrt(mu/r2^3);
t12 = pi * sqrt( (r1 + r2)^3 / (8 * mu));

phi = pi - n*t12;

dv = sqrt((2*mu/r1)-(2*mu/(r1+r2))) - sqrt(mu/r1);
%This is a placeholder function. The spacecraft stays on Earth.
%% Initialize

    maxDays=3000;         % Number of days to follow the spaceraft
    rsc=zeros(maxDays,3); % Position vector array for spacecraft
    vsc=zeros(maxDays,3); % Velocity vector array for spacecraft

            
    finalDate=initialDate+days(maxDays); %date when sc stops appearing in simulation
    launchDay=1; % # of days to launch Not used in this function

    tinit=datetime(initialDate); %date format
%% Stay on Earth until day of launch

    for dayCount=1:maxDays
    t=tinit+days(dayCount-1); % index dayCount=1 corresponds to initial time.
    [y,m,d]=ymd(t);           % year month day format of current time

    % Use planet_elements_and_sv_coplanar to find current position and
    % velocity

    [~, r, v, ~] =planet_elements_and_sv_coplanar ...
    (1.327e11, 3, y, m, d, 0, 0, 0);

    % Update the position and velocity vectors
    rsc(dayCount,:)=[r(1),r(2),0];
    vsc(dayCount,:)=[v(1), v(2),0];
    end