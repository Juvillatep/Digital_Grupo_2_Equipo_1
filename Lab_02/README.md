[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/SOFmPiIk)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=17568787&assignment_repo_type=AssignmentRepo)
# Lab02 - Medidor de carga

# Integrantes

  * [Jaime Alfonso Jiménez Naranjo]()
  * [Jhosep Fernando Cabrera Pelaez]()
  * [Julián Esteban Villate Pinzón](https://github.com/Juvillatep)

# Informe

Indice:

1. [Diseño implementado](#diseño-implementado)
2. [Simulaciones](#simulaciones)
3. [Implementación](#implementación)
4. [Preguntas](#preguntas)
5. [Conclusiones](#conclusiones)
6. [Referencias](#referencias)

## Diseño implementado

<!-- ### Descripción

 (### Diagramas) -->

Para comenzar con el diseño de nuestra solución al reto planteado, elaboramos el siguiente diagrama de bloques (Figura 1.1), partiendo de las entradas dadas, en este caso A[3:0] y B[3:0]. Se consideró la distribución y la cantidad de módulos necesarios para satisfacer las funcionalidades y requerimientos del reto. Se estableció de manera general que las entradas se asignarían inicialmente a dos módulos: uno destinado a cumplir con la primera parte del reto, que consistía en generar una alerta cuando alguna de las baterías del banco estuviera completamente descargada. Por tal motivo, las entradas se introducen tal como se reciben, ya que esta forma facilita la comparación con '0'.

El otro módulo, que recibe ambas entradas, es el sumador. Dado que el requerimiento del reto es comparar la carga total del banco de baterías, es necesario conocer la suma total de la carga de cada una de las baterías. De este modulo sale Sum[3:0] que es la suma de los 4 bit, y se planteo onicialmente asi en el diagrama de bloques, sin embargo los 4 bits al superar la cantidad de 15 'Decimal' requiere un bit extra para poder reflejar la cantidad de la suma, o como se evidenciara en la Figura 1.2, un acarreo de salida de 1 bit. Estas dos variables de salida se le asignan a los diferentes modulos comparativos de cada nivel de carga planteado para la solución del reto.

<p align="center">
  <img src="/Lab_02/Images/Diagrama de bloques.png" alt="Diagrama bloques" width="900">
  <br>
  <b>Figura 1.1 Diagrama de bloques,Diseño general modulos del monitor de carga</b>
</p>

Entrando en más detalle sobre cada uno de los módulos, comenzaremos con el módulo sumador, que es un sumador de 4 bits compuesto por la instanciación de 4 módulos sumadores de 1 bit. Cada uno de estos módulos está diseñado con las ecuaciones booleanas obtenidas de un diagrama de Karnaugh estándar, por lo que se requiere un acarreo de entrada, el cual se establece por defecto en b'0' para el primer módulo. Para los módulos restantes, el acarreo de entrada será el acarreo de salida del módulo anterior. De esta forma, el último módulo sumador de 1 bit nos dará el acarreo de salida del módulo de 4 bits. En cuanto a la suma, cada módulo de 1 bit realiza la suma y asigna ese resultado al número de bit correspondiente de Sum[3:0]. Finalmente, la salida del módulo de 4 bits será Sum[3:0] y Co (acarreo de salida), lo cual se asigna a los módulos de cada nivel de carga, como se muestra en la Figura 1.2.

<p align="center">
  <img src="/Lab_02/Images/Diagrama RTL.png" alt="Diagrama RTL" width="900">
  <br>
  <b>Figura 1.2 Diagrama RTL</b>
</p>

Respecto a los módulos de cada nivel de carga, los cuales son 5, como se aprecia en las Figuras 1.1 y 1.2, estos tienen como entradas Sum[3:0] y Co. Dentro de cada módulo se establece un rango de valores de acuerdo con el nivel con el cual se realiza la comparación:

  * Nivel crítico: 1-3
  * Nivel bajo: 4-12
  * Nivel regular: 13-21
  * Nivel aceptable: 22-29
  * Carga completa: 30

De esta manera, de acuerdo con el rango de valores, cada módulo fue diseñado mediante un diagrama de Karnaugh, obteniendo las ecuaciones correspondientes que se utilizan en el módulo. Como resultado, cada módulo genera una salida de 1 bit, siendo b'1' si el valor cumple con la condición y se encuentra dentro del rango de valores, y b'0' si no cumple con estas condiciones.

Como resultado final del módulo total del monitor de carga, se obtienen 5 salidas que indican el nivel de carga y dos salidas adicionales que indican si alguna batería está completamente descargada.

## Simulaciones 

<!-- (Incluir las de Digital si hicieron uso de esta herramienta, pero también deben incluir simulaciones realizadas usando un simulador HDL como por ejemplo Icarus Verilog + GTKwave) -->
Las simulaciones son una herramienta clave en el proceso de diseño de circuitos digitales, ya que nos permiten comprobar que los resultados obtenidos al ejecutar nuestro diseño sean los esperados y que cumplan con las condiciones dadas. A través de las simulaciones, podemos verificar la funcionalidad y el comportamiento del sistema en condiciones controladas antes de su implementación en hardware. Este proceso reduce significativamente el riesgo de errores y fallas en la etapa de implementación. A continuación, se presenta la simulación general de todo el reto, que incluye sus dos entradas (A y B), la suma de estas con su correspondiente acarreo de salida (Sum y Co), y las diferentes salidas de cada uno de los módulos para los diferentes niveles y funcionalidades requeridas. De este modo, las simulaciones no solo nos permiten validar el diseño, sino también optimizar su rendimiento, asegurando que el sistema funcione correctamente bajo diversas condiciones operativas.

<p align="center">
  <img src="/Lab_02/Images/Simulación general.png" alt="Uso de recursos FPGA" width="800">
  <br>
  <b>Figura 2.1 Simulación general modulos del monitor de carga</b>
</p>

### Simulación del modulo de baterias descargadas

Una de las funcionalidades requeridas, además de los niveles de carga, es brindar una alerta cuando alguna de las baterías del banco se encuentre totalmente descargada, es decir, con un valor de '0'. Como se puede observar en la figura 2.2, la salida 'Ea' tiene un nivel alto únicamente cuando A=0. De manera similar, 'Eb' tiene un valor alto cuando B=0.

<p align="center">
  <img src="/Lab_02/Images/Baterias%20descargadas.png" alt="Baterias descargadas" width="800">
  <br>
  <b>Figura 2.2 Simulación modulo de baterias descargadas</b>
</p>

### Simulación del sumador de 4 bits

Como se mencionó en la etapa de diseño, el módulo de sumador es la base de toda la solución al reto, ya que proporciona el valor de entrada para todos los módulos de nivel de carga. Como se observa en la figura 2.3, la suma cumple su función adecuadamente. Además, podemos notar que el acarreo de salida (Co) aumenta su valor cuando la suma supera 15 (o F en notación hexadecimal), lo que indica que el valor ha excedido la capacidad máxima de un sumador de 4 bits. Un sumador de 4 bits, al operar con dos entradas de 4 bits cada una, puede sumar valores desde 0 hasta 15 (en decimal), y cuando el resultado es mayor a 15, el acarreo (Co) se activa, llevando el exceso al siguiente bit. Este comportamiento es esencial para la correcta propagación de los valores en los módulos de nivel de carga y para asegurar la exactitud en el control del sistema.

<p align="center">
  <img src="/Lab_02/Images/Modulo sumador4bits.png" alt="Sumador" width="800">
  <br>
  <b>Figura 2.3 Simulación modulo sumador de 4 bits</b>
</p>

### Simulación modulos comparadores

El funcionamiento de los módulos de los diferentes niveles de carga es el mismo. Cada módulo toma el valor de la suma y, de acuerdo con el nivel de carga, se utilizan valores predefinidos que determinan si se cumple o no la condición establecida para ese nivel. Estos valores actúan como umbrales, lo que permite que el sistema clasifique y gestione el estado de carga de las baterías de manera eficiente.

#### **Nivel critico**

Este nivel representa el estado más bajo de carga del banco de baterías, correspondiente a valores entre 1 y 3, como se muestra en la figura 2.4.

<p align="center">
  <img src="/Lab_02/Images/Nivel critico.png" alt="Carga critica" width="800">
  <br>
  <b>Figura 2.4 Simulación modulo nivel de carga critica</b>
</p>

#### **Nivel bajo**

Los valores para los cuales la salida de este módulo estará en alto se encuentran entre 4 y 12, lo que indica un nivel de batería bajo. Esto se puede evidenciar en la figura 2.5.

<p align="center">
  <img src="/Lab_02/Images/Nivel bajo.png" alt="Carga baja" width="800">
  <br>
  <b>Figura 2.5 Simulación modulo nivel de carga baja</b>
</p>

#### **Nivel regular**

El nivel medio de carga de las baterías se expresa en este módulo, con una salida en alto cuando la suma de los valores de las baterías se encuentra entre 13 y 21. Esto se puede corroborar en la figura 2.6.

<p align="center">
  <img src="/Lab_02/Images/Nivel regular.png" alt="Carga regular" width="800">
  <br>
  <b>Figura 2.6 Simulación modulo nivel de carga regular</b>
</p>

#### **Nivel aceptable**

Los valores aceptables de carga de las baterías se encuentran entre 22 y 29, lo que permite generar una salida en alto, como se observa en la figura 2.7.

<p align="center">
  <img src="/Lab_02/Images/Nivel aceptable.png" alt="Carga aceptable" width="800">
  <br>
  <b>Figura 2.7 Simulación modulo nivel de carga aceptable</b>
</p>

#### **Carga completa**

Este módulo indica que la carga de las baterías está al máximo o completa. La salida solo estará en alto cuando el valor total de la suma del banco de baterías sea igual a 30, o cuando cada batería individualmente tenga un valor de 15, respectivamente. Ver figura 2.8.

<p align="center">
  <img src="/Lab_02/Images/Carga completa.png" alt="Carga completa" width="800">
  <br>
  <b>Figura 2.8 Simulación modulo carga completa</b>
</p>


## Implementación

En el siguiente video se explica, paso a paso, la implementación en la FPGA. Desde la creación del módulo general hasta su implementación y la descripción del funcionamiento del monitor de carga.

Link del video:https://youtu.be/H0RDd_rVTTs

## Preguntas

1. ¿Qué desafíos pueden surgir al implementar en *hardware* un diseño que funcionaba correctamente en simulación?

    Al implementar un diseño en hardware que funcionaba correctamente en simulación, pueden surgir desafíos relacionados con la distribución de entradas y salidas, la interacción con el hardware físico y la configuración de los periféricos. En el caso descrito, se observó que la salida del hardware invierte el resultado esperado, lo cual no ocurrió durante la simulación. Esto puede deberse a errores en la configuración de pines, diferencias en las convenciones de niveles lógicos (como activo alto o bajo), o problemas en la interpretación de señales entre el diseño y el hardware real.

    Estos desafíos destacan la importancia de validar cómo el hardware maneja las señales físicas y asegurarse de que las configuraciones coincidan con las expectativas del diseño lógico.

2. Describa el enfoque estructural y comportamental en el contexto de electrónica digital y cómo los implementó en el reto. ¿Qué hace Quartus con cada uno?

    En electrónica digital, el enfoque estructural describe cómo está construido un sistema, detallando los componentes y su interconexión, como puertas lógicas en los niveles más bajos. En contraste, el enfoque comportamental se centra en lo que hace el sistema, utilizando descripciones funcionales, diagramas de bloques y, en el nivel más básico, ecuaciones booleanas y expresiones matemáticas. Durante el reto, comenzamos con un enfoque comportamental, diseñando un diagrama de bloques para identificar los módulos necesarios. A partir de esto, aplicamos el método de Karnaugh para obtener las ecuaciones lógicas que nos permitieran implementar correctamente los módulos comparadores.

    Quartus facilita este proceso al compilar el código y generar el diagrama RTL (Register Transfer Level), que permite visualizar la estructura del sistema. Además, proporciona control detallado sobre la disposición física del diseño, permitiendo asignar las entradas y salidas a los pines preferidos de la FPGA.

3. ¿Cómo afecta el diseño del sumador y de comparadores al uso de recursos en la FPGA (LUTs, FFs, BRAMs, etc.)? Muestren el uso de recursos de su diseño.

    El diseño de sumadores y comparadores en una FPGA afecta directamente al uso de recursos como LUTs (Look-Up Tables), Flip-Flops (FFs) y bloques DSP. En el caso de un sumador de 4 bits, que se implementa como la instanciación de cuatro sumadores de 1 bit sencillos, se utilizan principalmente LUTs y FFs para realizar las operaciones de suma bit a bit. Este diseño es simple, pero más lento en comparación con sumadores optimizados, como los que utilizan técnicas de fast carry o look-ahead carry, que requieren más LUTs. En cuanto a los comparadores, la mayoría son de 4 bits, con excepción de un módulo de 2 bits. Los comparadores de 4 bits consumen más LUTs y FFs que los de 2 bits, ya que la lógica combinacional es más compleja a medida que aumenta el ancho de los datos. El ancho de bits y la optimización del diseño, como el uso de bloques DSP o la implementación en pipeline, son factores clave que afectan el consumo de recursos y el rendimiento. Para optimizar el uso de recursos, es recomendable aprovechar los bloques DSP cuando sea posible, reducir el ancho de bits si no es necesario, y usar herramientas de síntesis para mejorar la eficiencia de la lógica combinacional.

    <p align="center">
      <img src="/Lab_02/Images/Uso de recursos.png" alt="Uso de recursos" width="500">
      <br>
      <b>Figura 4.1 Uso de recursos del diseño en Quartus</b>
    </p>

4. ¿Qué impacto tiene aumentar el número de bits de la lectura de cada batería? ¿Qué impacto tiene aumentar el número de baterias del banco? 

    Aumentar el número de bits de la lectura de cada batería o el número de baterías en un banco tiene un impacto significativo en el uso de recursos y el rendimiento del sistema. Incrementar los bits de lectura aumenta el consumo de LUTs y FFs debido a la mayor complejidad de la lógica y al mayor ancho de bus necesario. Esto puede generar una mayor latencia, aunque mejora la precisión de las mediciones. Por otro lado, aumentar el número de baterías requiere más pines I/O, memoria y recursos para procesar y almacenar los datos, lo que incrementa la complejidad del diseño y el tiempo de procesamiento. Ambos cambios afectan la velocidad del sistema, pero permiten manejar más datos y mejorar la resolución de las mediciones.

5. Describa las diferencias entre los tipos de dato ```wire``` y  ```reg``` en Verilog y compare ambos con el tipo de dato ```logic``` en System Verilog.

    En Verilog, la diferencia principal entre wire y reg radica en su comportamiento: wire representa conexiones físicas, como su nombre lo indica, y no almacena valores; simplemente transporta señales y se asigna mediante una asignación continua usando assign. En cambio, reg sí almacena valores y solo puede ser asignado dentro de un bloque procedimental, como always o initial.

    En SystemVerilog, el tipo de dato logic combina las funcionalidades de wire y reg, permitiendo tanto asignaciones continuas como procedimentales. Esto simplifica el diseño y reduce los posibles errores asociados al uso incorrecto de wire y reg en Verilog.

6. Únicamente con lo que se vio en clase, describa cómo se usó el bloque ```always```. Enfoque su respuesta hacia la implementación de lógica combinacional.

    El bloque always es un bloque procedimental que permite asignar valores a las variables de tipo reg. Sin embargo, en este caso, dicho bloque no se utilizó en la implementación. En su lugar, se empleó su equivalente, el bloque initial, exclusivamente en el código de simulación.


## Conclusiones

  El diseño e implementación del monitor de carga en una FPGA permitieron aplicar conceptos clave de electrónica digital, desde los niveles estructurales hasta los comportamentales. La solución se desarrolló mediante una metodología organizada, comenzando con un diagrama de bloques que facilitó la identificación y distribución de los módulos necesarios. Esta estrategia permitió descomponer el problema en tareas más manejables y enfocarse en satisfacer cada funcionalidad requerida.

  Uno de los principales logros fue la implementación eficiente de los módulos, destacando el diseño del sumador de 4 bits, construido a partir de la instanciación de sumadores de 1 bit sin utilizar optimizaciones avanzadas como fast carry. Este enfoque resalta la importancia de comprender los principios básicos del diseño lógico antes de recurrir a herramientas automáticas de optimización. Adicionalmente, los módulos comparadores, diseñados para clasificar los niveles de carga en rangos definidos, demostraron cómo la planificación detallada puede simplificar la implementación de tareas complejas en hardware.

  A pesar de los avances logrados en simulación, se identificaron desafíos al llevar el diseño al hardware, como la inversión de señales en las salidas y el impacto del incremento en el número de bits y baterías sobre los recursos de la FPGA. Estas experiencias subrayan la importancia de considerar las limitaciones del hardware desde las primeras etapas del diseño y de realizar un análisis detallado del uso de recursos, incluyendo LUTs, FFs y BRAMs, para garantizar una implementación viable.

  En resumen, este proyecto permitió consolidar conocimientos en el diseño digital y el uso de herramientas como Quartus para la implementación en FPGA. Además, se reafirmó la importancia de una metodología de diseño estructurada y de prever posibles discrepancias entre la simulación y la implementación física. Estas lecciones serán valiosas para futuros proyectos en electrónica digital y sistemas embebidos.

## Referencias

* [1] J. Bhasker, A SystemVerilog Primer, Star Galaxy Publishing, 2005.
* [2] T. L. Floyd, Digital Fundamentals, Pearson Education Inc., 2006.
* [3] C. H. Roth and L. L. Kinney, Fundamentals of Logic Design, 7th ed., Cengage Learning, 2018.
* [4] D. M. Harris and S. L. Harris, Digital Design and Computer Architecture, 3rd ed., Morgan Kaufmann,2022.
* [5] Intel FPGA, Intel Quartus Prime Standard Edition Handbook, 2024. Available: https://www.intel.com
