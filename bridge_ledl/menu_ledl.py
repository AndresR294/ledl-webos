# Modificación en el bloque de generación de imagen para evitar el auto-lanzamiento
if opcion == "6":
    for i in range(101):
        time.sleep(0.01)
        progress_bar(i, "Generando Recurso Gráfico HD")
    os.system('python3 gen_qr_hd.py')
    print("\n\n✅ Recurso guardado en el almacenamiento local.")
    input("Presione Enter para volver...")
