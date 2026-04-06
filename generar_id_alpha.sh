#!/bin/bash
# Generador Alpha con AUTO-SIGN - J Andres Resendez R.
CANAL=$1
ENTIDAD=$2
UUID=$(cat /proc/sys/kernel/random/uuid | cut -c1-8)
ID_FULL="LEDL-$UUID-ALPHA"
DESTINO="$HOME/LEDL_Core/Captacion_de_Usuarios/$CANAL/$ENTIDAD/$ID_FULL"

mkdir -p "$DESTINO"

# 1. Crear Log de Identidad
cat <<EOM > "$DESTINO/identidad_alpha.log"
TITULAR: J ANDRES RESENDEZ R.
ORCID: 0009-0007-3528-9413
UUID: $ID_FULL
LINK: https://ledl.acsfdl.org/auth?v=$UUID&origin=$CANAL
STATUS: FIRMADO_POR_PROPIETARIO
EOM

# 2. AUTO-SIGN (Bypass PINENTRY)
gpg --batch --pinentry-mode loopback --clear-sign "$DESTINO/identidad_alpha.log"

# 3. Limpieza de rastro (opcional: borrar el original sin firmar)
mv "$DESTINO/identidad_alpha.log.asc" "$DESTINO/identidad_alpha_FIRMADO.asc"
rm "$DESTINO/identidad_alpha.log"

echo ">> [EXITO] Nodo Alpha $UUID creado y FIRMADO automáticamente."
