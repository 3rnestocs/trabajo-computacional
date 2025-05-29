function main_gui()
% main_gui: Interfaz gráfica para métodos numéricos
% Ejecuta este archivo para abrir la GUI del proyecto

    addpath('algoritmos');

    % --- Ventana principal ---
    f = figure('Name','Métodos Numéricos', 'NumberTitle','off', 'MenuBar','none', ...
        'Resize','on', 'Units','normalized', 'Position',[0.05 0.05 0.9 0.9], 'WindowStyle','normal');
    movegui(f, 'center');

    % --- Panel izquierdo para controles ---
    panel_izq = uipanel('Parent',f, 'Title','Opciones y Datos', 'FontSize',12, ...
        'Units','normalized', 'Position',[0.02 0.1 0.28 0.8]);

    metodos = {'Interpolación de Newton','Interpolación de Lagrange', ...
            'Trapecio (simple)','Trapecio (múltiple)', ...
            'Simpson 1/3 (simple)','Simpson 3/8 (simple)', ...
            'Simpson 1/3 (múltiple)','Simpson mixto (par/impar)'};

    % --- Selector de método ---
    hMetodo = creaControl('popupmenu', panel_izq, [0.1 0.92 0.8 0.06], ...
        {'String',metodos,'FontSize',11});

    % --- Menú de ejemplos precargados (justo debajo del selector de método) ---
    hEjemplo = creaControl('popupmenu', panel_izq, [0.1 0.84 0.8 0.06], ...
        {'String',{'Seleccionar ejemplo...'},'FontSize',10});

    % --- Campos de entrada ---
    hLabel1 = creaControl('text', panel_izq, [0.1 0.75 0.8 0.05], ...
        {'String','x (vector):','HorizontalAlignment','left','FontSize',10});
    hEdit1  = creaControl('edit', panel_izq, [0.1 0.7 0.8 0.06], ...
        {'String','','FontSize',10});
    hLabel2 = creaControl('text', panel_izq, [0.1 0.62 0.8 0.05], ...
        {'String','y (vector):','HorizontalAlignment','left','FontSize',10});
    hEdit2  = creaControl('edit', panel_izq, [0.1 0.57 0.8 0.06], ...
        {'String','','FontSize',10});
    hLabel3 = creaControl('text', panel_izq, [0.1 0.49 0.8 0.05], ...
        {'String','xi:','HorizontalAlignment','left','FontSize',10}); % Cambiado a 'xi:' para claridad
    hEdit3  = creaControl('edit', panel_izq, [0.1 0.44 0.8 0.06], ...
        {'String','','FontSize',10});
    hLabel4 = creaControl('text', panel_izq, [0.1 0.36 0.8 0.05], ...
        {'String','b (si aplica):','HorizontalAlignment','left','FontSize',10});
    hEdit4  = creaControl('edit', panel_izq, [0.1 0.31 0.8 0.06], ...
        {'String','','FontSize',10});
    % Nuevo campo para el valor verdadero, posicionado debajo de xi con tamaño ajustado
    hLabel5 = creaControl('text', panel_izq, [0.1 0.37 0.8 0.05], ... % Ajustado para estar justo debajo de hEdit3
        {'String','Valor verdadero:','HorizontalAlignment','left','FontSize',10, 'Visible', 'off'});
    hEdit5  = creaControl('edit', panel_izq, [0.1 0.32 0.8 0.06], ... % Ajustado para alinear con hEdit3 y hEdit4
        {'String','','FontSize',10, 'Visible', 'off'});

    % --- Botón para ejecutar ---
    hBoton = creaControl('pushbutton', panel_izq, [0.25 0.18 0.5 0.08], ...
        {'String','Ejecutar','FontSize',12,'Callback',@ejecutar_callback});

    % --- Área de resultados ---
    hResultado = uicontrol('Style','edit','Parent',panel_izq, 'Units','normalized', ...
        'Position',[0.1 0.08 0.8 0.08], 'String','Resultado:', 'FontSize',11, ...
        'HorizontalAlignment','left','Max',2,'Min',0,'Enable','inactive','BackgroundColor',[1 1 1]);

    % --- Panel derecho para gráfica ---
    hAxes = axes('Parent',f,'Units','normalized','Position',[0.33 0.12 0.65 0.8]);

    % --- Ejemplos precargados por método (cell-array de 8 filas) ---
    ejemplos_por_metodo = {
        {
        struct('nombre','Ejercicio 18.1: log10 en log(8) y log(12)','x','[8,12]','y','[0.9030900,1.0791812]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.2: log10 en log(9) y log(11)','x','[9,11]','y','[0.9542425,1.0413927]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.2: log10 en log(8) log(9) y log(11)','x','[8,9,11]','y','[0.9030900,0.9542425,1.0413927]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.1: log10 en log(8) log(9) log(11) y log(12) ','x','[8,9,11,12]','y','[0.9030900,0.9542425,1.0413927,1.0791812]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.8: Interpolación inversa (18.8): f(x)=0.23', 'x','[0.3333, 0.25, 0.2, 0.1667]', 'y','[3, 4, 5, 6]', 'xi','0.23', 'valor_verdadero','')
        },
        {
        struct('nombre','Ejercicio 18.1: log10 en log(8) y log(12)','x','[8,12]','y','[0.9030900,1.0791812]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.2: log10 en log(9) y log(11)','x','[9,11]','y','[0.9542425,1.0413927]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.2: log10 en log(8) log(9) y log(11)','x','[8,9,11]','y','[0.9030900,0.9542425,1.0413927]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.1: log10 en log(8) log(9) log(11) y log(12) ','x','[8,9,11,12]','y','[0.9030900,0.9542425,1.0413927,1.0791812]','xi','10', 'valor_verdadero', '1'), ...
        struct('nombre','Ejercicio 18.8: Interpolación inversa (18.8): f(x)=0.23', 'x','[0.3333, 0.25, 0.2, 0.1667]', 'y','[3, 4, 5, 6]', 'xi','0.23', 'valor_verdadero','')
        },
        { struct('nombre','Ejercicio 21.1: Trapecio simple para (1-exp(-2x)) en [0,4]', 'y','[1-exp(-2*0), 1-exp(-2*4)]', 'h','4', 'valor_verdadero','1.9826') },
        { struct('nombre','Ejercicio 21.1: Trapecio múltiple n=2 para (1-exp(-2x)) en [0,2,4]', 'x','[0 2 4]', 'y','[1-exp(-2*0), 1-exp(-2*2), 1-exp(-2*4)]', 'h','2', 'valor_verdadero','1.9826') },
        { struct('nombre','Ejercicio 21.1: Simpson 1/3 simple para (1-exp(-2x)) en [0,2,4]', 'y','[1-exp(-2*0), 1-exp(-2*2), 1-exp(-2*4)]', 'h','2', 'valor_verdadero','1.9826') },
        { struct('nombre','Ejercicio 21.1: Simpson 3/8 simple para (1-exp(-2x)) en [0,1.3333,2.6667,4]', 'y','[1-exp(-2*0), 1-exp(-2*1.3333), 1-exp(-2*2.6667), 1-exp(-2*4)]', 'h','1.3333', 'valor_verdadero','1.9826') },
        { struct('nombre','Ejercicio 21.1: Simpson 1/3 múltiple n=4 para (1-exp(-2x)) en [0,1,2,3,4]', 'x','[0 1 2 3 4]', 'y','[1-exp(-2*0), 1-exp(-2*1), 1-exp(-2*2), 1-exp(-2*3), 1-exp(-2*4)]', 'h','1', 'valor_verdadero','1.9826') },
        { struct('nombre','Ejercicio 21.1: Simpson mixto n=5 para (1-exp(-2x)) en [0,0.8,1.6,2.4,3.2,4]', 'x','[0 0.8 1.6 2.4 3.2 4]', 'y','[1-exp(-2*0), 1-exp(-2*0.8), 1-exp(-2*1.6), 1-exp(-2*2.4), 1-exp(-2*3.2), 1-exp(-2*4)]', 'a','0', 'b','4', 'valor_verdadero','1.9826') }
    };

    % --- Callbacks y lógica de UI ---
    set(hMetodo,'Callback',@metodo_changed);
    set(hEjemplo,'Callback', @cargar_ejemplo);
    actualizar_campos(); actualizar_ejemplos(); metodo_changed();

    % --- Callback único para cambio de método ---
    function metodo_changed(~,~)
        cla(hAxes);                           % limpiar gráfica
        set(hResultado,'String','Resultado:');% reiniciar texto
        set(hEjemplo ,'Value',1);             % reset menú ejemplo
        limpiar_campos();                     % vaciar edits
        actualizar_campos();                  % mostrar/ocultar campos
        actualizar_ejemplos();                % poblar menú ejemplo
    end

    % --- Actualiza los campos visibles según el método seleccionado ---
    function actualizar_campos(~,~)
        metodo = get(hMetodo,'Value');
        set([hLabel1 hEdit1 hLabel2 hEdit2 hLabel3 hEdit3 hLabel4 hEdit4 hLabel5 hEdit5], 'Visible', 'on');
        switch metodo
            case 1 % Interpolación de Newton
                set(hLabel1,'String','x (vector):');
                set(hLabel2,'String','y (vector):');
                set(hLabel3,'String','xi:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','on'); set(hEdit5,'Visible','on'); % Mostrar campo valor verdadero
            case 2 % Interpolación de Lagrange
                set(hLabel1,'String','x (vector):');
                set(hLabel2,'String','y (vector):');
                set(hLabel3,'String','xi:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','on'); set(hEdit5,'Visible','on'); % Mostrar campo valor verdadero TAMBIÉN para Lagrange
            case 3
                set(hLabel1,'String','No usado','Visible','off'); set(hEdit1,'Visible','off');
                set(hLabel2,'String','y = [f(a) f(b)]:');
                set(hLabel3,'String','h = b-a:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','off'); set(hEdit5,'Visible','off');
            case 4
                set(hLabel1,'String','x (vector):','Visible','on'); set(hEdit1,'Visible','on');
                set(hLabel2,'String','y (vector):');
                set(hLabel3,'String','h:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','off'); set(hEdit5,'Visible','off');
            case 5
                set(hLabel1,'String','No usado','Visible','off'); set(hEdit1,'Visible','off');
                set(hLabel2,'String','y = [f(a) f(m) f(b)]:');
                set(hLabel3,'String','h = (b-a)/2:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','off'); set(hEdit5,'Visible','off');
            case 6
                set(hLabel1,'String','No usado','Visible','off'); set(hEdit1,'Visible','off');
                set(hLabel2,'String','y = [f(a) f(a+h) f(a+2h) f(b)]:');
                set(hLabel3,'String','h = (b-a)/3:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','off'); set(hEdit5,'Visible','off');
            case 7
                set(hLabel1,'String','x (vector):','Visible','on'); set(hEdit1,'Visible','on');
                set(hLabel2,'String','y (vector):');
                set(hLabel3,'String','h:');
                set(hLabel4,'Visible','off'); set(hEdit4,'Visible','off');
                set(hLabel5,'Visible','off'); set(hEdit5,'Visible','off');
            case 8
                set(hLabel1,'String','x (vector):','Visible','on'); set(hEdit1,'Visible','on');
                set(hLabel2,'String','y (vector):');
                set(hLabel3,'String','a:');
                set(hLabel4,'String','b:','Visible','on'); set(hEdit4,'Visible','on');
                set(hLabel5,'Visible','off'); set(hEdit5,'Visible','off');
        end
    end

    % --- Actualiza el menú de ejemplos según el método seleccionado ---
    function actualizar_ejemplos(~,~)
        metodo = get(hMetodo,'Value');
        set(hEjemplo,'Value',1); % Reset antes de poblar
        lista = ejemplos_por_metodo{metodo};
        nombres = [{'Seleccionar ejemplo...'} cellfun(@(e) e.nombre, lista, 'uni', false)];
        set(hEjemplo,'String',nombres,'Value',1);
    end

    % --- Función para limpiar campos y resultados ---
    function limpiar_campos()
        set(hEdit1,'String','');
        set(hEdit2,'String','');
        set(hEdit3,'String','');
        set(hEdit4,'String','');
        set(hEdit5,'String',''); % Limpiar nuevo campo
    end

    % --- Función auxiliar para crear controles normalizados ---
    function h = creaControl(style, parent, pos, props)
        h = uicontrol('Style',style,'Parent',parent,'Units','normalized','Position',pos,props{:});
    end

    % --- Función auxiliar para leer datos de los campos de entrada ---
    function datos = leeDatos(ed1, ed2, ed3, ed4, ed5)
        str1 = get(ed1, 'String');
        str2 = get(ed2, 'String');
        str3 = get(ed3, 'String');
        str4 = get(ed4, 'String');
        str5 = get(ed5, 'String');
        if isempty(str1)
            datos.x = [];
        else
            datos.x = eval(str1);
        end
        if isempty(str2)
            datos.y = [];
        else
            datos.y = eval(str2);
        end
        if isempty(str3)
            datos.v3 = NaN;
        else
            datos.v3 = eval(str3);
        end
        if isempty(str4)
            datos.v4 = NaN;
        else
            datos.v4 = eval(str4);
        end
        if isempty(str5)
            datos.v5 = [];
        else
            datos.v5 = eval(str5);
        end
    end

    % --- Carga los datos del ejemplo seleccionado en los campos de entrada ---
    function cargar_ejemplo(~,~)
        metodo = get(hMetodo,'Value');
        lista = ejemplos_por_metodo{metodo};
        idx   = get(hEjemplo, 'Value');
        if idx < 2 || idx > numel(lista)+1
            msgbox('Ejemplo fuera de rango','Error','error');
            return;
        end
        ej = lista{idx-1};
        campos = {
          {'x','y','xi','','valor_verdadero'}; % 1: Newton
          {'x','y','xi','','valor_verdadero'}; % 2: Lagrange (ahora incluye valor_verdadero)
          {'','y','h',''};        % 3: Trap. simple
          {'x','y','h',''};       % 4: Trap. múltiple
          {'','y','h',''};        % 5: Simpson 1/3 simple
          {'','y','h',''};        % 6: Simpson 3/8 simple
          {'x','y','h',''};       % 7: Simpson 1/3 múltiple
          {'x','y','a','b'}       % 8: Simpson mixto
        };
        nombresCampos = campos{metodo};
        editors = {hEdit1,hEdit2,hEdit3,hEdit4,hEdit5};
        for k = 1:5
            if ~isempty(nombresCampos{k}) && isfield(ej, nombresCampos{k})
                set(editors{k}, 'String', ej.(nombresCampos{k}));
            else
                set(editors{k}, 'String', '');
            end
        end
    end

    % --- Callback principal para ejecutar el método seleccionado ---
    function ejecutar_callback(~,~)
        try
            datos = leeDatos(hEdit1, hEdit2, hEdit3, hEdit4, hEdit5);
            metodo = get(hMetodo,'Value');
            % Validaciones estrictas de entrada adaptadas por método
            switch metodo
                case {1,2,4,7,8} % Métodos que requieren x
                    if isempty(datos.x) || ~isvector(datos.x) || any(~isfinite(datos.x))
                        error('Vector x inválido');
                    end
                otherwise % Métodos que NO requieren x (3,5,6)
                    % No validar x
            end
            if isempty(datos.y) || ~isvector(datos.y) || any(~isfinite(datos.y))
                error('Vector y inválido');
            end
            if isnan(datos.v3)
                error('El campo 3 es inválido o vacío.');
            end
            if metodo == 8 && isnan(datos.v4)
                error('El campo 4 es inválido o vacío.');
            end
            % Validaciones según método
            switch metodo
                case {1,2} % Interpolación
                    if isempty(datos.x) || isempty(datos.y) || isnan(datos.v3)
                        error('Ingrese x, y y xi correctamente.');
                    end
                    if length(datos.x) ~= length(datos.y)
                        error('x e y deben tener la misma longitud.');
                    end
                    dibujarInterpolacion(hAxes, metodo, datos, hResultado);
                case 3 % Trapecio simple
                    if length(datos.y) ~= 2 || isnan(datos.v3)
                        error('y debe tener 2 valores y h debe ser numérico.');
                    end
                    dibujarCuadratura(hAxes, metodo, datos, hResultado);
                case 4 % Trapecio múltiple
                    if isempty(datos.x) || isempty(datos.y) || isnan(datos.v3)
                        error('Ingrese x, y y h correctamente.');
                    end
                    if length(datos.x) ~= length(datos.y)
                        error('x e y deben tener la misma longitud.');
                    end
                    dibujarCuadratura(hAxes, metodo, datos, hResultado);
                case 5
                    if length(datos.y) ~= 3 || isnan(datos.v3)
                        error('y debe tener 3 valores y h debe ser numérico.');
                    end
                    dibujarCuadratura(hAxes, metodo, datos, hResultado);
                case 6
                    if length(datos.y) ~= 4 || isnan(datos.v3)
                        error('y debe tener 4 valores y h debe ser numérico.');
                    end
                    dibujarCuadratura(hAxes, metodo, datos, hResultado);
                case 7
                    if isempty(datos.x) || isempty(datos.y) || isnan(datos.v3)
                        error('Ingrese x, y y h correctamente.');
                    end
                    if length(datos.x) ~= length(datos.y)
                        error('x e y deben tener la misma longitud.');
                    end
                    if mod(length(datos.y)-1,2) ~= 0
                        error('Para Simpson 1/3 múltiple, el número de segmentos debe ser par (n = length(y)-1).');
                    end
                    dibujarCuadratura(hAxes, metodo, datos, hResultado);
                case 8
                    if isempty(datos.x) || isempty(datos.y) || isnan(datos.v3) || isnan(datos.v4)
                        error('Ingrese x, y, a y b correctamente.');
                    end
                    if length(datos.x) ~= length(datos.y)
                        error('x e y deben tener la misma longitud.');
                    end
                    if length(datos.y) < 2
                        error('Debe haber al menos dos nodos.');
                    end
                    dibujarCuadratura(hAxes, metodo, datos, hResultado);
            end
        catch ME
            set(hResultado,'String',['Error: ' ME.message]);
            cla(hAxes);
            msgbox(['Error: ' ME.message],'Error','error');
        end
    end

    % --- Utilidad para mostrar resultado con saltos de línea si es necesario ---
  function setResultadoMultilinea(txt)
        maxlen = 60;
        if length(txt) > maxlen
            % Rompe en espacios
            palabras = strsplit(txt, ' ');
            linea = '';
            out = {};
            for i = 1:length(palabras)
                if length(linea) + length(palabras{i}) + 1 > maxlen
                    out{end+1} = strtrim(linea); % Fixed: Changed ] to )
                    linea = '';
                end
                linea = [linea ' ' palabras{i}];
            end
            out{end+1} = strtrim(linea); % Fixed: Changed ] to )
            txt = strjoin(out, sprintf('\n'));
        end
        set(hResultado,'String',txt);
    end

    % --- Dibuja la interpolación y muestra el resultado ---
    function dibujarInterpolacion(hAxes, metodo, datos, hResultado)
        cla(hAxes);
        % Detectar si es un ejemplo de logaritmo para graficar log10(x)
        esLog = false;
        try
            % Solo si ambos vectores son numéricos y positivos
            if isnumeric(datos.x) && isnumeric(datos.y) && all(datos.x > 0) && all(datos.y > 0)
                if length(datos.x) == length(datos.y)
                    % Checar si y ~ log10(x) o x ~ log10(y) (para inversa)
                    if all(abs(datos.y - log10(datos.x)) < 1e-6)
                        esLog = true;
                    elseif all(abs(datos.x - log10(datos.y)) < 1e-6)
                        esLog = true;
                    end
                end
            end
        catch
            esLog = false;
        end
        if metodo == 1 % Newton
            if ~isempty(datos.v5)
                [yint, er] = newton_interp(datos.x, datos.y, datos.v3, datos.v5);
                resultado = sprintf('Interpolación de Newton en x=%.4f: %.6f\nError relativo: %.6f%%', datos.v3, yint, er);
            else
                yint = newton_interp(datos.x, datos.y, datos.v3);
                resultado = sprintf('Interpolación de Newton en x=%.4f: %.6f', datos.v3, yint);
            end
            xx = linspace(min(datos.x), max(datos.x), 200);
            yy = arrayfun(@(z) newton_interp(datos.x, datos.y, z), xx);
            plot(hAxes, datos.x, datos.y, 'ro', xx, yy, 'b-', datos.v3, yint, 'ks', 'MarkerFaceColor','k');
            hold(hAxes,'on');
            if esLog
                yyf = log10(xx);
                plot(hAxes, xx, yyf, 'g--', 'LineWidth',1.5);
            end
            hold(hAxes,'off');
            title(hAxes,'Interpolación de Newton');
            xlabel(hAxes,'x'); ylabel(hAxes,'y');
            if esLog
                legend(hAxes,'Datos','Polinomio','Interpolado','log_{10}(x)','Location','northeast');
            else
                legend(hAxes,'Datos','Polinomio','Interpolado','Location','northeast');
            end
            grid(hAxes,'on');
        else % Lagrange
            yint = lagrange_interp(datos.x, datos.y, datos.v3);
            if ~isempty(datos.v5)
                er = abs((datos.v5 - yint)/datos.v5)*100;
                resultado = sprintf('Interpolación de Lagrange en x=%.4f: %.6f\nError relativo: %.6f%%', datos.v3, yint, er);
            else
                resultado = sprintf('Interpolación de Lagrange en x=%.4f: %.6f', datos.v3, yint);
            end
            xx = linspace(min(datos.x), max(datos.x), 200);
            yy = arrayfun(@(z) lagrange_interp(datos.x, datos.y, z), xx);
            plot(hAxes, datos.x, datos.y, 'ro', xx, yy, 'b-', datos.v3, yint, 'ks', 'MarkerFaceColor','k');
            hold(hAxes,'on');
            if esLog
                yyf = log10(xx);
                plot(hAxes, xx, yyf, 'g--', 'LineWidth',1.5);
            end
            hold(hAxes,'off');
            title(hAxes,'Interpolación de Lagrange');
            xlabel(hAxes,'x'); ylabel(hAxes,'y');
            if esLog
                legend(hAxes,'Datos','Polinomio','Interpolado','log_{10}(x)','Location','northeast');
            else
                legend(hAxes,'Datos','Polinomio','Interpolado','Location','northeast');
            end
            grid(hAxes,'on');
        end
        setResultadoMultilinea(['Resultado: ' resultado]);
    end

    % --- Dibuja la cuadratura y muestra el resultado ---
    function dibujarCuadratura(hAxes, metodo, datos, hResultado)
        cla(hAxes);
        switch metodo
            case 3 % Trapecio simple
                h = datos.v3; f0 = datos.y(1); f1 = datos.y(2);
                I = trapecio_simple(h, f0, f1);
                resultado = sprintf('Trapecio simple: I = %.6f', I);
                bar(hAxes, [1 2], [f0 f1]);
                title(hAxes,'Trapecio simple'); xlabel(hAxes,'Índice'); ylabel(hAxes,'f(x)');
            case 4 % Trapecio múltiple
                h = datos.v3;
                I = trapecio_multiple(h, datos.y);
                resultado = sprintf('Trapecio múltiple: I = %.6f', I);
                plot(hAxes, datos.x, datos.y, 'bo-');
                title(hAxes,'Trapecio múltiple'); xlabel(hAxes,'x'); ylabel(hAxes,'f(x)');
            case 5 % Simpson 1/3 simple
                h = datos.v3; f0 = datos.y(1); f1 = datos.y(2); f2 = datos.y(3);
                I = simpson_13_simple(h, f0, f1, f2);
                resultado = sprintf('Simpson 1/3 simple: I = %.6f', I);
                bar(hAxes, [1 2 3], [f0 f1 f2]);
                title(hAxes,'Simpson 1/3 simple'); xlabel(hAxes,'Índice'); ylabel(hAxes,'f(x)');
            case 6 % Simpson 3/8 simple
                h = datos.v3; f0 = datos.y(1); f1 = datos.y(2); f2 = datos.y(3); f3 = datos.y(4);
                I = simpson_38_simple(h, f0, f1, f2, f3);
                resultado = sprintf('Simpson 3/8 simple: I = %.6f', I);
                bar(hAxes, [1 2 3 4], [f0 f1 f2 f3]);
                title(hAxes,'Simpson 3/8 simple'); xlabel(hAxes,'Índice'); ylabel(hAxes,'f(x)');
            case 7 % Simpson 1/3 múltiple
                h = datos.v3;
                I = simpson_13_multiple(h, datos.y);
                resultado = sprintf('Simpson 1/3 múltiple: I = %.6f', I);
                plot(hAxes, datos.x, datos.y, 'bo-');
                title(hAxes,'Simpson 1/3 múltiple'); xlabel(hAxes,'x'); ylabel(hAxes,'f(x)');
            case 8 % Simpson mixto
                a = datos.v3; b = datos.v4; n = length(datos.y)-1;
                I = simpson_mixto(a, b, n, datos.y);
                resultado = sprintf('Simpson mixto: I = %.6f', I);
                plot(hAxes, datos.x, datos.y, 'bo-');
                title(hAxes,'Simpson mixto'); xlabel(hAxes,'x'); ylabel(hAxes,'f(x)');
        end
        setResultadoMultilinea(['Resultado: ' resultado]);
    end
end