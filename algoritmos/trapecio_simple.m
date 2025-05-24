function I = trapecio_simple(h, f0, f1)
% trapecio_simple: Regla del trapecio para un solo segmento
% Entradas:
%   h  - ancho del segmento
%   f0 - valor de la función en el extremo izquierdo
%   f1 - valor de la función en el extremo derecho
% Salida:
%   I  - aproximación de la integral

I = h * (f0 + f1) / 2;
end
