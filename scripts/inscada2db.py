import numpy as np
from openpyxl import load_workbook

inscada = load_workbook(filename = r'T:\\BALANCE\\IN SCADA\\Inscada 2020.xlsm', data_only=True)
excel_db = load_workbook(filename = r'T:\\PROCESOS\\18. Seguimientos\\Espesamiento\\db\\excel\\db_espesamiento_prueba.xlsx', data_only=True)

def array2list(array):
    '''
        Devuelve una lista a partir de un array de openpyxl 
    '''

    return [x[0].value for x in array]

def xl2npMatrix(hoja, minrow, maxrow, mincol, maxcol):
    '''
        Toma una hoja de excel y tras definir los limites de extracción de datos,
        (fila minima, fila máxima, columna minima, columna máxima) devuelve una
        matriz de numpy.

        :param hoja: Nombre de la hoja de excel de la que extraen los datos
        :param minrow: Numero de la fila donde se empieza a rescatar los valores.
        :param maxrow: Numero de la fila donde termina de rescatar los valores.
        :param mincol: Numero de la columna donde se empieza a rescatar los valores.
        :param maxcol: Numero de la columna donde termina de rescatar los valores.
        :returns: Matriz de Numpy con los valores.

        >>> xl2npMatrix('hoja1', 1, 3, 2, 4)
        array([[1, 0, 1],
               [1, 0, 1]])
    '''

    listo = list()

    for row in hoja.iter_rows(min_row = minrow, max_row = maxrow, 
    min_col = mincol, max_col = maxcol):
        for cell in row:
            listo.append(cell.value)
    
    listo = np.array(listo)
    listo = listo.reshape(maxrow - minrow + 1, maxcol - mincol + 1)

    return listo

####################################################################################################################
# MAIN
####################################################################################################################

# Carga la hoja a utilizar
espesamiento = inscada['Espesamiento 2°']

# Rescate de valores

# array de zeros
zeros = np.zeros((31,2), dtype='float')

## Matriz con los valores de lodo
lodos = xl2npMatrix(espesamiento, 101, 131, 9, 16)

## MAtriz con los valores de polimero
polimeros = xl2npMatrix(espesamiento, 101, 131, 23, 30)

## Matriz con los valores de torque
torque = xl2npMatrix(espesamiento, 101, 131, 31, 36)
for i in range(31):
    for j in range(6):
        if torque[i,j][-1].isalpha() == True:
            torque[i,j] = '0'
torque = torque.astype('float')
torque = np.concatenate((torque,zeros), axis=1)

## Matriz con los valores de vr
vr = xl2npMatrix(espesamiento, 101, 131, 37, 42)
for i in range(31):
    for j in range(6):
        if vr[i,j][-1].isalpha() == True:
            vr[i,j] = '0'
vr = vr.astype('float')
vr = np.concatenate((vr, zeros), axis=1)

# Reordenamos las matrices
lodos = lodos.reshape((31*8,1))
polimeros = polimeros.reshape((31*8,1))
torque = torque.reshape((31*8,1))
vr = vr.reshape((31*8,1))

arreglo = np.concatenate((lodos, polimeros, torque, vr), axis=1)

####################################################################################################################
# ESCRITURA EXCEL
####################################################################################################################

