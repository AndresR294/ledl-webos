#!/data/data/com.termux/files/usr/bin/bash
# LEDL_AIKO ENSDELIZ HYBRID v100.5 — BARREDORA CRYPTO HUNTER ESTABLE
# MASTER: J ANDRES RESENDEZ R. | LO IMPOSIBLE NO EXISTE

echo "🧹 LIMPIEZA TOTAL + ACTUALIZACIÓN v100.5..."
cd /data/data/com.termux/files/home
pkill -9 -f ledl_bridge.js 2>/dev/null || true
rm -rf LEDL_CORE 2>/dev/null || true

mkdir -p LEDL_CORE
cd LEDL_CORE

# Crear logs con permisos correctos
touch bridge.log crypto_hallazgos.log
chmod 600 bridge.log crypto_hallazgos.log

echo "📦 INSTALANDO DEPENDENCIAS..."
pkg install -y python nodejs termux-api > /dev/null 2>&1
npm init -y > /dev/null 2>&1
npm install express cors > /dev/null 2>&1

termux-wake-lock

# Configurar almacenamiento (importante para /sdcard)
termux-setup-storage

echo "📝 CREANDO NÚCLEO + BARREDORA SEGURA v100.5..."

cat << 'NODE' > ledl_bridge.js
const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');
const app = express();

app.use(cors());
app.use(express.json());

let currentThought = "🧠 LEDL_AIKO v100.5 + CRYPTO HUNTER ACTIVO...";
let currentProgress = 0;
let isScanning = false;

const SEARCH_PATHS = [
    "/data/data/com.termux/files/home",
    "/sdcard",
    "/storage/emulated/0",
    "/storage/self/primary",
    "/storage/emulated/0/Download",
    "/storage/emulated/0/Documents"
];

app.get('/status', (req, res) => {
    const bar = `[\( {"█".repeat(Math.floor(currentProgress/5))} \){"░".repeat(20-Math.floor(currentProgress/5))}] ${currentProgress}%`;
    res.json({ 
        thought: currentThought, 
        progress: currentProgress, 
        progress_bar: bar,
        scanning: isScanning 
    });
});

app.post('/barredora_crypto', (req, res) => {
    if (isScanning) return res.json({ status: "YA_EN_PROCESO" });

    isScanning = true;
    currentProgress = 0;
    currentThought = "🧹 BARREDORA CRYPTO HUNTER INICIADA — Buscando wallets, seeds, keys...";

    const logFile = "/data/data/com.termux/files/home/LEDL_CORE/crypto_hallazgos.log";
    exec(`echo "[$(date)] === BARREDORA INICIADA === " > ${logFile}`, () => {});

    let step = 0;
    const total = SEARCH_PATHS.length;

    SEARCH_PATHS.forEach((path, idx) => {
        setTimeout(() => {
            currentThought = `🧹 ESCANEANDO: ${path}`;
            currentProgress = Math.round(((idx + 1) / total) * 85);  // deja margen para final

            const cmd = `
                echo "[$(date)] === ESCANEANDO ${path} ===" >> ${logFile} 2>/dev/null;
                find "${path}" -type f \\( -name "*.json" -o -name "*.txt" -o -name "*.log" -o -name "*.bak" -o -name "*keystore*" \\) 2>/dev/null |
                head -n 800 |
                xargs -I {} sh -c '
                    if grep -qE "0x[a-fA-F0-9]{64}" "{}" 2>/dev/null; then
                        echo "[🔑 PRIVATE KEY DETECTADA] {}" >> ${logFile};
                    fi;
                    if grep -qE "(mnemonic|seed phrase|recovery phrase|12 words|24 words|backup phrase)" "{}" 2>/dev/null || 
                       (grep -qE "\\b[a-z]{4,}\\s+[a-z]{4,}\\s+[a-z]{4,}" "{}" 2>/dev/null && grep -qE "(seed|wallet|phrase)" "{}" 2>/dev/null); then
                        echo "[🌱 POSIBLE SEED PHRASE] {}" >> ${logFile};
                    fi;
                    if grep -qE "(keystore|UTC--|MetaMask|TrustWallet|wallet.json|phantom|coinbase)" "{}" 2>/dev/null; then
                        echo "[📦 WALLET / KEYSTORE FILE] {}" >> ${logFile};
                    fi;
                ' 2>/dev/null
            `;

            exec(cmd, (err) => {
                if (idx === total - 1) {
                    currentThought = "✅ BARREDORA COMPLETADA — Revisa crypto_hallazgos.log";
                    isScanning = false;
                    currentProgress = 100;
                    exec(`echo "[$(date)] === BARREDORA FINALIZADA === " >> ${logFile}`, () => {});
                }
            });
        }, idx * 3000);
    });

    res.json({ status: "BARREDORA_INICIADA", log: logFile });
});

app.listen(9191, '0.0.0.0', () => {
    console.log('🚀 LEDL_AIKO v100.5 con BARREDORA CRYPTO HUNTER en puerto 9191');
    console.log('✅ MASTER: J ANDRES RESENDEZ R. | LO IMPOSIBLE NO EXISTE');
});
NODE

echo "🚀 INICIANDO SERVIDOR 24/7..."
nohup node ledl_bridge.js > /data/data/com.termux/files/home/LEDL_CORE/bridge.log 2>&1 &

echo "===================================================="
echo "✅ LEDL v100.5 + BARREDORA SEGURA 24/7 ACTIVA"
echo ""
echo "Inicia barredora:"
echo "   curl -X POST http://localhost:9191/barredora_crypto"
echo ""
echo "Ver estado en tiempo real:"
echo "   curl http://localhost:9191/status"
echo ""
echo "Ver hallazgos:"
echo "   cat /data/data/com.termux/files/home/LEDL_CORE/crypto_hallazgos.log"
echo "   o: tail -f /data/data/com.termux/files/home/LEDL_CORE/crypto_hallazgos.log"
echo "===================================================="
