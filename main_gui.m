function main_gui()
% main_gui: Interfaz gráfica para métodos numéricos
% Ejecuta este archivo para abrir la GUI del proyecto

addpath('algoritmos');

  % Ventana principal con márgenes
    f = figure( ...
        'Name','Métodos Numéricos', ...
        'NumberTitle','off', ...
        'MenuBar','none', ...
        'Resize','on', ...
        'Units','normalized', ...
        'Position',[0.05 0.05 0.9 0.9], ...    % 90% de ancho/alto
        'WindowStyle','normal' ...
    );
movegui(f, 'center');

% Panel izquierdo para controles
panel_izq = uipanel('Parent',f, 'Title','Opciones y Datos', ...
                        'FontSize',12, 'Units','normalized', ...
                        'Position',[0.02 0.1 0.28 0.8]);

metodos = {'Interpolación de Newton','Interpolación de Lagrange', ...
           'Trapecio (simple)','Trapecio (múltiple)', ...
           'Simpson 1/3 (simple)','Simpson 3/8 (simple)', ...
           'Simpson 1/3 (múltiple)','Simpson mixto (par/impar)'};

hMetodo = uicontrol('Parent',panel_izq,'Style','popupmenu','String',metodos,'Units','normalized', ...
    'Position',[0.1 0.85 0.8 0.07],'FontSize',11);

hLabel1 = uicontrol('Parent',panel_izq,'Style','text','Units','normalized','Position',[0.1 0.75 0.8 0.05], ...
    'String','x (vector):','HorizontalAlignment','left','FontSize',10);
hEdit1 = uicontrol('Parent',panel_izq,'Style','edit','Units','normalized','Position',[0.1 0.7 0.8 0.06], ...
    'String','[0 1 2 3]','FontSize',10);

hLabel2 = uicontrol('Parent',panel_izq,'Style','text','Units','normalized','Position',[0.1 0.62 0.8 0.05], ...
    'String','y (vector):','HorizontalAlignment','left','FontSize',10);
hEdit2 = uicontrol('Parent',panel_izq,'Style','edit','Units','normalized','Position',[0.1 0.57 0.8 0.06], ...
    'String','[1 2.7183 7.3891 20.0855]','FontSize',10);

hLabel3 = uicontrol('Parent',panel_izq,'Style','text','Units','normalized','Position',[0.1 0.49 0.8 0.05], ...
    'String','xi / a / h / n:','HorizontalAlignment','left','FontSize',10);
hEdit3 = uicontrol('Parent',panel_izq,'Style','edit','Units','normalized','Position',[0.1 0.44 0.8 0.06], ...
    'String','1','FontSize',10);

hLabel4 = uicontrol('Parent',panel_izq,'Style','text','Units','normalized','Position',[0.1 0.36 0.8 0.05], ...
    'String','b (si aplica):','HorizontalAlignment','left','FontSize',10);
hEdit4 = uicontrol('Parent',panel_izq,'Style','edit','Units','normalized','Position',[0.1 0.31 0.8 0.06], ...
    'String','3','FontSize',10);

hBoton = uicontrol('Parent',panel_izq,'Style','pushbutton','String','Ejecutar','FontSize',12, ...
    'Units','normalized','Position',[0.25 0.18 0.5 0.08],'Callback',@ejecutar_callback);

hResultado = uicontrol('Parent',panel_izq,'Style','text','Units','normalized','Position',[0.1 0.08 0.8 0.08], ...
    'String','Resultado:','FontSize',11,'HorizontalAlignment','left');

% Panel derecho para gráfica
hAxes = axes('Parent',f,'Units','normalized','Position',[0.33 0.12 0.65 0.8]);

