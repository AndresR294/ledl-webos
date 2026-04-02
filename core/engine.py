def ranking_tiendas(tiendas):
    for t in tiendas:
        t['score'] = (t['precio'] * 0.4) + (t['eta'] * 0.4) + (t['dist'] * 0.2)
    return sorted(tiendas, key=lambda x: x['score'])

def seleccionar_repartidor(distancia):
    if distancia <= 1:
        return "Caminando"
    elif distancia <= 1.5:
        return "Bicicleta"
    elif distancia <= 2.5:
        return "Moto eléctrica"
    else:
        return "Motocicleta"
