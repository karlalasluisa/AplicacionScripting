# Script de Bash para  la Gestión de Usuarios 

El conjunto de scripts están diseñados para administrar usuarios en un sistema Linux mediante una interfaz gráfica utilizando Zenity. Los scripts permiten la creación de usuarios, la desactivación de usuarios a partir de una fecha específica y el envío de registros de estas operaciones por correo electrónico.

## Scripts

### 1. Menú (Menu)

El primer y principal script `Menu` muestra un menú interactivo donde se pueden seleccionar las siguientes opciones:

- **Crear Usuario**: Ejecuta el script `scriptCrearUsuario3`.
- **Dar de Baja Usuario**: Ejecuta el script `scriptDarBaja2`.
- **Enviar Correo sobre las Operaciones Ejecutadas**: Ejecuta el script `scriptEnviarMail`.
- **Salir**: Termina la ejecución de todo el programa.

### 2. Crear Usuario y Asignar Permisos (scriptCrearUsuario3)

El script `scriptCrearUsuario3` permite la creación de un nuevo usuario en el sistema. Al ingresar el nombre del usuario, se verifica si el nombre ya existe. Luego, se pregunta si se desean asignar permisos adicionales al nuevo usuario. Si se seleccionan permisos, se crea el usuario y se le asignan los permisos seleccionados. Finalmente, se muestra un mensaje de éxito o error y se registra la operación en un archivo de log que se usará para guardar la información de las ejecuciones y así poder usarla en el script  `scriptEnviarMail' .

### 3. Dar de Baja a partir de una Fecha Concreta (scriptDarBaja2)

El script `scriptDarBaja2` permite dar de baja a un usuario del sistema a partir de una fecha específica. Primero, muestra una lista de usuarios disponibles para seleccionar. Luego, solicita ingresar una fecha límite para desactivar el usuario seleccionado. La fecha podría ser incluso la actual o días anteriores, pues se considerará que ese usuario ya debería haberse dado de baja, entonces la baja se hace automáticamente. Se pide confirmación antes de realizar la operación. Si se completa con éxito, se muestra un mensaje de éxito y se registra la operación en el archivo de log.

### 4. Enviar Correos sobre las Operaciones Anteriores Realizadas (scriptEnviarMail)

El script `scriptEnviarMail` envía por correo electrónico el contenido del archivo de log de operaciones del sistema que ha ido guardando la información de los dos scripts anteriores. Solicita al usuario ingresar una dirección de correo electrónico y luego envía el log por correo electrónico a la dirección proporcionada. Se muestra un mensaje de éxito o error según el resultado del envío. Para realizar este script he tomado como referencia los apuntes de Silvia 'Bash- script send mail 2ASIR y eliminación ^M.pptx' del aulaO. De modo que para poder ejecutarlo con vuestro correo electrónico (yo he hecho las pruebas con el mío) será necesario: Activar verificación en dos pasos, crear una contraseña de aplicación, tener instalado ssmtp y editar el fichero de configuración con los datos necesarios (fichero/etc/ssmtp/ssmtp.conf). Todo esto está más detallado en sus apuntes.


## Uso
1. Haz que todos los scripts sean ejecutables (`chmod +x script.sh`).
2. Ejecuta solo el script `Menu` para acceder al menú principal y poder probar las opciones.

Estos scripts son útiles para la gestión automatizada de usuarios en sistemas Linux, proporcionando una interfaz simple y efectiva para realizar operaciones comunes de administración de usuarios y registros de operaciones.
