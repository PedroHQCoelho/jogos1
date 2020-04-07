local mapa = {}
local tilesetImage
local tileQuads = {}
local tileSize = 64

function LoadTiles(filename, nx, ny)
  tilesetImage = love.graphics.newImage(filename)
  local count = 1
  for i = 0, nx, 1 do
    for j = 0, ny, 1 do
      tileQuads[count] = love.graphics.newQuad(i * tileSize , j * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())


      count = count + 1
    end
  end
end

function LoadMap(filename) 
  local file = io.open(filename) 
  local i = 1 for line in file:lines() do mapa[i] = {} for j=1, #line, 1 do 
    mapa[i][j] = line:sub(j,j) 
  end 
  i = i + 1 
end 
file:close() 
end 

function love.load() 
  love.window.setTitle("Mapa Mais Bonito")
  LoadMap("plataform_map.txt") 
  LoadTiles("plataform_tileset.png", 2, 2) 
  love.graphics.setBackgroundColor(152,209,250) 
  end
  
function love.draw()
  for i=1, 10, 1 do --Percorre a matriz e desenha quadrados imagens
    for j=1, 14, 1 do
      if (mapa[i][j] == "G") then love.graphics.draw(tilesetImage, tileQuads[1], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
      elseif (mapa[i][j] == "T") then love.graphics.draw(tilesetImage, tileQuads[4], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
      elseif (mapa[i][j] == "A") then love.graphics.draw(tilesetImage, tileQuads[7], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
      elseif (mapa[i][j] == "P") then love.graphics.draw(tilesetImage, tileQuads[8], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
      elseif (mapa[i][j] == "B") then love.graphics.draw(tilesetImage, tileQuads[6], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
      end
    end
  end
end