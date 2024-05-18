#!/bin/bash

# Función para mostrar el menú principal
mostrar_menu_principal() {
    opcion=$(zenity --list \
        --title="Menú Principal" \
        --column="Opción" \
        "Crear Usuario" \
        "Dar de Baja Usuario" \
	"Enviar Correo sobre las Operaciones Ejecutadas" \
        "Salir")

      case $opcion in
        "Crear Usuario") ejecutar_script "scriptCrearUsuario3" ;;
        "Dar de Baja Usuario") ejecutar_script "scriptDarBaja2" ;;
	"Enviar Correo sobre las Operaciones Ejecutadas" ) ejecutar_script "scriptEnviarMail" ;;
        "Salir") exit 0 ;;
        *) mostrar_menu_principal ;;
    esac
}

# Función para ejecutar un script dado
ejecutar_script() {
    script="$1"
    if [ -x "$script" ]; then
        ./"$script"
    else
        zenity --error --title="Error" --text="El script $script no es ejecutable."
    fi
    mostrar_menu_principal
}

mostrar_menu_principal
