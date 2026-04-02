import qrcode
from PIL import Image

# --- DATOS DE PROPIEDAD INTELECTUAL ---
LICENCIA = "LAS ENSEÑANZAS DE LIZ"
AUTOR = "J ANDRES RESENDEZ R"
CONTENIDO_QR = "8512593184:AAEXhOsMTjfnUOus5AkLS58q-py03lq2jlA" # Tu token de acceso

def generar_qr_ultra_hd():
    # Configuración de alta calidad
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H, # Máxima recuperación
        box_size=20, # Alta resolución
        border=4,
    )
    
    qr.add_data(CONTENIDO_QR)
    qr.make(fit=True)

    # Colores institucionales (Negro y Blanco para máxima compatibilidad)
    img = qr.make_image(fill_color="black", back_color="white").convert('RGB')
    
    # Guardar en la carpeta de usuario
    file_path = "QR_ACCESO_MAESTRO_LEDL.png"
    img.save(file_path, "PNG", quality=100)
    
    print(f"=========================================")
    print(f"✅ QR ULTRA HD GENERADO: {file_path}")
    print(f"LICENCIA: {LICENCIA}")
    print(f"AUTOR: {AUTOR}")
    print(f"=========================================")

if __name__ == "__main__":
    generar_qr_ultra_hd()
