Item = {}

function Item:new(x,y,mp,m,sx,sy,img)
  local obj = {px=x,
               py=y,
               mapa_parte = mp,
               mapa = m,
               imagem = img,
               scalex = sx,
               scaley = sy,
               direction = d,
               collided = false}
  setmetatable(obj,self)
  self.__index = self
  return obj;
end

function Item:getX()
  return self.px;
end

function Item:getY()
  return self.py;
end

function Item:setX(x)
  self.px = x;
end

function Item:setY(y)
  self.py = y;
end


function Item:isCollided()
  return self.collided;
end

function Item:setCollided(x)
  self.collided = x;
end

function Item:getScaleX()
  return self.scalex;
end

function Item:setScaleX(sx)
  self.scalex = sx;
end 

function Item:getScaleY()
  return self.scaley;
end

function Item:setScaleY(sy)
  self.scalex = sy;
end 

 function Item:setMapaParte(mp)
   self.mapa_parte = mp;
 end
  
function Item:getMapaParte()
  return self.mapa_parte;
end

function Item:getMapa()
  return self.mapa;
end

function Item:setMapa(m)
  self.mapa = m;
end

function Item:getImagem()
  return self.imagem;
end

