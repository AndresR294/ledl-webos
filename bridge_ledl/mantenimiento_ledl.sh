#!/bin/bash
# ==========================================================
# PROYECTO: ENSDELIZ PREVENTIVA - AUTO-MANTENIMIENTO
# AUTOR: J ANDRES RESENDEZ R | LICENCIA: LEDL
# TODOS LOS DERECHOS RESERVADOS © 2026
# ==========================================================

echo "--- INICIANDO PROTOCOLO ENSDELIZ PREVENTIVA ---"

# 1. Limpiar Logs de WhatsApp (Baileys genera archivos pesados)
rm -rf ~/bridge_ledl/auth_info_ledl/baileys-store.json.gz 2>/dev/null
find ~/bridge_ledl -name "*.log" -type f -delete

# 2. Limpiar caché de Python y temporales
find . -type d -name "__pycache__" -exec rm -rf {} +
rm -rf ~/.cache/pip

# 3. Optimizar bases de datos (SQLite Vacuum)
sqlite3 ~/mandados.db "VACUUM;" 2>/dev/null

# 4. Sincronización final de seguridad antes de cerrar el ciclo
# rclone sync ~/ LEDL_CLOUD:Backup

echo "--- SISTEMA OPTIMIZADO AL 100% PARA ANDRES RESENDEZ ---"
