#!/bin/bash

# Archivo de log donde se registrarán las operaciones que usaré en el scriptEnviarMail
ARCHIVO_LOG="/tmp/operaciones_usuario.log"

# Función para mostrar mensaje de éxito y salir del script
mostrar_exito() {
    if [ -z "$permisos" ]; then
        mensaje="Usuario $username creado con éxito."
    else
        mensaje="Usuario $username creado con éxito.\nPermisos asignados: $permisos"
    fi
    # Registrar el éxito en el archivo de log
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Éxito: $mensaje" >> "$ARCHIVO_LOG"
    zenity --info --title="Éxito" --text="$mensaje"
    exit 0
}

# Función para mostrar mensaje de error y salir del script
mostrar_error() {
    mensaje="$1"
    # Registrar el error en el archivo de log
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: $mensaje" >> "$ARCHIVO_LOG"
    zenity --error --title="Error" --text="$mensaje"
    exit 1
}

# Pedir nombre del nuevo usuario
username=$(zenity --entry --title="Crear Usuario" --text="Ingrese el nombre del nuevo usuario:")

# Salir si se selecciona Cancelar en lugar de Aceptar
if [ $? -ne 0 ]; then
    exit 0
fi

# Verificar si se ingresó un nombre de usuario válido
if [ -z "$username" ]; then
    mostrar_error "Debe ingresar un nombre de usuario."
fi

# Verificar si el nombre ya existe
if id -u "$username" >/dev/null 2>&1; then
    mostrar_error "El nombre de usuario '$username' ya existe."
fi

# Preguntar al usuario si desea agregar permisos
if zenity --question --title="Agregar Permisos" --text="¿Desea agregar permisos para este usuario?"; then
    # Solicitar al usuario seleccionar los permisos a asignar
    permisos=$(zenity --list \
                 --title="Selecciona los permisos" \
                 --text="Selecciona los permisos que deseas otorgar:" \
                 --checklist \
                 --column="Seleccionar" \
                 --column="Permiso" \
                 FALSE "Lectura" \
                 FALSE "Escritura" \
                 FALSE "Ejecución")

    # Verificar si se seleccionaron permisos
    if [ -z "$permisos" ]; then
        mostrar_error "No ha seleccionado ningún permiso."
    else
        # Crear el usuario y asignar permisos seleccionados
        sudo useradd -m "$username"
        for permiso in $permisos; do
            case $permiso in
                "Lectura") sudo usermod -aG read "$username" ;;
                "Escritura") sudo usermod -aG write "$username" ;;
                "Ejecución") sudo usermod -aG execute "$username" ;;
            esac
        done
        mostrar_exito
    fi
else
    # Crear el usuario sin permisos
    sudo useradd -m "$username"
    mostrar_exito
fi
