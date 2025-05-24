% main.m: Menú principal para ejecutar algoritmos numéricos
clear; clc;

addpath('algoritmos');

while true
    fprintf('\n--- Menú de Métodos Numéricos ---\n');
    fprintf('1. Interpolación de Newton\n');
    fprintf('2. Interpolación de Lagrange\n');
    fprintf('3. Regla del Trapecio (simple)\n');
    fprintf('4. Regla del Trapecio (múltiples segmentos)\n');
    fprintf('5. Regla de Simpson 1/3 (simple)\n');
    fprintf('6. Regla de Simpson 3/8 (simple)\n');
    fprintf('7. Regla de Simpson 1/3 (múltiple)\n');
    fprintf('8. Regla de Simpson mixta (par/impar)\n');
    fprintf('9. Salir\n');
    opcion = input('Seleccione una opción: ');

    switch opcion
        case 1
            % Ejemplo: Interpolación de Newton
            x = [0 1 2 3];
            y = [1 2.7183 7.3891 20.0855]; % e^x
            xi = input('Ingrese el valor de x para interpolar: ');
            [yint, ea] = newton_interp(x, y, xi);
            fprintf('Valor interpolado en x=%.4f: %.6f\n', xi, yint);
            fprintf('Estimación del error: %.2e\n', ea);
            % Gráfica
            xx = linspace(min(x), max(x), 100);
            yy = arrayfun(@(z) newton_interp(x, y, z), xx);
            plot(x, y, 'ro', xx, yy, 'b-', xi, yint, 'ks', 'MarkerFaceColor','k');
            title('Interpolación de Newton');
            xlabel('x'); ylabel('y');
            legend('Datos','Polinomio','Interpolado','Location','Best');
            grid on;

        case 2
            % Ejemplo: Interpolación de Lagrange
            x = [0 pi/4 pi/2];
            y = sin(x);
            xi = input('Ingrese el valor de x para interpolar: ');
            yint = lagrange_interp(x, y, xi);
            fprintf('Valor interpolado en x=%.4f: %.6f\n', xi, yint);
            % Gráfica
            xx = linspace(min(x), max(x), 100);
            yy = arrayfun(@(z) lagrange_interp(x, y, z), xx);
            plot(x, y, 'ro', xx, yy, 'b-', xi, yint, 'ks', 'MarkerFaceColor','k');
            title('Interpolación de Lagrange');
            xlabel('x'); ylabel('y');
            legend('Datos','Polinomio','Interpolado','Location','Best');
            grid on;

        case 3
            % Ejemplo: Trapecio simple
            f = @(x) exp(x);
            a = 0; b = 1;
            h = b - a;
            I = trapecio_simple(h, f(a), f(b));
            fprintf('Integral aproximada de e^x en [0,1]: %.6f\n', I);

        case 4
            % Ejemplo: Trapecio múltiple
            f = @(x) sin(x);
            a = 0; b = pi;
            n = 4;
            h = (b - a) / n;
            x = a:h:b;
            fx = f(x);
            I = trapecio_multiple(h, fx);
            fprintf('Integral aproximada de sin(x) en [0,pi] con %d segmentos: %.6f\n', n, I);

        case 5
            % Ejemplo: Simpson 1/3 simple
            f = @(x) 1./(1 + x.^2);
            a = 0; b = 1;
            h = (b - a) / 2;
            I = simpson_13_simple(h, f(a), f((a+b)/2), f(b));
            fprintf('Integral aproximada de 1/(1+x^2) en [0,1]: %.6f\n', I);

        case 6
            % Ejemplo: Simpson 3/8 simple
            f = @(x) x.^3;
            a = 0; b = 1;
            h = (b - a) / 3;
            I = simpson_38_simple(h, f(a), f(a+h), f(a+2*h), f(b));
            fprintf('Integral aproximada de x^3 en [0,1]: %.6f\n', I);

        case 7
            % Ejemplo: Simpson 1/3 múltiple
            f = @(x) cos(x);
            a = 0; b = pi/2;
            n = 4; % Debe ser par
            h = (b - a) / n;
            x = a:h:b;
            fx = f(x);
            I = simpson_13_multiple(h, fx);
            fprintf('Integral aproximada de cos(x) en [0,pi/2] con %d segmentos: %.6f\n', n, I);

        case 8
            % Ejemplo: Simpson mixto (n impar)
            f = @(x) log(x+1);
            a = 0; b = 1;
            n = 5; % Impar
            h = (b - a) / n;
            x = a:h:b;
            fx = f(x);
            I = simpson_mixto(a, b, n, fx);
            fprintf('Integral aproximada de ln(x+1) en [0,1] con %d segmentos: %.6f\n', n, I);

        case 9
            disp('¡Hasta luego!');
            break;

        otherwise
            disp('Opción no válida. Intente de nuevo.');
    end
end
