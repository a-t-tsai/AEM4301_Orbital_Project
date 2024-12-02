function [h,a,e,w,E0]=scElements(R,V)
    mu=1.327E11;
    r=norm(R);
    v=norm(V);
    H=cross(R,V);
    h=norm(H);
    C=-cross(H,V)-mu*R/norm(R);
    c=norm(C);
    Energy=v^2/2-mu/r;
    e=sqrt(1+2*Energy*h^2/mu^2);
    a=-mu/2/Energy;
    w=acos(dot(C,[1 0 0])/c);
    h=sqrt(mu^2/2/Energy*(e^2-1));
    if C(2)<0
        w=-w;
    end
    theta0=acos(dot(R,C)/c/r);
    if dot(R,V)<0
        theta0=2*pi-theta0;
    end
    E0=acos((e+cos(theta0))/(1+e*cos(theta0)));
    if theta0>pi
        E0=2*pi-E0;
    end