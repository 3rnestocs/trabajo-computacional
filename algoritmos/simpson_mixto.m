% simpson_mixto.m
% Regla de Simpson para n par o impar (mezcla 1/3 y 3/8)
% Basado en el pseudocódigo de la Figura 21.13d (pseudocodigo.txt)
%
% Parámetros:
%   a  : límite inferior de integración
%   b  : límite superior de integración
%   n  : número de segmentos (puede ser par o impar)
%   f  : vector de valores de la función en los nodos (f(x_0), ..., f(x_n))
%
% Salida:
%   I  : aproximación de la integral
%
% Variables internas:
%   h     : ancho de cada subintervalo
%   suma  : suma acumulada de las reglas
%   m     : número de segmentos para la parte 1/3
%   impar : indicador si n es impar
%   I38   : resultado de la parte Simpson 3/8 (si aplica)
%   I13   : resultado de la parte Simpson 1/3 (si aplica)
%
% Referencia:
%   Figura 21.13d: FUNCTION Simplnt(a, b, n, f)
%   Implementa la combinación de Simpson 1/3 y 3/8 para cualquier n.

function I = simpson_mixto(a, b, n, f)
    h = (b - a) / n;
    if n == 1
        I = trapecio_simple(h, f(1), f(2));
    else
        suma = 0;
        m = n;
        impar = mod(n,2);
        if impar ~= 0 && n > 1
            I38 = simpson_38_simple(h, f(n-2), f(n-1), f(n), f(n+1));
            m = n - 3;
            suma = suma + I38;
        end
        if m > 1
            I13 = simpson_13_multiple(h, f(1:m+1));
            suma = suma + I13;
        end
        I = suma;
    end
end
