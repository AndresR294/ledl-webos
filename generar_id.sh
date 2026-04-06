#!/bin/bash
# Autor: J Andres Resendez R. | ORCID: 0009-0007-3528-9413
CANAL=$1
ENTIDAD=$2 # Cliente, Negocio, Repartidor

if [ -z "$CANAL" ] || [ -z "$ENTIDAD" ]; then
    echo "Uso: ./generar_id.sh [Canal] [Entidad]"
    exit 1
fi

UUID=$(cat /proc/sys/kernel/random/uuid 2>/dev/null || date +%s%N)
# Hiperenlace invisible para la máquina (usando IP local o placeholder)
LINK="ledl_local://auth?uuid=$UUID&origin=$CANAL"

# Crear subcarpeta específica
DESTINO="$HOME/LEDL_Core/Captacion_Clientes/$CANAL/$ENTIDAD/$UUID"
mkdir -p "$DESTINO"

# Registro de Sinapsis
echo "ID: J Andres Resendez R." > "$DESTINO/identidad.log"
echo "UUID: $UUID" >> "$DESTINO/identidad.log"
echo "ORIGEN_INVISIBLE: $LINK" >> "$DESTINO/identidad.log"

echo "------------------------------------------------"
echo ">> IDENTIDAD CREADA: $ENTIDAD"
echo ">> CANAL: $CANAL"
echo ">> UUID: $UUID"
echo ">> RUTA: $DESTINO"
echo "------------------------------------------------"
