function I = simpson_13_simple(h, f0, f1, f2)
% simpson_13_simple: Regla de Simpson 1/3 simple
% Entradas:
%   h  - ancho del segmento
%   f0 - valor en el primer nodo
%   f1 - valor en el nodo medio
%   f2 - valor en el último nodo
% Salida:
%   I  - aproximación de la integral

I = 2 * h * (f0 + 4 * f1 + f2) / 6;
end
