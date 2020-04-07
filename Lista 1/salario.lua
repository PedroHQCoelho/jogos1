local salario_bruto, inss, fgts, salario_descontado
plano_de_saude = 100
io.write("Informe o salário bruto: ")
salario_bruto = io.read()
inss = salario_bruto/10
fgts = salario_bruto * 0.08
salario_descontado = salario_bruto - (inss + fgts + plano_de_saude)
io.write("O salário com os descontos é de R$",salario_descontado, "\n")