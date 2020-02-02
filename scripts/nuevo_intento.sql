SELECT valor_centrifuga.fecha_dia, centrifuga.equipo, alineacion_unidad.unidad_polimero_unidad, valor_centrifuga.entrada_lodo, 
	valor_centrifuga.entrada_polimero, SUM(preparacion_polimero.peso), SUM(preparacion_polimero.caudal_agua)
FROM valor_centrifuga
	INNER JOIN centrifuga
		ON valor_centrifuga.centrifuga_idcentrifuga = centrifuga.idcentrifuga
	INNER JOIN preparacion_polimero
		ON valor_centrifuga.fecha_dia = preparacion_polimero.fecha_dia