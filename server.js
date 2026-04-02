const express = require('express');
const WebSocket = require('ws');
const app = express();
const port = 3001;

app.use(express.static('public'));
const server = app.listen(port, () => {
  console.log(`LEDL OS JARVIS corriendo en http://localhost:${port}`);
});

const wss = new WebSocket.Server({ server });
wss.on('connection', ws => {
  console.log('Cliente conectado al Cerebro Operativo LEDL');
  ws.on('message', message => {
    console.log(`Comando recibido: ${message}`);
    ws.send(ejecutarComando(message.toString()));
  });
});

function ejecutarComando(cmd) {
  cmd = cmd.toLowerCase();
  if (cmd.includes("activar cerebro operativo")) {
    return "Bienvenido Andrés. Blindaje integral activo.";
  } else if (cmd.includes("mostrar constancias")) {
    return "Constancias jurídicas, técnicas, sociales y culturales desplegadas.";
  } else if (cmd.includes("línea del tiempo")) {
    return "Desplegando evolución completa con validaciones perpetuas.";
  } else if (cmd.includes("proclama el estado del blindaje")) {
    return "Declaración oficial: BLINDAJE INTEGRAL COMPLETO, VERIFICADO Y AUTOAPRENDIZ.";
  } else if (cmd.includes("test iq")) {
    return "Prueba IQ: ¿Cuál número sigue en la secuencia 2, 4, 8, 16?";
  } else {
    return "Comando no reconocido. Intente nuevamente.";
  }
}
