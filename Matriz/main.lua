local mapa = {}
local tempo = 0

function love.load()
 for i=1, 26, 1 do --Gera aleatoriamente uma matriz 26 x 20
 mapa[i] = {}
 for j=1, 20, 1 do
 mapa[i][j] = love.math.random(0, 6)
 end
 end
end

function love.update(dt)
  tempo = tempo + dt
  if (tempo > 0.05) then
 for i=1, 26, 1 do
 mapa[i] = {}
 for j=1, 20, 1 do
 mapa[i][j] = love.math.random(0, 6)
 end
end
tempo = 0
end
end
  

function love.draw()
 for i=1, 26, 1 do --Percorre a matriz e desenha quadrados coloridos
 for j=1, 20, 1 do
 if (mapa[i][j] == 0) then
 love.graphics.setColor(255,0,0)
 elseif (mapa[i][j] == 1) then
 love.graphics.setColor(0,255,0)
 elseif (mapa[i][j] == 2) then
 love.graphics.setColor(0,0,255)
 elseif (mapa[i][j] == 3) then
 love.graphics.setColor(255,255,0)
 elseif (mapa[i][j] == 4) then
 love.graphics.setColor(255,255,255)
 elseif (mapa[i][j] == 5) then
 love.graphics.setColor(0,0,0)
 elseif (mapa[i][j] == 6) then
 love.graphics.setColor(255,0,255)
 end
 love.graphics.rectangle("fill", (i * 30)-20, (j * 30)-30, 30, 30)
 love.graphics.circle("fill", (i * 30)-20, (j * 30)-30, 30, 30)
 end
 end
end