#!/bin/bash

ARCHIVO_LOG="/tmp/operaciones_usuario.log"

# Función para mostrar mensaje de éxito, registrar y salir del script
mostrar_exito() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Éxito: $1" >> "$ARCHIVO_LOG"
    zenity --info --title="Éxito" --text="$1"
    exit 0
}

# Función para mostrar mensaje de error, registrar y salir del script
mostrar_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: $1" >> "$ARCHIVO_LOG"
    zenity --error --title="Error" --text="$1"
    exit 1
}

# Obtengo la lista de usuarios
usuarios=$(cut -d: -f1 /etc/passwd)

# Solicito el usuario a dar de baja
usuario=$(zenity --list --title="Seleccionar Usuario" --text="Selecciona el usuario a dar de baja:" --column="Usuarios" $usuarios)

# Salir si se selecciona Cancelar en lugar de Aceptar
if [ $? -ne 0 ]; then
    zenity --info --title="Cancelado" --text="Operación cancelada por el usuario."
    exit 0
fi

# Verifico que se seleccionó un usuario
if [ -z "$usuario" ]; then
    mostrar_error "No se seleccionó ningún usuario."
fi

# Solicito una fecha límite
# Si selecciona la fecha actual o un día anterior de todas formas se hará la baja automáticamente
fecha_limite=$(zenity --calendar --title="Seleccionar Fecha" --text="Seleccione la fecha límite para dar de baja al usuario $usuario:" --date-format="%Y-%m-%d")

# Salir si se selecciona Cancelar en lugar de Aceptar
if [ $? -ne 0 ]; then
    zenity --info --title="Cancelado" --text="Operación cancelada por el usuario."
    exit 0
fi

# Verifico si se ingresó una fecha válida
if [ -z "$fecha_limite" ]; then
    mostrar_error "Debe seleccionar una fecha válida."
fi

# Pedir confirmar la operación
zenity --question --title="Confirmar" --text="¿Está seguro de que desea dar de baja al usuario $usuario con fecha límite $fecha_limite?"
if [ $? -ne 0 ]; then
    zenity --info --title="Cancelado" --text="Operación cancelada por el usuario."
    exit 0
fi

# Dar de baja al usuario
if sudo userdel -r "$usuario"; then
    mostrar_exito "El usuario $usuario fue dado de baja con éxito."
else
    mostrar_error "Hubo un problema al dar de baja al usuario $usuario."
fi
