local mapa = {}
local tile_grass
local tile_water
local tile_sand
function LoadMap(filename)
 local file = io.open(filename)
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
 LoadMap("Mapa.txt")
 tile_grass = love.graphics.newImage("grass.png")
 tile_water = love.graphics.newImage("water.png")
 tile_sand = love.graphics.newImage("sand.png")
end
function love.draw()
 for i=1, 10, 1 do
 for j=1, 14, 1 do
 if (mapa[i][j] == "P") then
 love.graphics.draw(tile_sand, (j * 50), (i * 50))
 elseif (mapa[i][j] == "G") then
 love.graphics.draw(tile_grass, (j * 50), (i * 50))
 elseif (mapa[i][j] == "A") then
 love.graphics.draw(tile_water, (j * 50), (i * 50))
   end
  end
  end
end