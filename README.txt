================================================================================
PROYECTO: MÉTODOS NUMÉRICOS CON INTERFAZ GRÁFICA EN GNU OCTAVE
================================================================================

Este proyecto implementa algoritmos clásicos de interpolación y cuadratura en GNU Octave, con una interfaz gráfica moderna y robusta.

--------------------------------------------------------------------------------
ARCHIVOS PRINCIPALES
--------------------------------------------------------------------------------
- main_gui.m      --> Interfaz gráfica principal (recomendada)
- algoritmos/     --> Carpeta con los algoritmos numéricos modulares (*.m)
- main.m          --> Menú por consola (opcional, no necesario para la GUI)

--------------------------------------------------------------------------------
USO DE LA INTERFAZ GRÁFICA (main_gui.m)
--------------------------------------------------------------------------------

1. **Ejecución**
   - Abre GNU Octave y navega a la carpeta del proyecto.
   - Ejecuta: `main_gui`

2. **Estructura de la ventana**
   - **Panel izquierdo:**
     - Menú desplegable para seleccionar el método numérico (Newton, Lagrange, Trapecio, Simpson, etc).
     - Menú de ejemplos precargados (cambia según el método seleccionado).
     - Campos de entrada para los datos requeridos (x, y, h, a, b, etc). Los campos visibles y sus etiquetas cambian según el método.
     - Botón "Ejecutar" para calcular y graficar.
     - Área de resultados (multilínea, con saltos de línea automáticos si el texto es largo).
   - **Panel derecho:**
     - Gráfica de los datos y/o polinomio/interpolación/área según el método.

3. **Flujo de uso**
   - Selecciona un método en el menú superior.
   - (Opcional) Selecciona un ejemplo precargado para autocompletar los campos.
   - Ingresa o ajusta los datos manualmente si lo deseas. Puedes usar expresiones como `pi/6` o vectores tipo `[0 pi/4 pi/2]`.
   - Presiona "Ejecutar" para ver el resultado y la gráfica.
   - El área de resultados mostrará el valor calculado y, si es necesario, el error estimado o advertencias.
   - Si el resultado es muy largo, se mostrará en varias líneas automáticamente.

4. **Validaciones y robustez**
   - La interfaz valida que los datos sean numéricos, vectores del tamaño adecuado y que los parámetros requeridos estén presentes.
   - Si hay un error de entrada, se muestra un mensaje claro y el área de resultados lo indica.
   - Al cambiar de método, todos los campos y la gráfica se limpian automáticamente.

5. **Ejemplos precargados**
   - Cada método tiene al menos dos ejemplos listos para cargar.
   - Los ejemplos están adaptados para cumplir con los requisitos de cada algoritmo (por ejemplo, número de nodos par para Simpson 1/3 múltiple).

6. **Recomendaciones**
   - Usa la GUI para una experiencia visual y validada.
   - Si prefieres la consola, puedes ejecutar main.m, pero no es necesario para la GUI.
   - Si tienes problemas con la visualización de resultados, asegúrate de estar usando GNU Octave actualizado.

--------------------------------------------------------------------------------
AUTORES Y LICENCIA
--------------------------------------------------------------------------------
- Proyecto académico, libre para uso y modificación educativa.
