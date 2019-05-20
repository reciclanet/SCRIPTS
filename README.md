# SCRIPTS
Scripts generados por Reciclanet para el diagnóstico e instalación de ordenadores con software libre

# SCRIPT ETIKETA
Información acerca del hardware del ordenador

# SCRIPT INSTALAR
1. Un ordenador cliente se conecta por red a un servidor PXE que le devuelve una imagen de SysRescue. 
2. En el ordenador cliente se teclea el comando `instalar` lo que nos da un menú a través del cual podemos elegir una imagen de Ubuntu previamente tuneada, que está almacenada dentro del servidor PXE.

Esta imagen ha sido creada con `fsarchiver` a partir de una instalación de Ubuntu (madre) tuneada y que luego ha sido almacenada en el servidor PXE. El tiempo de instalación dependerá de varios factores, pero nuestro promedio ronda los 5' para unas 10 makinas al mismo tiempo.
