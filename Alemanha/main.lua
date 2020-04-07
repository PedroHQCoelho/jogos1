local vetor_px = {}

function love.load()
  love.window.setTitle("7X1 FOI POUCO")
 love.graphics.setColor(0, 0, 0)
 love.graphics.setBackgroundColor(255, 255, 255)
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
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", 0,0,800,200)
  love.graphics.setColor(221,0,0)
  love.graphics.rectangle("fill", 0,200,800,200)
  love.graphics.setColor(255,206,0)
  love.graphics.rectangle("fill", 0,400,800,200)
  
 for y = 1, 20, 1 do
 love.graphics.setFont(adidas)
 love.graphics.setColor(255,255,255)
 love.graphics.print("7X1 FOI POUCO", vetor_px[y], y * 30)
end
end