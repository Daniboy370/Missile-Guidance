clear all
syms r(t) t tf r0 v0 real

dr  = diff(r);
ddr = diff(r,t,2);
Eqn = (tf-t)^2*ddr + 3*(tf-t)*dr + 3*r == 0;
Cond = [r(0)==r0 dr(0) == v0];

R_t = dsolve(Eqn, Cond, t)

diff( ((tf-t)^3)*(r0+v0*tf)/tf^3, t, 2)
