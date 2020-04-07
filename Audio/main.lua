local icon_1up
local icon_super
local audio_1up
local audio_super

function love.load()
  icon_1up = love.graphics.newImage("1up.png")
  icon_super = love.graphics.newImage("super.png")
  audio_1up = love.audio.newSource("1up.mp3", "static")
  audio_super = love.audio.newSource("super.mp3")
end

function CheckClick(x1,y1,w1,h1,x2,y2)
  return x1 < x2+1 and x2 < x1+w1 and y1 < y2+1 and y2 < y1+h1
end

function love.draw()
  love.graphics.draw(icon_1up, 100, 200)
  love.graphics.draw(icon_super, 550, 200)
end

function love.mousepressed(x, y, button)
  if button == "l" then
    if CheckClick(550,200,128,128,x,y) then love.audio.play(audio_super)
      end
    if CheckClick(100,200,128,128,x,y) then love.audio.play(audio_1up)
      end
  elseif button == "r" then
    if CheckClick(550,200,128,128,x,y) then love.audio.stop(audio_super)
      end
    if CheckClick(100,200,128,128,x,y) then
    love.audio.stop(audio_1up)
    end
  end
end