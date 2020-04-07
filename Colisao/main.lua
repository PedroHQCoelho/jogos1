function love.load()
  love.window.setTitle("Colisão")
player1 = {
x = 390,
y = 300,
width = 50,
height = 50,
collided = false
}
box1 = {
x = 100,
y = 300,
width = 50,
height = 50
}
box2 = {
x = 650,
y = 275,
width = 100,
height = 100
}
end

function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end
function love.update(dt)
if love.keyboard.isDown("left") then
  if not CheckBoxCollision(player1.x - (120 * dt), player1.y, player1.width,
player1.height, box1.x, box1.y, box1.width, box1.height) and not
CheckBoxCollision(player1.x - (120 * dt), player1.y, player1.width,
player1.height, box2.x, box2.y, box2.width, box2.height) then 
player1.x = player1.x - (120 * dt)
end
end

if love.keyboard.isDown("right") then
if not CheckBoxCollision(player1.x + (120 * dt), player1.y, player1.width,
player1.height, box1.x, box1.y, box1.width, box1.height) and not
CheckBoxCollision(player1.x + (120 * dt), player1.y, player1.width,
player1.height, box2.x, box2.y, box2.width, box2.height) then 
player1.x = player1.x + (120 * dt)
end
end

if love.keyboard.isDown("up") then
  if not CheckBoxCollision(player1.x, player1.y - (120 * dt), player1.width,
player1.height, box1.x, box1.y, box1.width, box1.height) and not
CheckBoxCollision(player1.x, player1.y - (120 * dt), player1.width,
player1.height, box2.x, box2.y, box2.width, box2.height) then 
player1.y = player1.y - (120 * dt)
end
end

if love.keyboard.isDown("down") then
  if not CheckBoxCollision(player1.x, player1.y + (120 * dt), player1.width,
player1.height, box1.x, box1.y, box1.width, box1.height) and not
CheckBoxCollision(player1.x, player1.y + (120 * dt), player1.width,
player1.height, box2.x, box2.y, box2.width, box2.height) then 
player1.y = player1.y + (120 * dt)
end
end

if CheckBoxCollision(player1.x, player1.y, player1.width,
player1.height, box1.x, box1.y, box1.width, box1.height) or
CheckBoxCollision(player1.x, player1.y, player1.width,
player1.height, box2.x, box2.y, box2.width, box2.height) then
player1.collided = true
else
player1.collided = false
end
end

function love.draw()
love.graphics.setColor(255,255,255)
love.graphics.rectangle("fill", box1.x, box1.y,
box1.width, box1.height)
love.graphics.rectangle("fill", box2.x, box2.y,
box2.width, box2.height)
if player1.collided == true then
love.graphics.setColor(255,0,0)
end
love.graphics.rectangle("fill", player1.x, player1.y,
player1.width, player1.height)
end