% --- NUEVO: función para actualizar campos según el método seleccionado ---
function actualizar_campos(~,~)
    metodo = get(hMetodo,'Value');
    % Por defecto, todos visibles
    set([hLabel1 hEdit1 hLabel2 hEdit2 hLabel3 hEdit3 hLabel4 hEdit4], 'Visible', 'on');
    switch metodo
        case {1,2} % Interpolación
            set(hLabel1,'String','x (vector):');
            set(hLabel2,'String','y (vector):');
            set(hLabel3,'String','xi:');
            set(hLabel4,'Visible','off');
            set(hEdit4,'Visible','off');
        case 3 % Trapecio simple
            set(hLabel1,'String','No usado','Visible','off');
            set(hEdit1,'Visible','off');
            set(hLabel2,'String','y = [f(a) f(b)]:');
            set(hLabel3,'String','h = b-a:');
            set(hLabel4,'Visible','off');
            set(hEdit4,'Visible','off');
        case 4 % Trapecio múltiple
            set(hLabel1,'String','x (vector):','Visible','on');
            set(hEdit1,'Visible','on');
            set(hLabel2,'String','y (vector):');
            set(hLabel3,'String','h:');
            set(hLabel4,'Visible','off');
            set(hEdit4,'Visible','off');
        case 5 % Simpson 1/3 simple
            set(hLabel1,'String','No usado','Visible','off');
            set(hEdit1,'Visible','off');
            set(hLabel2,'String','y = [f(a) f(m) f(b)]:');
            set(hLabel3,'String','h = (b-a)/2:');
            set(hLabel4,'Visible','off');
            set(hEdit4,'Visible','off');
        case 6 % Simpson 3/8 simple
            set(hLabel1,'String','No usado','Visible','off');
            set(hEdit1,'Visible','off');
            set(hLabel2,'String','y = [f(a) f(a+h) f(a+2h) f(b)]:');
            set(hLabel3,'String','h = (b-a)/3:');
            set(hLabel4,'Visible','off');
            set(hEdit4,'Visible','off');
        case 7 % Simpson 1/3 múltiple
            set(hLabel1,'String','x (vector):','Visible','on');
            set(hEdit1,'Visible','on');
            set(hLabel2,'String','y (vector):');
            set(hLabel3,'String','h:');
            set(hLabel4,'Visible','off');
            set(hEdit4,'Visible','off');
        case 8 % Simpson mixto
            set(hLabel1,'String','x (vector):','Visible','on');
            set(hEdit1,'Visible','on');
            set(hLabel2,'String','y (vector):');
            set(hLabel3,'String','a:');
            set(hLabel4,'String','b:','Visible','on');
            set(hEdit4,'Visible','on');
    end
