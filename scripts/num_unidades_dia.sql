# TABLA DE UNIDADES DISPONIBLES POR TIPO DE ALINEACION Y DÍA
CREATE TABLE unidades_dia(
SELECT alineacion_polimero_alineacion, COUNT(unidad_polimero_unidad) as num_unidades
	FROM alineacion_unidad
		INNER JOIN preparacion_polimero
			ON alineacion_unidad.unidad_polimero_unidad = preparacion_polimero.polimero_unidad_unidad_polimero_unidad
    WHERE preparacion_polimero.caudal_agua > 10 AND preparacion_polimero.fecha_dia = DATE_ADD(CURDATE(), INTERVAL -20 DAY)
	GROUP BY alineacion_polimero_alineacion
)
