# Scripts
Scripts generados por Reciclanet para el diagnóstico e instalación de ordenadores con software libre

## Script `etiketa`
Provee información acerca del hardware del ordenador

## Script `instalar`
1. Un ordenador cliente se conecta por red a un servidor PXE que le devuelve una imagen de SysRescue. 
2. En el ordenador cliente se teclea el comando `instalar` lo que nos da un menú a través del cual podemos elegir una imagen de Ubuntu previamente tuneada, que está almacenada dentro del servidor PXE.

Esta imagen ha sido creada con `fsarchiver` a partir de una instalación de Ubuntu (madre) tuneada y que luego ha sido almacenada en el servidor PXE. El tiempo de instalación dependerá de varios factores, pero nuestro promedio ronda los 5' para unas 10 makinas al mismo tiempo.

## Script `json_harddisk_csv.py`
1. El script accede al directorio './jsons/' y recoge todos los archivos '.json'.
2. El script añade a un archivo CSV (discos_duros.csv): fabricante, modelo, numero de serie, método de borrado seguro y el tamaño del disco en GB. Excepto si el numero de serie (del disco duro) ya está procesado.
