"""
==========================================================
PROYECTO: ECOSISTEMA LEDL - REPORTE FINANCIERO SEMANAL
LICENCIA: LAS ENSEÑANZAS DE LIZ | AUTOR: J ANDRES RESENDEZ R
ORCID: 0009-0007-3528-9413 | RÉGIMEN: RESICO (MÉXICO)
==========================================================
"""

import datetime
import time
import sys

def progress_bar(percent, task):
    bar = '█' * int(percent/5) + '-' * (20 - int(percent/5))
    sys.stdout.write(f'\r[{bar}] {percent}% | {task}')
    sys.stdout.flush()

class ReporteFinancieroLEDL:
    def __init__(self):
        self.comision_total_pct = 0.06 # 6% de ingresos plataforma
        self.tasa_resico = 0.015 # 1.5% promedio de ISR en RESICO

    def generar_balance(self, venta_semanal_total):
        ganancia_bruta_ledl = venta_semanal_total * self.comision_total_pct
        isr_estimado = ganancia_bruta_ledl * self.tasa_resico
        utilidad_neta = ganancia_bruta_ledl - isr_estimado
        
        return {
            "Periodo": "Semana Actual (Valle del Roble)",
            "Venta Total Red": f"${venta_semanal_total:,.2f}",
            "Comisión Plataforma (6%)": f"${ganancia_bruta_ledl:,.2f}",
            "Provisión ISR (RESICO)": f"${isr_estimado:,.2f}",
            "Utilidad Real LEDL": f"${utilidad_neta:,.2f}"
        }

if __name__ == "__main__":
    r = ReporteFinancieroLEDL()
    for i in range(101):
        time.sleep(0.01)
        progress_bar(i, "Consolidando Operaciones Semanales")
    
    # Simulación de $10,000 en ventas semanales en la zona
    balance = r.generar_balance(10000)
    print(f"\n\n--- REPORTE DE FACTURACIÓN LEDL ---")
    for k, v in balance.items():
        print(f" > {k}: {v}")
    print(f"\nFirmado: J ANDRES RESENDEZ R.")
