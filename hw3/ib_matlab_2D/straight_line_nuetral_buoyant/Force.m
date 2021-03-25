function F=Force(X)
global theta0 K Nb dtheta Lp L;
X_bar = X-L/2;
vec = ([0:Nb-1]*dtheta-Lp)*X_bar*dtheta;
vec = vec/norm(vec);
theta0 = cart2pol(vec(1),vec(2));
F=K*(([0:Nb-1]'*dtheta-Lp)*vec-X_bar);
end