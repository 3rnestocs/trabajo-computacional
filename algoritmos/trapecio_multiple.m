% trapecio_multiple.m
% Regla del Trapecio (múltiples segmentos)
% Basado en el pseudocódigo de la Figura 21.9b (pseudocodigo.txt)
%
% Parámetros:
%   h  : ancho de cada subintervalo
%   f  : vector de valores de la función en los nodos (f(x_0), ..., f(x_n))
%
% Salida:
%   I  : aproximación de la integral
%
% Variables internas:
%   n  : número de subintervalos (length(f)-1)
%   sum: suma acumulada según la regla
%
% Referencia:
%   Figura 21.9b: FUNCTION Trapm(h, n, f)
%   Implementa la fórmula del trapecio para múltiples segmentos.

function I = trapecio_multiple(h, f)
    n = length(f) - 1;
    suma = f(1);
    for i = 2:n
        suma = suma + 2 * f(i);
    end
    suma = suma + f(n+1);
    I = h * suma / 2;
end
