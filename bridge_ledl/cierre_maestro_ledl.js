/* ==========================================================
PROYECTO: ECOSISTEMA LEDL - SCRIPT DE CIERRE MAESTRO
AUTOR: J ANDRES RESENDEZ R | LICENCIA: LAS ENSEÑANZAS DE LIZ
TODOS LOS DERECHOS RESERVADOS © 2026
==========================================================
*/

const welcomeMessage = `
🏠 *¡Bienvenido a "Te Hacemos Los Mandados" - Valle del Roble!* 🛵💨

Soy *EnsDeLiz*, tu asistente inteligente. Estoy aquí para llevarte lo que necesites hasta la puerta de tu casa.

📍 **Zona:** Valle del Roble, Cadereyta (5KM Radio)
💰 **Envío Fijo:** $35 (Hasta las 10:00 PM)

*Por favor, elige una opción enviando el número:*
1️⃣ **COMIDA:** Ver restaurantes afiliados en la zona.
2️⃣ **SÚPER / FARMACIA:** Lista de tiendas disponibles.
3️⃣ **MANDADO ESPECIAL:** ¿Quieres que recojamos algo específico?
4️⃣ **REPARTIDOR:** Quiero trabajar en el equipo LEDL.

---
*Ecosistema Operativo de J Andres Resendez R.*
`;

// Lógica de respuesta automática (Esclava del motor Python)
if (text.match(/hola|info|precio|buen/gi)) {
    await sock.sendMessage(from, { text: welcomeMessage });
}
