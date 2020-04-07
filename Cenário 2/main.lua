local mapa = {}
local grama
local pedra
local mapa_pos = 0  

function LoadMap (filename)
  local file = io.open (filename)
  local i = 1
  for line in file:lines() do
    mapa[i] = {}
    for j=1, #line, 1 do
      mapa[i][j] = line:sub(j,j)
    end
    i = i + 1
  end
  file:close()
end

function love.load()
  love.window.setTitle("Cenário 2")
  LoadMap("Mapa01.txt")
  love.graphics.setBackgroundColor(152, 209, 250)
  grama = love.graphics.newImage ("grass.png")
  pedra = love.graphics.newImage ("stone.png")
end

function love.update(dt)
 if love.keyboard.isDown("right") then
   mapa_pos = mapa_pos + (200 * dt)
   if mapa_pos >= 1576 then
     mapa_pos = 1576
     end
 end
 if love.keyboard.isDown("left") then
   mapa_pos = mapa_pos - (200 * dt)
   if mapa_pos <= 24 then
     mapa_pos = 0
     end
   end
  end

function love.draw ()
  for i=1, 25, 1 do
    for j=1, 100, 1 do
    if (mapa[i][j] == "G") then
love.graphics.draw(grama, (j * 24) - mapa_pos - 24, (i* 24) - 24)
elseif (mapa[i][j] == "T") then
love.graphics.draw(pedra, (j * 24) - mapa_pos - 24, (i* 24) - 24)
end
end
end
end