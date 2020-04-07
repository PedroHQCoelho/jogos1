local hero = { -- vetor de imagens
      walk = {},
      anim_frame = 1,
      pos_x = 100,
      pos_y = 225,
      anim_time = 0 -- variavel para controle do tempo da animação
    }
function love.load()
  wallacepx = 801
  wallacepy = 601
  wallace = love.graphics.newImage ("wallacemachado.png")
  love.window.setTitle("Herói")
  toasty = love.audio.newSource("Mortal Kombat Toasty [MIMP3].mp3")
  for x = 1, 16, 1 do
    hero.walk[x] = love.graphics.newImage("Hero_Walk_"..x..".png")
  end
end

function love.update(dt)
  
  if love.keyboard.isDown("w") then
    --wallacepx = wallacepx - (200*dt)
    --wallacepy = wallacepy - (200*dt)
    wallacepx = 700
    wallacepy = 480
    love.audio.play(toasty)
      hero.anim_time = hero.anim_time + dt
     if hero.anim_time > 1 then
     wallacepx = 801
     wallacepy = 601
     hero.anim_time = 0
     end
    end
  
  if love.keyboard.isDown("right") then
    if hero.anim_frame <=4 then
    hero.pos_x = hero.pos_x + (100 * dt)
    hero.anim_time = hero.anim_time + dt
    if hero.anim_time > 0.1 then
    hero.anim_frame = hero.anim_frame + 1
    if hero.anim_frame > 4 then
      hero.anim_frame = 1
    end
    hero.anim_time = 0
  end
  else
  hero.anim_frame = 1
end
end


  if love.keyboard.isDown("left") then
    if hero.anim_frame >=5 and hero.anim_frame <=8 then
    hero.pos_x = hero.pos_x - (100 * dt)
    hero.anim_time = hero.anim_time + dt
    if hero.anim_time > 0.1 then
    hero.anim_frame = hero.anim_frame + 1
    if hero.anim_frame > 8 then
      hero.anim_frame = 5
    end
    hero.anim_time = 0
  end
else
  hero.anim_frame = 5
end
end

  if love.keyboard.isDown("up") then
    if hero.anim_frame >=9 and hero.anim_frame <=12 then
    hero.pos_y = hero.pos_y - (100 * dt)
    hero.anim_time = hero.anim_time + dt
    if hero.anim_time > 0.1 then
    hero.anim_frame = hero.anim_frame + 1
    if hero.anim_frame > 12 then
      hero.anim_frame = 9
    end
    hero.anim_time = 0
  end
else
  hero.anim_frame = 9
end
end

  if love.keyboard.isDown("down") then
    if hero.anim_frame >=13 and hero.anim_frame <=16 then
    hero.pos_y = hero.pos_y + (100 * dt)
    hero.anim_time = hero.anim_time + dt
    if hero.anim_time > 0.1 then
    hero.anim_frame = hero.anim_frame + 1
    if hero.anim_frame > 16 then
      hero.anim_frame = 13
    end
    hero.anim_time = 0
  end
else
  hero.anim_frame = 13
end
end
end

function love.draw()
  love.graphics.draw(hero.walk[hero.anim_frame], hero.pos_x, hero.pos_y)
  love.graphics.draw(wallace, wallacepx, wallacepy)
  end