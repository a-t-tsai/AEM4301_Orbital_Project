function [rsc,vsc,finalDate] = ClipperTransfer(initialDate)
% Simulates a Juno Transfer to Jupiter
% Set initial date in app to 11/13/2026
% According to the theorertical calculations, launchDay will be 12.

%% Initialize
    mu = 1.327e11;          %Gravitational parameter for Sun

    maxDays=1375;         % Number of days to follow the spaceraft = t12
                         % for Earth-Venus transfer

    rsc=zeros(maxDays,3); % Position vector array for spacecraft
    vsc=zeros(maxDays,3); % Velocity vector array for spacecraft

    finalDate=initialDate+days(maxDays); %date when sc stops appearing in simulation
    
    launchDay=12; % # of days to launch from Start Date

    tinit=datetime(initialDate); %initial date in date format
%% Stay on Earth until day of launch use Curtis function

    for dayCount=1:launchDay
    t=tinit+days(dayCount-1); % index dayCount=1 corresponds to initial time.
    [y,m,d]=ymd(t);           % year month day format of current time

    % Use planet_elements_and_sv_coplanar to find current position and
    % velocity of Earth

    [~, r, v, ~] =planet_elements_and_sv_coplanar ...
    (1.327e11, 3, y, m, d, 0, 0, 0);

    % Update the position and velocity vectors
    rsc(dayCount,:)=[r(1),r(2),0];
    vsc(dayCount,:)=[v(1), v(2),0];
    end
 
%% Launch Maneuver
    t=tinit+days(launchDay);
    [y,m,d]=ymd(t);
    [~, R, V, ~] =planet_elements_and_sv_coplanar ...
    (1.327e11, 3, y, m, d, 0, 0, 0); %Earth on launch day

    %Per the theoretical calculations, the velocity of the spacecraft after
    %launch should be 2.5 km/s less than that of Earths and in the same
    %direction.

        Vsc = V + 6*V/norm(V); 
        % Hits mars at 170 days
        [h,a,e,w,E0] = scElements(R, Vsc);
        % new orbit for spacecraft
        [rsc,vsc] = propagate(h,a,e,w,E0,launchDay+1,maxDays,rsc,vsc);

% Next 
% 
load MarsClipperFB1.mat

   % Calculate the velocity after the flyby
   [Vsc1,DeltaMin]=flyby(Vp1,Vsc1,4900,42828,3396,0);
   DeltaMin %Can output Deltamin to keep the aiming radius above this value

   %Calculate the orbital elements for the spacecraft after the flyby
   [h,a,e,w,E0]=scElements(R1,Vsc1);

   %propagate orbit to end
   [rsc,vsc]=propagate(h,a,e,w,E0,148+1,790,rsc,vsc);

  % Last 

load EarthClipperFB1.mat

   % Calculate the velocity after the flyby
   [Vsc1,DeltaMin]=flyby(Vp1,Vsc1,9030.9,398600,6378,1);
   DeltaMin %Can output Deltamin to keep the aiming radius above this value

   %Calculate the orbital elements for the spacecraft after the flyby
   [h,a,e,w,E0]=scElements(R1,Vsc1);

   %propagate orbit to end
   [rsc,vsc]=propagate(h,a,e,w,E0,790+1,maxDays,rsc,vsc);
% 