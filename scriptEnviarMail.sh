#!/bin/bash
# Archivo de log
ARCHIVO_LOG="/tmp/operaciones_usuario.log"

# Verifico si el archivo de log existe y no está vacío
if [ ! -s "$ARCHIVO_LOG" ]; then
    zenity --error --title="Error" --text="El archivo de log está vacío o no existe."
    exit 1
fi

# Solicito la dirección de correo electrónico
email=$(zenity --entry --title="Enviar Log" --text="Ingrese la dirección de correo electrónico:" --entry-text="usuario@example.com")

# Salir si se selecciona Cancelar en lugar de Aceptar
if [ $? -ne 0 ]; then
    zenity --info --title="Cancelado" --text="Operación cancelada por el usuario."
    exit 0
fi

# Verifico si se ingresó una dirección de correo válida
if [ -z "$email" ]; then
    zenity --error --title="Error" --text="Debe ingresar una dirección de correo electrónico válida."
    exit 1
fi

# Envío el correo electrónico
if cat "$ARCHIVO_LOG" | mail -s "Log de Operaciones del Sistema" "$email"; then
    zenity --info --title="Éxito" --text="El log se ha enviado con éxito a $email."
else
    zenity --error --title="Error" --text="Hubo un problema al enviar el correo electrónico."
    exit 1
fi
