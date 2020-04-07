local h, d, sd, rc, re, v
io.write ("Altura: ")
h = io.read()
io.write ("Diâmetro da esfera: ")
sd = io.read()
io.write ("Diâmetro do furo: ")
d = io.read()
rc = d/2
re = sd/2
v = (3.14 * (h * h) * ((3*re)- h))/(3)
io.write ("O volume total é ", v, "\n")