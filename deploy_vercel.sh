#!/bin/bash
# CONFIGURACIÓN SOBERANA
VERCEL_TOKEN="Vcp_3HuNHqbp7fTvsyKS3PbPK3xaeW1IMeEeiEVR3xil4L1mw2ECiv4LdI6X"
D_CAPTACION="$HOME/LEDL_Core/Captacion_de_Usuarios"

echo ">> [PROPIETARIO: J ANDRES RESENDEZ R.]"
echo ">> Sincronizando WebMachine..."

# Asegurar que el directorio existe
mkdir -p $D_CAPTACION
cd $D_CAPTACION

# Subir a Vercel capturando TODO el flujo
vercel --prod --yes --token $VERCEL_TOKEN > ~/vercel_output.txt 2>&1

# Extraer URL con un patrón más amplio
URL_PROD=$(grep -oE "https://[a-zA-Z0-9.-]+\.vercel\.app" ~/vercel_output.txt | tail -n 1)

if [ -z "$URL_PROD" ]; then
    echo ">> [!] No se detectó URL automática. Buscando enlace de inspección..."
    URL_PROD=$(grep -oE "https://vercel\.com/[a-zA-Z0-9./-]+" ~/vercel_output.txt | tail -n 1)
fi

echo "------------------------------------------------"
echo ">> [EXITO] PANEL DE CONTROL REFLEJADO"
echo ">> URL DE ACCESO PARA CHROME:"
echo -e "\033[1;32m$URL_PROD\033[0m"
echo "------------------------------------------------"
