# 🤖 Automatización de Célula Robótica (Pick & Place) 

Este repositorio contiene la lógica de control para una célula robótica industrial de paletizado, desarrollada en **Codesys** utilizando **Texto Estructurado (ST)**. El sistema físico ha sido simulado e integrado en tiempo real utilizando **Factory I/O**.

## 📌 Descripción del Proyecto
El objetivo del proyecto es automatizar el proceso de clasificación y paletizado de piezas. Un brazo robótico cartesiano (3 ejes) recoge piezas de una cinta de entrada y las organiza sobre un palet siguiendo un patrón específico (incluyendo rotación de piezas). Una vez el palet está completo, el sistema lo evacúa y reinicia el ciclo.

Puedes ver el código fuente completo aquí: [Enlace a tu archivo .st](ruta_a_tu_archivo.st)

## 🎥 Demostración
*[¡Importante! Sube aquí un GIF o un enlace a YouTube de 30 segundos donde se vea Factory I/O funcionando a la vez que tu código]*
![Demostración del sistema](enlace_a_tu_gif_o_imagen.gif)

## ⚙️ Características Técnicas Destacadas
He diseñado el software enfocándome en la fiabilidad, la seguridad y la optimización del tiempo de ciclo:

* **Máquina de Estados Secuencial:** Lógica principal programada mediante la estructura `CASE`, asegurando transiciones limpias y evitando bloqueos del sistema (12 pasos de ciclo).
* **Procesamiento en Paralelo:** Implementación de sub-ramas de control (`RamaA` y `RamaB`) para ejecutar acciones simultáneas. *Ejemplo: La cinta de alimentación avanza con la siguiente pieza al mismo tiempo que el brazo robótico está viajando a soltar la pieza anterior.*
* **Gestión de Señales Analógicas:** Posicionamiento continuo del robot en los ejes X, Y, Z mediante referencias numéricas (ej. `MovingX := 8; MovingY := 5;`).
* **Seguridad y Parada de Emergencia:** Lógica de interrupción prioritaria. Al pulsar la SETA, se cortan inmediatamente todos los actuadores y cintas. El sistema requiere un rearme manual (`Resetbutton`) para poder continuar de forma segura.

## 🔌 Mapa de Entradas y Salidas (I/O)

### Actuadores y Salidas
* `MovingX`, `MovingY`, `MovingZ` (REAL): Posicionamiento de los servomotores del brazo.
* `Grab`, `Rotate` (BOOL): Control de la pinza neumática y giro de 90º.
* `Cinta1`, `Cinta2`, `Cinta3` (BOOL): Motores de las cintas de palets y piezas.
* `Startlight`, `Stoplight`, `Resetlight` (BOOL): Balizas de estado del panel.
* `Boxremover` (BOOL): Actuador de evacuación final.

### Sensores y Entradas
* `Xpos`, `Ypos`, `Zpos` (REAL): Encoders/Sensores de posición actual del brazo.
* `Itemgdetect`, `degrees90` (BOOL): Sensores de confirmación de agarre y rotación.
* `Sensorpieza`, `Sensorpalet`, `Sensorsalida` (BOOL): Fotocélulas de presencia en las cintas.
* `Startbutton`, `Stopbutton`, `Resetbutton`, `SETA` (BOOL): Botonera de control del operario.

## 🛠️ Herramientas Utilizadas
* **Lenguaje:** IEC 61131-3 Texto Estructurado (ST)
* **Entorno de Desarrollo:** Codesys V3.5
* **Simulación Planta:** Factory I/O

---
*Desarrollado por [Tu Nombre/Agustín Muñoz Santucho] - [Enlace a tu LinkedIn]*
