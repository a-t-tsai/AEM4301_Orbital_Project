function [rsc,vsc,finalDate] = JunoTransfer(initialDate)
    % Simulates a Juno Transfer to Jupiter
    % Set initial date in app to 11/20/2026
    % According to the theorertical calculations, launchDay will be 12.
    
    %% Initialize
        mu=1.327e11;          %Gravitational parameter for Sun
    
        maxDays=1800;         % Number of days to follow the spaceraft = t12
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
    
        Vsc = V + 5.2884*V/norm(V); 
       
    
        % Calculate the orbital elements for spacecraft
       [h,a,e,w,E0]=scElements(R,Vsc);
    
        % new orbit for spacecraft
       [rsc,vsc]=propagate(h,a,e,w,E0,launchDay+1,maxDays,rsc,vsc);
    
       %This worked pretty well. We can still adjust the launch day for closer
       %interception.

       %% create and if statement that if days after start date = 791, then go into a new velocity Vsc2 of V+6*V/norm(V)

         if launchDay+791<=maxDays
              Vsc2=V+20*V/norm(V);
              [h,a,e,w,E0]=scElements(R,Vsc2);
              [rsc,vsc]=propagate(h,a,e,w,E0,launchDay+792,maxDays,rsc,vsc);
         end