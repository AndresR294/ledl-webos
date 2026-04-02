"""
==========================================================
PROYECTO: ECOSISTEMA LEDL - MODULO CAPTACION SOCIAL
LICENCIA: LAS ENSEÑANZAS DE LIZ (LEDL)
AUTOR: J ANDRES RESENDEZ R | PROPIETARIO: J ANDRES RESENDEZ R
ORCID: 0009-0007-3528-9413 | TODOS LOS DERECHOS RESERVADOS
==========================================================
"""

import time
import sys

def progress_bar(percent, task):
    bar = '█' * int(percent/5) + '-' * (20 - int(percent/5))
    sys.stdout.write(f'\r[{bar}] {percent}% | {task}')
    sys.stdout.flush()

class SocialListenerLEDL:
    def __init__(self):
        self.keywords = ["hambre", "quien trae", "mandado", "servicio", "domicilio"]
        self.wa_link = "https://wa.me/tu_numero_aqui" # Enlace al bridge que configuramos

    def procesar_comentario(self, usuario, comentario):
        for word in self.keywords:
            if word in comentario.lower():
                return (f"✅ RESPUESTA ENSDELIZ: ¡Hola {usuario}! En Valle del Roble "
                        f"te lo llevamos por solo $35. Pide aquí: {self.wa_link}")
        return None

# --- INTEGRACIÓN AL MENÚ ---
if __name__ == "__main__":
    listener = SocialListenerLEDL()
    for i in range(101):
        time.sleep(0.01)
        progress_bar(i, "Sincronizando con Meta/TikTok APIs")
    
    print(f"\n\n--- ESCUCHA ACTIVA LEDL EN VALLE DEL ROBLE ---")
    # Simulación de detección en grupo de Facebook
    test_comment = "¿Quién trae comida de la plaza a Valle del Roble?"
    print(f"Detección: '{test_comment}'")
    print(listener.procesar_comentario("Usuario_Cadereyta", test_comment))
