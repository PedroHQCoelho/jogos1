Hero = {}

function Hero:new(x,y,m,mp,sx,sy)
  local obj = {px=x,
               py=y,
               movimento = 2,-- 1 = parado , 2 = andar,3 = pulo,4= espada,5=chute
               walk = {},
               idle = {},
               slash = {},
               kick = {},
               jump = {},
               morte = {},
               velocity_py = 0,
               jump_height = -300,
               gravity = -500,
               anim_frame = {1,1,1,1,1},-- frame parado,frame andando,pulo,espada,soco
               anim_time = 0,
               hp = 100,
               dano = 30,
               mapa = m,
               mapa_parte = mp,
               scalex = sx,
               scaley = sy,
               direction = 1,
               collided = false}
  setmetatable(obj,self)
  self.__index = self
  return obj;
end

function Hero:moveX(x)
  self.px = self.px + x
end

function Hero:moveY(y)
  self.py = self.py + y
end


function Hero:getX()
  return self.px;
end

function Hero:getY()
  return self.py;
end

function Hero:setX(x)
  self.px = x;
end

function Hero:setY(y)
  self.py = y;
end

function Hero:getMovimento()
  return self.movimento;
end

function Hero:setMovimento(m)
  self.movimento = m;
end

function Hero:getWalk(i)
  return self.walk[self.direction][i];
end

function Hero:getKick(i)
  return self.kick[self.direction][i];
end

function Hero:getIdle(i)
  return self.idle[self.direction][i];
end

function Hero:getSlash(i)
  return self.slash[self.direction][i];
end

function Hero:getJump(i)
  return self.jump[self.direction][i];
end

function Hero:getMorte(i)
  return self.morte[self.direction][i];
end

function Hero:setWalk(x,d)
  if table.getn(self.walk) == 0 then
    self.walk[1] = {} --direita
    self.walk[2] = {} --esquerda
  end
  table.insert(self.walk[d],x);
end

function Hero:setKick(x,d)
  if table.getn(self.kick) == 0 then
    self.kick[1] = {} --direita
    self.kick[2] = {} --esquerda
  end
  table.insert(self.kick[d],x);
end

function Hero:setIdle(x,d)
  if table.getn(self.idle) == 0 then
    self.idle[1] = {} --direita
    self.idle[2] = {} --esquerda
  end
  table.insert(self.idle[d],x);
end

function Hero:setSlash(x,d)
  if table.getn(self.slash) == 0 then
    self.slash[1] = {} --direita
    self.slash[2] = {} --esquerda
  end
  table.insert(self.slash[d],x);
end

function Hero:setJump(x,d)
  if table.getn(self.jump) == 0 then
    self.jump[1] = {} --direita
    self.jump[2] = {} --esquerda
  end
  table.insert(self.jump[d],x);
end

function Hero:setMorte(x,d)
  if table.getn(self.morte) == 0 then
    self.morte[1] = {} --direita
    self.morte[2] = {} --esquerda
  end
  table.insert(self.morte[d],x);
end

function Hero:getVelocity_py()
  return self.velocity_py;
end

function Hero:setVelocity_py(y)
  self.velocity_py = y;
end

function Hero:getJumpHeight()
  return self.jump_height;
end

function Hero:setJumpHeight(h)
  self.jump_height = h;
end

function Hero:setGravity(g)
  self.gravity = g;
end

function Hero:getGravity()
  return self.gravity;
end

function Hero:getAnim_time()
  return self.anim_time;
end

function Hero:setAnim_time(x)
  self.anim_time = x
end

function Hero:setHp(h)
  if h >100 then
    self.hp = 100;
  else
    self.hp = h;
  end
end

function Hero:getHp()
  return self.hp;
end

function Hero:setDano(x)
  self.dano = x;
end

function Hero:getDano()
  return self.dano;
end

function Hero:isCollided()
  return self.collided;
end

function Hero:setCollided(x)
  self.collided = x;
end

function Hero:getTamVet(m)
  local tam;
  if m == 1 then
    tam = table.getn(self.idle[self.direction]);
  elseif m == 2 then
    tam = table.getn(self.walk[self.direction]);
  elseif m == 3 then
    tam = table.getn(self.jump[self.direction]);
  elseif m == 4 then
    tam = table.getn(self.slash[self.direction]);
  elseif m == 5 then
    tam = table.getn(self.kick[self.direction]);
  end
  
  return tam;
end

function Hero:getAnim(m)
  if m == 1 then
    return self.idle[self.direction][self.anim_frame[m]];
  elseif m == 2 then
    return self.walk[self.direction][self.anim_frame[m]];
  elseif m == 3 then
    return self.jump[self.direction][self.anim_frame[m]];
  elseif m == 4 then
    return self.slash[self.direction][self.anim_frame[m]];
  elseif m == 5 then
    return self.kick[self.direction][self.anim_frame[m]];
  end
  
end

function Hero:getAnimFrame(m)
  return self.anim_frame[m];
end

function Hero:setAnimFrame(m,x)
  self.anim_frame[m] = x;
end

function Hero:getDirection()
  return self.direction;
end

function Hero:setDirection(d)
  self.direction = d;
end

function Hero:getHeight(m,x)
   local anim = self:getAnim(m):getHeight()*x;
   return anim;
 end
 
 function Hero:getWidth(m,x)
  local anim = self:getAnim(m):getWidth()*x;
   return anim;
end
 
 function Hero:setMapaParte(mp)
   self.mapa_parte = mp;
 end
  
function Hero:getMapaParte()
  return self.mapa_parte;
end

function Hero:getMapa()
  return self.mapa;
end

function Hero:setMapa(m)
  self.mapa = m;
end

function Hero:getScaleX()
  return self.scalex;
end

function Hero:setScaleX(sx)
  self.scalex = sx;
end 

function Hero:getScaleY()
  return self.scaley;
end

function Hero:setScaleY(sy)
  self.scalex = sy;
end 
  