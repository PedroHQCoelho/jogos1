local mapa = {}
local tilesetImage
local tileQuads = {}
local tileSize = 64

local mapa_config = {
  mapaSize_x = 28,
  mapaSize_y = 10,
  mapaDisplay_x = 14,
  mapaDisplay_y = 10
}

local camera = {
  pos_x = 1,
  pos_y = 1,
  speed = 120
}

function LoadTiles(filename, nx, ny) 
  tilesetImage = love.graphics.newImage(filename) 
  local count = 1 
  for i = 0, nx, 1 do 
    for j = 0, ny, 1 do 
      tileQuads[count] = love.graphics.newQuad(i * tileSize, j * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight()) 
      
      count = count + 1 
    end 
  end 
end 

function LoadMap(filename) 
  local file = io.open(filename) 
  local i = 1 
  for line in file:lines() do 
    mapa[i] = {} for j=1, #line, 1 do 
      mapa[i][j] = line:sub(j,j) 
    end 
    i = i + 1 
  end 
  file:close() 
end
  
function love.load()
  love.window.setTitle("Mapa Bonito Com Câmera")
  LoadMap("plataform_map.txt")
  LoadTiles("plataform_tileset.png", 2, 2)
  love.graphics.setBackgroundColor(152,209,250)
end

function love.update(dt)
  if love.keyboard.isDown("right") then camera.pos_x = camera.pos_x + (camera.speed * dt)
  elseif love.keyboard.isDown("left") then camera.pos_x = camera.pos_x - (camera.speed * dt)
end

if camera.pos_x < 0 then
   camera.pos_x = 0
elseif camera.pos_x > mapa_config.mapaSize_x * tileSize - mapa_config.mapaDisplay_x * tileSize - 1 then
camera.pos_x = mapa_config.mapaSize_x * tileSize - mapa_config.mapaDisplay_x * tileSize - 1
  end
end

function love.draw()
    offset_x = math.floor(camera.pos_x % tileSize)
    first_tile_x = math.floor(camera.pos_x / tileSize)
    for y=1, mapa_config.mapaDisplay_y, 1 do
        for x=1, mapa_config.mapaDisplay_x, 1 do
          if (mapa[y][first_tile_x + x] == "G") then
            love.graphics.draw(tilesetImage, tileQuads[1], ((x -1)*tileSize) - offset_x ,((y-1)*tileSize))
          elseif (mapa[y][first_tile_x + x] == "T") then love.graphics.draw(tilesetImage, tileQuads[4], ((x-1)*tileSize) - offset_x ,((y-1)* tileSize))
          elseif (mapa[y][first_tile_x + x] == "A") then love.graphics.draw(tilesetImage, tileQuads[7], ((x-1)*tileSize) - offset_x ,((y-1)*tileSize))
          elseif (mapa[y][first_tile_x + x] == "P") then love.graphics.draw(tilesetImage, tileQuads[8], ((x-1)*tileSize) - offset_x ,((y-1)*tileSize))
        elseif (mapa[y][first_tile_x + x] == "B") then love.graphics.draw(tilesetImage, tileQuads[6],((x-1)*tileSize) - offset_x ,((y-1)*tileSize))
        end
      end
    end
end