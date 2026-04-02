/* * ==========================================================
 * PROYECTO: ECOSISTEMA LEDL - TE HACEMOS LOS MANDADOS
 * LICENCIA: LAS ENSEÑANZAS DE LIZ (LEDL)
 * AUTOR: J ANDRES RESENDEZ R
 * PROPIETARIO: J ANDRES RESENDEZ R
 * TODOS LOS DERECHOS RESERVADOS © 2026
 * ==========================================================
 */

const { 
    default: makeWASocket, 
    useMultiFileAuthState, 
    DisconnectReason, // Corregido: Importación directa
    fetchLatestBaileysVersion 
} = require('@whiskeysockets/baileys');
const { Boom } = require('@hapi/boom');
const qrcode = require('qrcode-terminal');
const { exec } = require('child_process');
const pino = require('pino');

async function connectToWhatsApp() {
    const { state, saveCreds } = await useMultiFileAuthState('auth_info_ledl');
    const { version } = await fetchLatestBaileysVersion();

    const sock = makeWASocket({
        version,
        auth: state,
        logger: pino({ level: 'silent' }), // Limpia la terminal de logs innecesarios
        printQRInTerminal: false // Manejo manual para evitar deprecación
    });

    sock.ev.on('creds.update', saveCreds);

    sock.ev.on('connection.update', (update) => {
        const { connection, lastDisconnect, qr } = update;

        // Mostrar QR de forma manual y limpia
        if (qr) {
            console.clear();
            console.log('--- ESCANEA PARA VINCULAR CON ENSDELIZ ---');
            qrcode.generate(qr, { small: true });
        }

        if (connection === 'close') {
            const reason = new Boom(lastDisconnect?.error)?.output?.statusCode;
            console.log('Conexión cerrada. Razón:', reason);
            
            // Lógica de reconexión corregida
            if (reason !== DisconnectReason.loggedOut) {
                console.log('Reconectando...');
                connectToWhatsApp();
            } else {
                console.log('Sesión cerrada. Borra la carpeta auth_info_ledl y reinicia.');
            }
        } else if (connection === 'open') {
            console.clear();
            console.log('==============================================');
            console.log('✅ ENSDELIZ: PUENTE WHATSAPP ACTIVO');
            console.log('PROPIEDAD DE: J ANDRES RESENDEZ R');
            console.log('ZONA: VALLE DEL ROBLE, CADEREYTA NL');
            console.log('==============================================');
        }
    });

    sock.ev.on('messages.upsert', async m => {
        const msg = m.messages[0];
        if (!msg.key.fromMe && m.type === 'notify') {
            const text = msg.message.conversation || msg.message.extendedTextMessage?.text || "";
            const from = msg.key.remoteJid;

            if (text.toLowerCase().startsWith('calcula')) {
                const args = text.split(' ');
                if (args.length < 4) {
                    sock.sendMessage(from, { text: "❌ Formato: *calcula [venta] [vehiculo] [km]*" });
                    return;
                }
                
                // Ejecución segura del motor de costos LEDL
                exec(`python3 ~/bot_mandados_ledl.py "${args[1]}" "${args[2]}" "${args[3]}"`, (error, stdout) => {
                    sock.sendMessage(from, { text: stdout || "⚠️ Error al procesar cálculo." });
                });
            }
        }
    });
}

connectToWhatsApp();