end
set(hMetodo,'Callback',@actualizar_campos);
actualizar_campos();

    function ejecutar_callback(~,~)
        metodo = get(hMetodo,'Value');
        % Validaciones y obtención de datos según método
        try
            switch metodo
                case {1,2} % Interpolación
                    x = str2num(get(hEdit1,'String'));
                    y = str2num(get(hEdit2,'String'));
                    xi = str2double(get(hEdit3,'String'));
                    if isempty(x) || isempty(y) || isnan(xi)
                        error('Ingrese x, y y xi correctamente.');
                    end
                    if length(x) ~= length(y)
                        error('x e y deben tener la misma longitud.');
                    end
                case 3 % Trapecio simple
                    y = str2num(get(hEdit2,'String'));
                    h = str2double(get(hEdit3,'String'));
                    if length(y) ~= 2 || isnan(h)
                        error('y debe tener 2 valores y h debe ser numérico.');
                    end
                case 4 % Trapecio múltiple
                    x = str2num(get(hEdit1,'String'));
                    y = str2num(get(hEdit2,'String'));
                    h = str2double(get(hEdit3,'String'));
                    if isempty(x) || isempty(y) || isnan(h)
                        error('Ingrese x, y y h correctamente.');
                    end
                    if length(x) ~= length(y)
                        error('x e y deben tener la misma longitud.');
                    end
                case 5 % Simpson 1/3 simple
                    y = str2num(get(hEdit2,'String'));
                    h = str2double(get(hEdit3,'String'));
                    if length(y) ~= 3 || isnan(h)
                        error('y debe tener 3 valores y h debe ser numérico.');
                    end
                case 6 % Simpson 3/8 simple
                    y = str2num(get(hEdit2,'String'));
                    h = str2double(get(hEdit3,'String'));
                    if length(y) ~= 4 || isnan(h)
                        error('y debe tener 4 valores y h debe ser numérico.');
                    end
                case 7 % Simpson 1/3 múltiple
                    x = str2num(get(hEdit1,'String'));
                    y = str2num(get(hEdit2,'String'));
                    h = str2double(get(hEdit3,'String'));
                    if isempty(x) || isempty(y) || isnan(h)
                        error('Ingrese x, y y h correctamente.');
                    end
                    if length(x) ~= length(y)
                        error('x e y deben tener la misma longitud.');
                    end
                    if mod(length(y)-1,2) ~= 0
                        error('Para Simpson 1/3 múltiple, el número de segmentos debe ser par (n = length(y)-1).');
                    end
                case 8 % Simpson mixto
                    x = str2num(get(hEdit1,'String'));
                    y = str2num(get(hEdit2,'String'));
                    a = str2double(get(hEdit3,'String'));
                    b = str2double(get(hEdit4,'String'));
                    n = length(y)-1;
                    if isempty(x) || isempty(y) || isnan(a) || isnan(b)
                        error('Ingrese x, y, a y b correctamente.');
                    end
                    if length(x) ~= length(y)
                        error('x e y deben tener la misma longitud.');
                    end
                    if n < 1
                        error('Debe haber al menos dos nodos.');
                    end
            end
        catch ME
            set(hResultado,'String',['Error: ' ME.message]);
            cla(hAxes);
            return;
        end

        cla(hAxes);
        resultado = '';
        switch metodo
            case 1 % Newton
                xi = val3;
                [yint, ea] = newton_interp(x, y, xi);
                resultado = sprintf('Interpolación de Newton en x=%.4f: %.6f\nError estimado: %.2e', xi, yint, ea);
                xx = linspace(min(x), max(x), 100);
                yy = arrayfun(@(z) newton_interp(x, y, z), xx);
                plot(hAxes, x, y, 'ro', xx, yy, 'b-', xi, yint, 'ks', 'MarkerFaceColor','k');
                title(hAxes,'Interpolación de Newton');
                xlabel(hAxes,'x'); ylabel(hAxes,'y');
                legend(hAxes,'Datos','Polinomio','Interpolado','Location','Best');
                grid(hAxes,'on');
            case 2 % Lagrange
                xi = val3;
                yint = lagrange_interp(x, y, xi);
                resultado = sprintf('Interpolación de Lagrange en x=%.4f: %.6f', xi, yint);
                xx = linspace(min(x), max(x), 100);
                yy = arrayfun(@(z) lagrange_interp(x, y, z), xx);
                plot(hAxes, x, y, 'ro', xx, yy, 'b-', xi, yint, 'ks', 'MarkerFaceColor','k');
                title(hAxes,'Interpolación de Lagrange');
                xlabel(hAxes,'x'); ylabel(hAxes,'y');
                legend(hAxes,'Datos','Polinomio','Interpolado','Location','Best');
                grid(hAxes,'on');
            case 3 % Trapecio simple
                h = val3;
                f0 = y(1); f1 = y(2);
                I = trapecio_simple(h, f0, f1);
                resultado = sprintf('Trapecio simple: I = %.6f', I);
                bar(hAxes, [1 2], [f0 f1]);
                title(hAxes,'Trapecio simple');
                xlabel(hAxes,'Índice'); ylabel(hAxes,'f(x)');
            case 4 % Trapecio múltiple
                h = val3;
                I = trapecio_multiple(h, y);
                resultado = sprintf('Trapecio múltiple: I = %.6f', I);
                plot(hAxes, x, y, 'bo-');
                title(hAxes,'Trapecio múltiple');
                xlabel(hAxes,'x'); ylabel(hAxes,'f(x)');
            case 5 % Simpson 1/3 simple
                h = val3;
                f0 = y(1); f1 = y(2); f2 = y(3);
                I = simpson_13_simple(h, f0, f1, f2);
                resultado = sprintf('Simpson 1/3 simple: I = %.6f', I);
                bar(hAxes, [1 2 3], [f0 f1 f2]);
                title(hAxes,'Simpson 1/3 simple');
                xlabel(hAxes,'Índice'); ylabel(hAxes,'f(x)');
            case 6 % Simpson 3/8 simple
                h = val3;
                f0 = y(1); f1 = y(2); f2 = y(3); f3 = y(4);
                I = simpson_38_simple(h, f0, f1, f2, f3);
                resultado = sprintf('Simpson 3/8 simple: I = %.6f', I);
                bar(hAxes, [1 2 3 4], [f0 f1 f2 f3]);
                title(hAxes,'Simpson 3/8 simple');
                xlabel(hAxes,'Índice'); ylabel(hAxes,'f(x)');
            case 7 % Simpson 1/3 múltiple
                h = val3;
                I = simpson_13_multiple(h, y);
                resultado = sprintf('Simpson 1/3 múltiple: I = %.6f', I);
                plot(hAxes, x, y, 'bo-');
                title(hAxes,'Simpson 1/3 múltiple');
                xlabel(hAxes,'x'); ylabel(hAxes,'f(x)');
            case 8 % Simpson mixto
                a = val3; b = val4; n = length(y)-1;
                I = simpson_mixto(a, b, n, y);
                resultado = sprintf('Simpson mixto: I = %.6f', I);
                plot(hAxes, x, y, 'bo-');
                title(hAxes,'Simpson mixto');
                xlabel(hAxes,'x'); ylabel(hAxes,'f(x)');
        end
        set(hResultado,'String',['Resultado: ' resultado]);
    end
end
