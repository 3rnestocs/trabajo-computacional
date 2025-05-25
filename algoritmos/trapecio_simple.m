% trapecio_simple.m
% Regla del Trapecio (un segmento)
% Basado en el pseudocódigo de la Figura 21.9a (pseudocodigo.txt)
%
% Parámetros:
%   h  : ancho del intervalo (b - a)
%   f0 : valor de la función en el extremo izquierdo (f(a))
%   f1 : valor de la función en el extremo derecho (f(b))
%
% Salida:
%   I  : aproximación de la integral
%
% Referencia:
%   Figura 21.9a: FUNCTION Trap(h, f0, f1)
%   Implementa la fórmula del trapecio para un solo segmento.

function I = trapecio_simple(h, f0, f1)
    I = h * (f0 + f1) / 2;
end
