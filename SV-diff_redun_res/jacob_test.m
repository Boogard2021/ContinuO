clear

syms x y z theta phi psi real

q = [x y z theta phi psi].';

J = jacobian(q,q)