function I = simpson_mixto(a, b, n, f)
% simpson_mixto: Regla de Simpson para n par o impar (mezcla 1/3 y 3/8)
% Entradas:
%   a - límite inferior
%   b - límite superior
%   n - número de segmentos
%   f - vector de valores de la función en los nodos
% Salida:
%   I - aproximación de la integral

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
