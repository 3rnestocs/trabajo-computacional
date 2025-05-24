function yint = lagrange_interp(x, y, xi)
% lagrange_interp: Interpolación de Lagrange
% Entradas:
%   x  - vector de abscisas
%   y  - vector de ordenadas
%   xi - valor donde interpolar
% Salida:
%   yint - valor interpolado en xi

n = length(x);
yint = 0;
for i = 1:n
    producto = y(i);
    for j = 1:n
        if i ~= j
            producto = producto * (xi - x(j)) / (x(i) - x(j));
        end
    end
    yint = yint + producto;
end
end
