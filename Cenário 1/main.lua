function love.load()
  love.window.setTitle("Cenário 1")
    cano = love.graphics.newImage("cano.png")
    montanha = love.graphics.newImage("montanha.png")
    nuvem = love.graphics.newImage("nuvem.png")
    piso = love.graphics.newImage("piso.png")
    love.graphics.setBackgroundColor(153,209,251)
end

function love.draw()
  love.graphics.draw(nuvem, 200, 0)
  for i = 0, 6, 1 do
    love.graphics.draw(montanha, i * montanha:getWidth(), love.graphics.getHeight()-piso:getHeight() - montanha:getHeight())
end
love.graphics.draw(cano, 480, 400)
for i= 0, 6, 1 do
    love.graphics.draw(piso, i * piso:getWidth(), love.graphics.getHeight()-piso:getHeight())
  end
  end

