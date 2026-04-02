#!/bin/bash
# ORQUESTADOR REORGANIZAR HOME - VERSIÓN SIMPLE Y FUNCIONAL
# Ejecuta esto en Termux

echo "🚀 Iniciando reorganización del HOME (versión simple)..."

# Crear carpetas primero
mkdir -p \~/projects/{ledl,ensdeliz,analyzers,business,android,ai-models,forensic,utils}
mkdir -p \~/data \~/logs \~/backups \~/scripts \~/temp

echo "✅ Estructura de carpetas creada"

# Función simple de movimiento
move() {
    if [ -e "$1" ] || [ -L "$1" ]; then
        echo "Moviendo: $1 → $2"
        mv "$1" "$2" 2>/dev/null || echo "   ⚠️  No se pudo mover $1"
    fi
}

echo "1. Moviendo LEDL principal..."
shopt -s nullglob
for item in LEDL* ledl* ledl_*; do move "$item" \~/projects/ledl/; done
shopt -u nullglob

echo "2. Moviendo EnsDeLiz..."
for item in EnsDeLiz* las_ensenanzas_de_liz; do move "$item" \~/projects/ensdeliz/; done

echo "3. Moviendo Analizadores..."
for item in aztec_* fortune_tiger_* ruleta_log.csv; do move "$item" \~/projects/analyzers/; done

echo "4. Moviendo Negocio (Mandados/Uber)..."
for item in mandados_* TeHacemosMandados* uber_* produccion_mty.sh appUber uber_pro uber_unicornio mandados_pro mandados_system; do move "$item" \~/projects/business/; done

echo "5. Moviendo Android..."
for item in Android android-sdk CppAiModelApp gradle_* deploy_* keystore.jks build validation-builds limpiar_gradle.sh; do move "$item" \~/projects/android/; done

echo "6. Moviendo IA y Modelos..."
for item in AI lora-tests benches bench-models-results.txt hellaswag* winogrande* wikitext* motor_ia.py generar_animacion.py ledl_ai_dashboard.py; do move "$item" \~/projects/ai-models/; done

echo "7. Moviendo Forense/Evidencia..."
for item in EVIDENCIA forensic_lab peritaje_* TIMELINE MOTO_* VALIDACION Validar Liquidacion_*.txt; do move "$item" \~/projects/forensic/; done

echo "8. Moviendo Datos pesados..."
for item in dav_* dav_converter* dav_convertidos dav_procesados FRAMES HASHES INPUT ISO METADATA PDF REPORTES RESOURCES Resources; do move "$item" \~/data/; done

echo "9. Moviendo logs y temporales..."
mv *.log *.csv errores.txt scan.txt list.txt archivo.txt temp.txt dead.letter wget-log* \~/logs/ 2>/dev/null || true

move ' \){CLOUDS[@]}' \~/temp/
move '\( BACKUP_DIR' \~/temp/
move '\( BASE' \~/temp/
move '\( SYNC_DIR' \~/temp/

echo "10. Moviendo scripts compartidos..."
for item in orquestador* script scripts __pycache__ setup_* instalar_* smart_storage_orchestrator.sh; do move "$item" \~/scripts/; done

# Archivos sueltos restantes a temp/
echo "Moviendo archivos sueltos restantes a \~/temp/..."
find \~ -maxdepth 1 -type f ! -name "*orquestador_reorganizar_home*" ! -name "*.log" -exec mv {} \~/temp/ \; 2>/dev/null || true

# Enlaces simbólicos
echo "Creando enlaces rápidos..."
ln -sfn \~/projects/ledl \~/ledl 2>/dev/null || true
ln -sfn \~/projects/business \~/negocio 2>/dev/null || true
ln -sfn \~/projects/analyzers \~/analyzers 2>/dev/null || true
ln -sfn \~/data \~/datos 2>/dev/null || true

echo ""
echo "🎉 Reorganización TERMINADA"
echo ""
echo "Revisa ahora:"
echo "   ls \~/projects/"
echo "   ls \~/temp/     ← mueve manualmente lo que quede aquí si es importante"
echo "   ls \~/ledl      ← acceso rápido al ecosistema principal"
echo ""
echo "Listo. Tu HOME ahora está mucho más limpio."
