function [rsc,vsc,finalDate] = dsm_to_flyby(initialDate)
%function [rsc,vsc,finalDate] = dsm_to_flyby(initialDate)

% When designing a return trajectory to Earth (for a flyby), 
% we need to determine two things: 1. Initial heliocentric change in
% velocity, 2. The amount of Delta V for the DSM. A good starting point can
% be obtained by considering Juno's trajectory and attempting to recreate
% the size/shape of that orbit.

% The trajectory created by this function can serve as a starting point.
% Refine the values used through iteration and add the flyby of Earth. When
% should the mission start for interception of Jupiter?

%% Initialize

    mu=1.327e11;          % Gravitational parameter for Sun

    maxDays=1000;         % Number of days to follow the spaceraft 

    dsmDay = 255;         % This is the dayCount where DSM is executed
                          % Can be refined (near apoapsis)
    fbday1 = 1000;         % This will be the day of flyby. Can be refined.

    rsc=zeros(maxDays,3); % Position vector array for spacecraft
    vsc=zeros(maxDays,3); % Velocity vector array for spacecraft

    finalDate=initialDate+days(maxDays); %date when sc stops appearing in simulation
    
    launchDay=12; % # of days to launch from Start Date (can be changed).

    tinit=datetime(initialDate); %initial date in date format
%% Stay on Earth until day of launch; use Curtis function

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

    % A rough possible value for the heliocentric velocity change is used
    % below. Can be improved through trial and error
    
    Vsc = V + 5.4*V/norm(V); 
   
    % Calculate the orbital elements for spacecraft
    [h,a,e,w,E0]=scElements(R,Vsc);

    % new orbit for spacecraft. Propagate until the day DSM is executed
    % (dsmDay defined above).
    [rsc,vsc]=propagate(h,a,e,w,E0,launchDay+1,dsmDay,rsc,vsc);

   % On dsmDay we will do a retrograde burn say 

   Vsc = vsc(dsmDay,:); %velocity on dsmDay
   R = rsc(dsmDay,:); %Position vector on dsmDay
   Vsc=Vsc - 1*Vsc/norm(Vsc); % Decrease velocity. Experiment with magnitude of Delta V here.

   % Determine orbital elements of resulting trajectory
   [h,a,e,w,E0]=scElements(R,Vsc);   

   %propagate until interception of Earth fbday1 (defined above but can
   %change)

   [rsc,vsc]=propagate(h,a,e,w,E0,dsmDay+1,fbday1,rsc,vsc);

   % Now execute the flyby and propagate all the way to Jupiter


 
