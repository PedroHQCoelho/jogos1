local comprimento, voltas, reabastecimento, consumo, tanque
io.write("Comprimento da pista: ")
comprimento = io.read()
io.write("Número de voltas a serem percorridas: ")
voltas = io.read()
io.write("Número de reabastecimentos desejados: ")
reabastecimento = io.read()
io.write("Consumo do carro: ")
consumo = io.read()
tanque = (comprimento * voltas)/ (consumo * reabastecimento * 1000)
io.write("Comece a corrida com ", tanque, " litros no tanque. \n")