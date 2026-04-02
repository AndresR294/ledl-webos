from fastapi import FastAPI
from core.engine import ranking_tiendas, seleccionar_repartidor

app = FastAPI()

@app.get("/")
def root():
    return {"status": "LEDL activo"}

@app.post("/buscar_producto")
def buscar():
    tiendas = [
        {"nombre": "Abarrotes Liz", "precio": 150, "eta": 15, "dist": 0.5},
        {"nombre": "Super Express", "precio": 145, "eta": 25, "dist": 1.2}
    ]
    
    ranking = ranking_tiendas(tiendas)
    mejor = ranking[0]
    
    tipo = seleccionar_repartidor(mejor['dist'])
    
    return {
        "mejor_opcion": mejor,
        "tipo_entrega": tipo
    }
