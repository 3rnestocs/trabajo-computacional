function [yint, ea] = newton_interp(x, y, xi)
% newton_interp: Interpolación de Newton por diferencias divididas
% Entradas:
%   x  - vector de abscisas
%   y  - vector de ordenadas
%   xi - valor donde interpolar
% Salidas:
%   yint - valor interpolado en xi
%   ea   - estimación del error (último incremento)

n = length(x);
fdd = zeros(n, n);
fdd(:,1) = y(:);

% Cálculo de la tabla de diferencias divididas
for j = 2:n
    for i = 1:(n-j+1)
        fdd(i,j) = (fdd(i+1,j-1) - fdd(i,j-1)) / (x(i+j-1) - x(i));
    end
end

% Evaluación del polinomio en xi
yint = fdd(1,1);
xterm = 1;
ea = 0;
for order = 2:n
    xterm = xterm * (xi - x(order-1));
    incremento = fdd(1,order) * xterm;
    ea = incremento;
    yint = yint + incremento;
end
end
