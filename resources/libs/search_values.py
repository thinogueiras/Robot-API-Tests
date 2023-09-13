
def find_value_by_id(lista, id):
    for item in lista:
        if item['conta_id'] == id:
            return item['saldo']
    return None


def find_value_by_key(lista, key):
    for item in lista:
        return item[key]
