% simpson_13_multiple.m
% Regla de Simpson 1/3 (aplicación múltiple, n par)
% Basado en el pseudocódigo de la Figura 21.13c (pseudocodigo.txt)
%
% Parámetros:
%   h  : ancho de cada subintervalo
%   f  : vector de valores de la función en los nodos (f(x_0), ..., f(x_n))
%
% Salida:
%   I  : aproximación de la integral
%
% Variables internas:
%   n    : número de subintervalos (length(f)-1)
%   suma : suma acumulada según la regla
%
% Referencia:
%   Figura 21.13c: FUNCTION Simpl3m(h, n, f)
%   Implementa la fórmula de Simpson 1/3 para múltiples segmentos.

function I = simpson_13_multiple(h, f)
    n = length(f) - 1;
    if mod(n,2) ~= 0
        error('El número de segmentos debe ser par para Simpson 1/3 múltiple.');
    end
    suma = f(1);
    for i = 2:2:n
        suma = suma + 4 * f(i);
        if i+1 <= n
            suma = suma + 2 * f(i+1);
        end
    end
    suma = suma - 2 * f(n+1) + f(n+1); % Ajuste para el último término
    I = h * suma / 3;
end
