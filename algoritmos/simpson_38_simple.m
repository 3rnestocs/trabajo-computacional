function I = simpson_38_simple(h, f0, f1, f2, f3)
% simpson_38_simple: Regla de Simpson 3/8 simple
% Entradas:
%   h  - ancho del segmento
%   f0 - valor en el primer nodo
%   f1 - valor en el segundo nodo
%   f2 - valor en el tercer nodo
%   f3 - valor en el cuarto nodo
% Salida:
%   I  - aproximación de la integral

I = 3 * h * (f0 + 3 * (f1 + f2) + f3) / 8;
end
