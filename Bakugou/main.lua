local roda
function love.load()
  love.window.setTitle("Bakugo")
  bakugou = love.graphics.newImage("bakugou.png")
roda = 0
end

function love.update(dt)
  roda = roda + (2 * dt)
end

function love.draw()
  love.graphics.rotate(roda)
  love.graphics.draw(bakugou, 400, 300,math.rad(0), 1, 1,
bakugou:getWidth()/2, bakugou:getHeight()/2)
  end