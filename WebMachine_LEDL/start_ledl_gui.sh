#!/bin/bash
# @file: start_ledl_gui.sh
# @author: J Andres Resendez R - Cerebro Operativo LEDL

echo -e "\033[36m[Modulo EnsDeLiz] Reiniciando WebMachine Virtual...\033[0m"

# 1. Limpieza profunda
vncserver -kill :1 > /dev/null 2>&1
rm -rf /tmp/.X1* /tmp/.X11-unix/*

# 2. Iniciar VNC Server
vncserver :1 -geometry 1280x720 -depth 24

# 3. Lanzar Fluxbox con delay para asegurar que Xserver esté listo
sleep 2
DISPLAY=:1 fluxbox > /dev/null 2>&1 &

# 4. Lanzar noVNC Proxy usando la ruta verificada
NOVNC_PATH="$HOME/WebMachine_LEDL/novnc_core/utils/novnc_proxy"
$NOVNC_PATH --vnc localhost:5901 --listen 6080 > /dev/null 2>&1 &

# 5. Animación de éxito
echo -e "\n\033[32m[SISTEMA SOBERANO ONLINE]\033[0m"
echo -e "Acceso: http://127.0.0.1:6080/vnc.html?autoconnect=true"

