local vetor_px = {}

function love.load()
  love.window.setTitle("VIROU PASSEIO")
 love.graphics.setColor(255, 255, 255)
 love.graphics.setBackgroundColor(255, 255, 255)
 khedira = love.graphics.newImage("samikhedira.png")
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
love.graphics.draw(khedira)
 for y = 1, 20, 1 do
   love.graphics.setFont(adidas)
 love.graphics.print("VIROU PASSEIO", vetor_px[y], y * 30)
end
  end