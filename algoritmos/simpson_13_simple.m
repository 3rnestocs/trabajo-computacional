% simpson_13_simple.m
% Regla de Simpson 1/3 (aplicación simple)
% Basado en el pseudocódigo de la Figura 21.13a (pseudocodigo.txt)
%
% Parámetros:
%   h  : ancho del subintervalo (h = (b-a)/2)
%   f0 : valor de la función en el extremo izquierdo (f(a))
%   f1 : valor de la función en el punto medio (f((a+b)/2))
%   f2 : valor de la función en el extremo derecho (f(b))
%
% Salida:
%   I  : aproximación de la integral
%
% Referencia:
%   Figura 21.13a: FUNCTION Simpl3(h, f0, f1, f2)
%   Implementa la fórmula de Simpson 1/3 para un solo segmento.

function I = simpson_13_simple(h, f0, f1, f2)
    I = 2 * h * (f0 + 4 * f1 + f2) / 6;
end
