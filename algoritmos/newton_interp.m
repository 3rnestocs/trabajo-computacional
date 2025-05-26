% newton_interp.m
% Interpolación de Newton (Diferencias Divididas)
% Basado en el pseudocódigo de la Figura 18.7 (pseudocodigo.txt)
%
% Parámetros:
%   x           : vector de nodos x_i
%   y           : vector de valores y_i = f(x_i)
%   xi          : punto donde se interpola
%   valor_verdadero: valor exacto de la función en xi (opcional)
%
% Salidas:
%   yint        : valor interpolado en xi
%   ea          : estimación del error basado en el último término (%)
%   er          : error relativo porcentual respecto al valor verdadero (%)
%
% Variables internas:
%   n      : grado del polinomio (n = length(x)-1)
%   fdd    : tabla de diferencias divididas
%   xterm  : producto acumulado (xi - x_j)
%   incremento : contribución del último término del polinomio

function [yint, er] = newton_interp(x, y, xi, valor_verdadero)
    % Verificar que x e y tengan la misma longitud
    if length(x) ~= length(y)
        error('Los vectores x e y deben tener la misma longitud.');
    end

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
    incremento = 0;

    for order = 2:n
        xterm = xterm * (xi - x(order-1));
        incremento = fdd(1,order) * xterm;
        yint = yint + incremento;
    end

    % Cálculo del error relativo porcentual según la fórmula
    if nargin == 4 && ~isempty(valor_verdadero)
        if valor_verdadero ~= 0
            er = abs((valor_verdadero - yint) / valor_verdadero) * 100;
        else
            er = Inf;  % Evitar división por cero
        end
    else
        er = NaN;  % No se proporcionó valor verdadero
    end
end