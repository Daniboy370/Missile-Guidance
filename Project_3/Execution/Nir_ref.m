close all;
clc;
clear all;

%%%%%%%%%%%%%%%%lambda dot=0.018%%%%%%%%%%%%%%%%%%%%%5
ro_u=100;
ro_w=50;
delta_ro=ro_u-ro_w;
r=15000;
lambda=10*pi/180;
lambda_dot=0.018;
r_dot=-1280;

r_vec=[r*cos(lambda);
    r*sin(lambda)];
r_dot_vec=[r_dot*cos(lambda)-r*lambda_dot*sin(lambda);
    r_dot*sin(lambda)+r*lambda_dot*cos(lambda)];
v=r_dot_vec;

syms tgo real
eqn= delta_ro^2*tgo^4/4-norm(v)^2*tgo^2-2*(r_vec'*r_dot_vec)*tgo-norm(r_vec)^2;

result=double(solve(eqn==0,tgo))
tgo=min(result(result==real(result) & result>0))

r_2dot=-2*(1/tgo^2)*(r_vec+tgo*v);

k=1;
r_2dot_int(:,k)=r_2dot;
r_dot_int(:,k)=r_dot_vec;
r_int(:,k)=r_vec;
tgo_int(k)=tgo;
T=1/100;

while tgo>0.2
    r_dot_int(:,k+1)=r_dot_int(:,k)+r_2dot_int(:,k)*T;
    r_int(:,k+1)=r_int(:,k)+r_dot_int(:,k)*T;
    r_vec=r_int(:,k+1);
    r_dot_vec=r_dot_int(:,k+1);
    v=r_dot_vec;
    result= roots([delta_ro^2/4,0,-norm(v)^2,-2*(r_vec'*r_dot_vec),-norm(r_vec)^2]);
    tgo=min(result(result==real(result) & result>0));
    r_2dot=-2*(1/tgo^2)*(r_vec+tgo*v);
    r_2dot_int(:,k+1)=r_2dot;
    tgo_int(k+1)=tgo;
    k=k+1;
end;

%Plot ||r||
figure;
r_norm=sqrt(r_int(1,:).^2+r_int(2,:).^2);
plot(tgo_int,r_norm);
xlabel('tgo [sec]');
ylabel('distance [m]');
title('Trajectory Vs tgo (lambda dot=0.018 rad/sec)');

%Plot dr/dt
figure;
r_dot_norm=diff(r_norm)./diff(tgo_int);
plot(tgo_int(1:(end-1)),r_dot_norm);
hold on;
Vc=r_norm./tgo_int;
plot(tgo_int,Vc);
legend('dr/dt','Vc=r/tgo');
xlabel('tgo [sec]');
ylabel('speed [m/s]');
title('Velocity Vs tgo (lambda dot=0.018 rad/sec)');



%%%%%%%%%%%%%%%%lambda dot=0.022%%%%%%%%%%%%%%%%%%%%%5
clear all;

ro_u=100;
ro_w=50;
delta_ro=ro_u-ro_w;
r=15000;
lambda=10*pi/180;
lambda_dot=0.022;
r_dot=-1280;

r_vec=[r*cos(lambda);
    r*sin(lambda)];
r_dot_vec=[r_dot*cos(lambda)-r*lambda_dot*sin(lambda);
    r_dot*sin(lambda)+r*lambda_dot*cos(lambda)];
v=r_dot_vec;

syms tgo
eqn= delta_ro^2*tgo^4/4-norm(v)^2*tgo^2-2*(r_vec'*r_dot_vec)*tgo-norm(r_vec)^2;

result=double(solve(eqn==0,tgo));
result=round(result,4)
tgo=min(result(result==real(result) & result>0))

r_2dot=-2*(1/tgo^2)*(r_vec+tgo*v);

k=1;
r_2dot_int(:,k)=r_2dot;
r_dot_int(:,k)=r_dot_vec;
r_int(:,k)=r_vec;
tgo_int(k)=tgo;
T=1/100;

while tgo>0.2
    r_dot_int(:,k+1)=r_dot_int(:,k)+r_2dot_int(:,k)*T;
    r_int(:,k+1)=r_int(:,k)+r_dot_int(:,k)*T;
    r_vec=r_int(:,k+1);
    r_dot_vec=r_dot_int(:,k+1);
    v=r_dot_vec;
    result= roots([delta_ro^2/4,0,-norm(v)^2,-2*(r_vec'*r_dot_vec),-norm(r_vec)^2]);
    tgo=min(result(result==real(result) & result>0));
    r_2dot=-2*(1/tgo^2)*(r_vec+tgo*v);
    r_2dot_int(:,k+1)=r_2dot;
    tgo_int(k+1)=tgo;
    k=k+1;
end;


%Plot ||r||
figure;
r_norm=sqrt(r_int(1,:).^2+r_int(2,:).^2);
plot(tgo_int,r_norm);
xlabel('tgo [sec]');
ylabel('distance [m]');
title('Trajectory Vs tgo (lambda dot=0.022 rad/sec)');

%Plot dr/dt
figure;
r_dot_norm=diff(r_norm)./diff(tgo_int);
plot(tgo_int(1:(end-1)),r_dot_norm);
hold on;
Vc=r_norm./tgo_int;
plot(tgo_int,Vc);
legend('dr/dt','Vc=r/tgo');
xlabel('tgo [sec]');
ylabel('speed [m/s]');
title('Velocity Vs tgo (lambda dot=0.022 rad/sec)');