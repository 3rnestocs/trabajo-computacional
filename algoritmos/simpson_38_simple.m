% simpson_38_simple.m
% Regla de Simpson 3/8 (aplicación simple)
% Basado en el pseudocódigo de la Figura 21.13b (pseudocodigo.txt)
%
% Parámetros:
%   h  : ancho del subintervalo (h = (b-a)/3)
%   f0 : valor de la función en el extremo izquierdo (f(a))
%   f1 : valor de la función en el primer tercio (f(a+h))
%   f2 : valor de la función en el segundo tercio (f(a+2h))
%   f3 : valor de la función en el extremo derecho (f(b))
%
% Salida:
%   I  : aproximación de la integral
%
% Referencia:
%   Figura 21.13b: FUNCTION Simpl8(h, f0, f1, f2, f3)
%   Implementa la fórmula de Simpson 3/8 para un solo segmento.

function I = simpson_38_simple(h, f0, f1, f2, f3)
    I = 3 * h * (f0 + 3 * (f1 + f2) + f3) / 8;
end
