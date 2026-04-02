#!/bin/bash
# MAPEADOR DE ECOSISTEMA LEDL - J. ANDRES RESENDEZ R.
# Este script sube carpetas específicas a RAMAS específicas de GitHub

PROYECTO=$1
RAMA=$2

if [ -z "$PROYECTO" ] || [ -z "$RAMA" ]; then
    echo "Uso: ./mapeador_ecosistema_ledl.sh [Carpeta] [Nombre-Rama]"
    exit 1
fi

echo "--- MAPEANDO PROYECTO: $PROYECTO A RAMA: $RAMA ---"

# Crear o mover a la rama del proyecto
git checkout -B $RAMA
git add $PROYECTO
git commit -m "UPDATE: Proyecto $PROYECTO sincronizado en rama $RAMA - J.A.R.R."
git push origin $RAMA --force

# Regresar a la rama principal (Main/Master)
git checkout main
