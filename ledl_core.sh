#!/bin/bash
# =================================================================
# CEREBRO OPERATIVO LEDL - ORQUESTADOR MAESTRO v1.5
# PROPIETARIO: J ANDRES RESENDEZ R. | ORCID: 0009-0007-3528-9413
# =================================================================

D_PADRE="$HOME/LEDL_Core"
D_CAPTACION="$D_PADRE/Captacion_de_Usuarios"

# --- 1. FUNCIÓN DE ANIMACIÓN LEDL ---
PROGRESS_BAR() {
    echo -ne "\033[1;36mInvocando Ecosistema LEDL: [##########          ] 50%\r"
    sleep 0.5
    echo -ne "\033[1;36mInvocando Ecosistema LEDL: [####################] 100%\n\033[0m"
}

# --- 2. ACCIONES DEL DASHBOARD ---
case $1 in
    "3") # MODO ESPEJO / SINCRONIZACIÓN
        echo ">> Sincronizando Modo Espejo con Cloud Infinito..."
        mkdir -p "$D_CAPTACION"
        tar -czf "$D_PADRE/mirror_sync.tar.gz" -C "$D_CAPTACION" .
        echo ">> [OK] Paquete Alpha Mirror consolidado."
        ;;
    *)
        clear
        echo -e "\033[1;33m[[ CEREBRO OPERATIVO LEDL - DASHBOARD PROPIETARIO ]]\033[0m"
        PROGRESS_BAR
        echo -e "\n\033[1;32mOPCIONES DISPONIBLES:\033[0m"
        echo "1) Crear Identidad Alpha (Usuario/Repartidor/Negocio)"
        echo "2) Ver Identidades Firmadas (GPG Verify)"
        echo "3) Sincronizar Espejo Manual (Cloud)"
        echo "4) Salir"
        read -p ">> Seleccione Acción: " OPT
        
        case $OPT in
            1)
                read -p "Canal (FB/TG/MKT): " C
                read -p "Tipo (Repa/Clien/Neg): " T
                bash "$D_PADRE/generar_id_alpha.sh" "$C" "$T"
                ;;
            2)
                echo ">> Verificando firmas soberanas..."
                gpg --verify $(find "$D_CAPTACION" -name "*FIRMADO.asc" 2>/dev/null)
                ;;
            3)
                bash "$D_PADRE/deploy_vercel.sh"
                ;;
            *) exit 0 ;;
        esac
        ;;
esac
