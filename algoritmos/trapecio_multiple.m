function I = trapecio_multiple(h, f)
% trapecio_multiple: Regla del trapecio para múltiples segmentos
% Entradas:
%   h - ancho de cada segmento
%   f - vector de valores de la función en los nodos
% Salida:
%   I - aproximación de la integral

n = length(f) - 1;
suma = f(1);
for i = 2:n
    suma = suma + 2 * f(i);
end
suma = suma + f(n+1);
I = h * suma / 2;
end
