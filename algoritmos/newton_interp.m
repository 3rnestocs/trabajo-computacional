% newton_interp.m
% Interpolación de Newton (Diferencias Divididas)
% Basado en el pseudocódigo de la Figura 18.7 (pseudocodigo.txt)
%
% Parámetros:
%   x    : vector de nodos x_i
%   y    : vector de valores y_i = f(x_i)
%   xi   : punto donde se interpola
%
% Salidas:
%   yint : valor interpolado en xi
%   ea   : estimación del error (diferencia entre las dos últimas aproximaciones)
%
% Variables internas:
%   n      : grado del polinomio (n = length(x)-1)
%   fdd    : tabla de diferencias divididas
%   xterm  : producto acumulado (xi - x_j)
%   yint_k : aproximación en el paso k

% Referencia:
%   Figura 18.7: SUBROUTINE NewtInt (x, y, n, xi, yint, ea)
%   Implementa diferencias divididas y evaluación incremental del polinomio.

function [yint, ea] = newton_interp(x, y, xi)
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
