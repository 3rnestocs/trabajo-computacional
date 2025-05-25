% lagrange_interp.m
% Interpolación de Lagrange
% Basado en el pseudocódigo de la Figura 18.11 (pseudocodigo.txt)
%
% Parámetros:
%   x    : vector de nodos x_i
%   y    : vector de valores y_i = f(x_i)
%   xi   : punto donde se interpola
%
% Salida:
%   yint : valor interpolado en xi
%
% Variables internas:
%   n      : grado del polinomio (n = length(x)-1)
%   L      : polinomio de Lagrange para cada i
%   yint   : suma acumulada de los productos
%
% Referencia:
%   Figura 18.11: FUNCTION Lagrng(x, y, n, x)
%   Implementa la suma de productos de Lagrange para interpolación.

function yint = lagrange_interp(x, y, xi)
    n = length(x);
    yint = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if i ~= j
                L = L * (xi - x(j)) / (x(i) - x(j));
            end
        end
        yint = yint + y(i) * L;
    end
end
