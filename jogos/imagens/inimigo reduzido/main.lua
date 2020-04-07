function love.load()
  love.graphics.setBackgroundColor (255, 255, 255)
  inimigo = love.graphics.newImage ("Attack_000.png")
end

function love.draw()
  love.graphics.draw(inimigo, 400, 300)
  end