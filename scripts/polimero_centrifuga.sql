SELECT valor_centrifuga.fecha_dia, centrifuga.equipo, alineacion_unidad.unidad_polimero_unidad, valor_centrifuga.entrada_lodo, 
	valor_centrifuga.entrada_polimero, preparacion_polimero.peso, preparacion_polimero.caudal_agua
FROM valor_centrifuga
	INNER JOIN centrifuga
		ON valor_centrifuga.centrifuga_idcentrifuga = centrifuga.idcentrifuga
	INNER JOIN alineacion_unidad
		ON valor_centrifuga.alineacion_polimero_alineacion = alineacion_unidad.alineacion_polimero_alineacion
	INNER JOIN polimero_unidad
		ON alineacion_unidad.unidad_polimero_unidad = polimero_unidad.unidad_polimero_unidad
	INNER JOIN preparacion_polimero
		ON polimero_unidad.unidad_polimero_unidad = preparacion_polimero.polimero_unidad_unidad_polimero_unidad
        AND valor_centrifuga.fecha_dia = preparacion_polimero.fecha_dia
WHERE valor_centrifuga.fecha_dia = '2020-01-01'