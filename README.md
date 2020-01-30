# Database espesamiento

Proyecto de implementación de una base de datos en MySQL que reuna de manera ordenada losddatos relacionados a resultados de las áreas de espesamiento, deshidratación y su consumo de polímero.


Estos datos serán posteriormente utilizados en las distintas aplicaciones a desarrollar.

## Objetivos

- Crear una base de datos que cumpla con la 3NF.
- Tener tablas diferenciadas de acuerdo al origen de los datos (SCADA, Laboratorio, Terreno)
- Ser capaz de replicar las planillas de balance de lodo para espesamiento y deshidratación a partir de la base.

## Notas

- Todas las tablas debe contar con un *surrogate key* que sea autoincrementada para ficilitar los joints.
- Completar el listados de index para ficilitar los joint (INVESTIGAR).
- Incluir una tabla con el destino de los polímeros.
- Existe una diferencia importante que hay que conciderar entre la preparación de polímero por unidad y la unidad (o unidades con las que se encuentra alineada cada centrífuga. Yo no estaba tomando en cuneta esta diferencia pero hay que ver como see incorpora al modelo, ya que influye en el cálculo de los ratios finales.

## Ideas

- Cada centrifuga tiene su origen de lodo, que tal si hago que cada centrifuga tenga su origen de polímero. Esta tabla tendría todas las opciones de alineación. y esta misma tabla debe conectar con los datos de preparación de polpimero para poder hacer el ajuste.
