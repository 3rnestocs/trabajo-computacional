function I = simpson_13_multiple(h, f)
% simpson_13_multiple: Regla de Simpson 1/3 para múltiples segmentos (n par)
% Entradas:
%   h - ancho de cada segmento
%   f - vector de valores de la función en los nodos
% Salida:
%   I - aproximación de la integral

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
