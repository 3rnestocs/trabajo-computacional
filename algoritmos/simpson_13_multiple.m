% simpson_13_multiple.m
% Regla de Simpson 1/3 (aplicación múltiple, n par)
% Basado en el pseudocódigo de la Figura 21.13c (pseudocodigo.txt)
%
% Parámetros:
%   h  : ancho de cada subintervalo
%   f  : vector de valores de la función en los nodos (f(x_0), ..., f(x_n))
%
% Salida:
%   I  : aproximación de la integral
%
% Variables internas:
%   n    : número de subintervalos (length(f)-1)
%   suma : suma acumulada según la regla
%
% Referencia:
%   Figura 21.13c: FUNCTION Simpl3m(h, n, f)
%   Implementa la fórmula de Simpson 1/3 para múltiples segmentos.

function I = simpson_13_multiple(h, f)
    % Integración numérica por el método de Simpson 1/3 múltiple
    % h: tamaño del paso (debe ser constante)
    % f: vector de valores de la función en puntos equiespaciados

    n = length(f) - 1; % Número de segmentos

    % Verificar que el número de segmentos sea par
    if mod(n, 2) ~= 0
        error('El número de segmentos debe ser par para Simpson 1/3 múltiple.');
    end

    % Inicializar suma con el primer término (peso 1)
    suma = f(1);

    % Sumar términos intermedios con pesos alternados 4 y 2
    for i = 2:n
        if mod(i-1, 2) == 0 % Términos pares (peso 2)
            suma = suma + 2 * f(i);
        else % Términos impares (peso 4)
            suma = suma + 4 * f(i);
        end
    end

    % Agregar el último término (peso 1)
    suma = suma + f(n+1);

    % Calcular la integral
    I = (h / 3) * suma;
end
