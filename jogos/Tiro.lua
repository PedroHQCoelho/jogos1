Tiro = {}

function Tiro:new(x,y,dmg,r,d)
  local obj = {px=x,
               py=y,
               dano = dmg,
               raio = r,
               direction = d,
               collided = false}
  setmetatable(obj,self)
  self.__index = self
  return obj;
end

function Tiro:moveX(x)
  self.px = self.px + x
end

function Tiro:moveY(y)
  self.py = self.py + y
end

function Tiro:getX()
  return self.px;
end

function Tiro:getY()
  return self.py;
end

function Tiro:setX(x)
  self.px = x;
end

function Tiro:setY(y)
  self.py = y;
end


function Tiro:setDano(x)
  self.dano = x;
end

function Tiro:getDano()
  return self.dano;
end

function Tiro:getDirection()
  return self.direction;
end

function Tiro:setDirection(x)
  self.direction = x;
end

function Tiro:isCollided()
  return self.collided;
end

function Tiro:setCollided(x)
  self.collided = x;
end

function Tiro:getHeight(m,x)
   local anim = self:getAnim(m):getHeight()*x;
   return anim;
 end
 
function Tiro:getWidth(m,x)
  local anim = self:getAnim(m):getWidth()*x;
  return anim;
end


function Tiro:getRaio()
  return self.raio;
end

function Tiro:setRaio(r)
  self.raio = r;
end 
  
