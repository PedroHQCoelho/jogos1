local vetor_px = {}

function love.load()
  love.window.setTitle("Eu Só Queria Dar Alegria Ao Meu Povo")
 love.graphics.setColor(255, 255, 255)
 love.graphics.setBackgroundColor(255, 255, 255)
 davirgem = love.graphics.newImage("euescolhiesperar.png")
  adidas = love.graphics.newFont("Adidas 2014 font.otf", 60) 
 for y = 1, 20, 1 do
   vetor_px[y] = love.math.random(0, 800)
end
end

function love.update(dt)
 for y = 1, 20, 1 do
   vetor_px[y] = vetor_px[y] + (100 * dt)
   if vetor_px[y] > love.graphics.getWidth() then
     vetor_px[y] = 0
   end
   end
 end

function love.draw()
love.graphics.draw(davirgem)
 for y = 1, 20, 1 do
   love.graphics.setFont(adidas)
 love.graphics.print("7X1 FOI POUCO", vetor_px[y], y * 30)
end
  end