````markdown
# 🎓 Proyecto: Métodos Numéricos con Interfaz Gráfica en GNU Octave

Este proyecto implementa algoritmos clásicos de **interpolación** y **cuadratura** en **GNU Octave**, con una **interfaz gráfica moderna, intuitiva y robusta**.

---

## 📁 Archivos Principales

| Archivo / Carpeta     | Descripción |
|------------------------|-------------|
| `main_gui.m`           | 🖥️ Interfaz gráfica principal (**recomendada**) |
| `algoritmos/`          | 📂 Módulos con los algoritmos numéricos (`*.m`) |

---

## 🚀 Cómo Usar la Interfaz Gráfica

1. Abre **GNU Octave** y navega a la carpeta del proyecto.
2. Ejecuta el archivo principal:

   ```octave
   main_gui
````

---

## 🧭 Estructura de la Ventana

### 🪟 Panel Izquierdo

* Menú desplegable para seleccionar el método:

  * Newton, Lagrange, Trapecio, Simpson, etc.
* Ejemplos precargados adaptados según el método.
* Campos de entrada (interactivos y contextuales).
* Botón **"Ejecutar"** para procesar.
* Área de resultados con formato automático.

### 📊 Panel Derecho

* Gráfica de datos, polinomios o área según el método seleccionado.

---

## 🔄 Flujo de Uso

* Selecciona un **método numérico**.
* (Opcional) Carga un **ejemplo precargado**.
* Ingresa datos personalizados:

  * Soporta expresiones como `pi/6` o vectores tipo `[0 pi/4 pi/2]`.
* Haz clic en **"Ejecutar"**.
* Verifica el resultado numérico y la gráfica generada.

---

<details>
<summary>🔒 Validaciones Automáticas</summary>

* Validación de tipo de datos, dimensiones y parámetros requeridos.
* Mensajes de error claros en caso de entradas incorrectas.
* Limpieza automática de campos y gráficas al cambiar de método.

</details>

<details>
<summary>📚 Ejemplos Precargados</summary>

* Cada algoritmo tiene **al menos dos ejemplos listos** para su ejecución.
* Se respetan condiciones particulares (como número par de nodos para Simpson 1/3 múltiple, etc.).

</details>

---

## 💡 Recomendaciones

* Usa `main_gui.m` para una experiencia más visual y validada.
* Asegúrate de tener una **versión actualizada** de GNU Octave para evitar problemas de visualización.

---

## 👨‍💻 Autores y Licencia

* Proyecto académico de libre uso y modificación con fines educativos.
* ¡Explora, modifica y aprende! ✨

```

Si en algún momento quieres añadir una imagen o GIF demostrativo (como una captura de la interfaz), avísame y te indico cómo integrarla también en el `README.md`.
`````
