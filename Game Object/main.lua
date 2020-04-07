require "GameObject"

function love.load()
  player1 = GameObject:new(390, 300, 50, 50)
  box1 = GameObject:new(100, 300, 50, 50)
  box2 = GameObject:new(650, 275, 100, 100)
  love.window.setFullscreen()
  love.window.setTitle("O que o Botafogo não tem")
end

function CheckBoxCollision(obj1, obj2)
  return obj1:GetX() < obj2:GetX()+obj2:GetWidth() and obj2:GetX() < obj1:GetX()+obj1:GetWidth() and 
  obj1:GetY() < obj2:GetY()+obj2:GetHeight() and obj2:GetY() < obj1:GetY()+obj1:GetHeight()
end

function love.update(dt)
  if love.keyboard.isDown("left") then
    player1:MoveX(-120 * dt)
end

  if love.keyboard.isDown("right") then
    player1:MoveX(120 * dt)
end

  if love.keyboard.isDown("up") then
    player1:MoveY(-120 * dt)
end

  if love.keyboard.isDown("down") then
    player1:MoveY(120 * dt)
end

  if CheckBoxCollision(player1, box1) or
     CheckBoxCollision(player1, box2) then
    player1:SetCollided(true)
  else
    player1:SetCollided(false)
  end
end

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", box1:GetX(), box1:GetY(), box1:GetWidth(), box1:GetHeight())
  love.graphics.rectangle("fill", box2:GetX(), box2:GetY(), box2:GetWidth(), box2:GetHeight())
  
  if player1:IsCollided() == true then
    love.graphics.setColor(255,0,0)
end

  love.graphics.rectangle("fill", player1:GetX(), player1:GetY(), player1:GetWidth(), player1:GetHeight())
end