local loader = require("AdvTiledLoader.Loader")

player = {
  charQuads = {},
  charImage = love.graphics.newImage("Imagens/char.png"),
  frame = 1,
  frametime = 0,
  xws = 0,
  yws = 0,
  xs = 0,
  ys = 0,
  x = 51,
  y = 28,
  speed = 4,
  dir = "down"
}

function LoadCharacter()
  local count = 1  
  for j = 0, 3, 1 do
    for i = 0, 2, 1 do
      player.charQuads[count]=love.graphics.newQuad(i * 40, j * 40, 40, 40, player.charImage:getWidth(),player.charImage:getHeight())
      count = count + 1
    end
  end
end

function love.load()
  loader.path = "Mapas/"
  map = loader.load("mapa01.tmx")
  tileLayer = map.layers["Colisao"]
  map.useSpriteBatch = true
  LoadCharacter()  
end

local function round(r,b)
   if b < 0 then
      return math.floor(r)
   elseif b > 0 then
      return math.ceil(r)
   else
      return math.floor(r+0.5)
   end
end

function animate(dir, dt)
  if dir == "up" then          
    player.frametime = player.frametime + dt
    if player.frametime > 0.1 then      
      player.frame = player.frame + 1       
      player.frametime = 0
    end    
    if player.frame > 12 or player.frame < 10 then
      player.frame = 10
    end    
  elseif dir == "down" then        
    player.frametime = player.frametime + dt
    if player.frametime > 0.1 then      
      player.frame = player.frame + 1
      player.frametime = 0
    end    
    if player.frame > 3 then
      player.frame = 1
    end    
  elseif dir == "left" then   
    player.frametime = player.frametime + dt
    if player.frametime > 0.1 then      
      player.frame = player.frame + 1
      player.frametime = 0
    end   
    if player.frame > 6 or player.frame < 4 then
      player.frame = 4
    end
  elseif dir == "right" then   
    player.frametime = player.frametime + dt
    if player.frametime > 0.1 then      
      player.frame = player.frame + 1
      player.frametime = 0
    end
    if player.frame > 9 or player.frame < 7 then
      player.frame = 7
    end
  end
end

function changemap(door, x, y)
  if door == 1 then
    map = loader.load("house01.tmx")
    tileLayer = map.layers["Colisao"]
    player.x = x
    player.y = y   
  elseif door == 2 then
    map = loader.load("mapa01.tmx")
    tileLayer = map.layers["Colisao"]
    player.x = x
    player.y = y   
  end
end

function move(dir, dt)  
  if dir == "down" then
    local tile = tileLayer(math.ceil(player.x)-1, math.ceil(player.y))   
    if tile == nil then
      return 
    end
    if tile.properties.obstacle then 
      return 
    end    
    changemap(tile.properties.door, tile.properties.doorx, tile.properties.doory)    
    player.yws = player.yws + player.speed
  elseif dir == "up" then
    local tile = tileLayer(math.floor(player.x)-1, math.floor(player.y) - 2)    
    if tile == nil then
      return 
    end
    if tile.properties.obstacle then 
      return 
    end    
    changemap(tile.properties.door, tile.properties.doorx, tile.properties.doory)    
    player.yws = player.yws - player.speed
  elseif dir == "left" then
    local tile = tileLayer(math.floor(player.x) - 2, math.floor(player.y)-1)    
    if tile == nil then
      return 
    end
    if tile.properties.obstacle then 
      return 
    end
    player.xws = player.xws - player.speed
  elseif dir == "right" then
    local tile = tileLayer(math.ceil(player.x), math.ceil(player.y)-1)    
    if tile == nil then
      return 
    end
    if tile.properties.obstacle then 
      return 
    end
    player.xws = player.xws + player.speed
  end  
  animate(dir, dt)  
  player.dir = dir  
end

function love.update(dt)
  player.xws,player.yws = 0,0
  if love.keyboard.isDown("up") and player.xs == 0 and player.ys == 0 then 
    move("up", dt)     
  elseif love.keyboard.isDown("down") and player.xs == 0 and player.ys == 0 then 
    move("down", dt)     
  elseif love.keyboard.isDown("left") and player.xs == 0 and player.ys == 0 then 
    move("left", dt)     
  elseif love.keyboard.isDown("right") and player.xs == 0 and player.ys == 0 then 
    move("right", dt)     
  end     
    
  if player.yws ~= 0 and player.xs == 0 then
    player.ys = player.yws
  elseif player.ys ~= 0 then
    animate(player.dir, dt) 
    if round(player.y,player.ys) ~= round(player.y + player.ys * dt,player.ys) then
      player.ys = 0
      player.y = round(player.y,player.ys)
    end
  end
  if player.xws ~= 0 and player.ys == 0 then
    player.xs = player.xws
  elseif player.xs ~= 0 then
    animate(player.dir, dt) 
    if round(player.x,player.xs) ~= round(player.x + player.xs * dt,player.xs) then
      player.xs = 0
      player.x = round(player.x,player.xs)
    end
  end
   
  player.x = player.x + player.xs * dt
  player.y = player.y + player.ys * dt
    
end

function love.draw()   
    local ftx, fty = (-player.x*32)+(love.window.getWidth()/2) + 20, (-player.y*32)+(love.window.getHeight()/2) + 20
    love.graphics.push()
    love.graphics.translate(ftx, fty)   
    map:autoDrawRange(ftx, fty, 1, 1)     
    map:draw()
    love.graphics.pop()
    love.graphics.draw(player.charImage, player.charQuads[player.frame], 
                      (love.window.getWidth()/2), (love.window.getHeight()/2), 0, 1, 1, 20, 20)
 end