Inimigo = {}

function Inimigo:new(x,y,m,mp,sx,sy,c)
  local obj = {px=x,
               py=y,
               atck=0,
               drop = 1 ,--math.random(1,10),
               movimento = 2,-- 1 = parado , 2 = andar,3 = pulo,4= espadada/atk melee,5=tiro
               walk = {},
               idle = {},
               slash = {},
               kick = {},
               jump = {},
               morte = {},
               velocity_py = 0,
               jump_height = -350,
               gravity = -500,
               anim_frame = {1,1,1,1,1},-- frame parado,frame andando,pulo,espada,soco
               anim_time = 0,
               tiro_time = 0,
               hp = 100,
               dano = 30,
               mapa_parte = mp,
               mapa = m,
               scalex = sx,
               scaley = sy,
               tiro = 0,
               qtd_tiros =0,
               comportamento = c,
               tiros = {},
               delay = 0,
               direction = 1,
               exclamation_tempo = 0,
               exclamation = 0, 
               collided = false}
  setmetatable(obj,self)
  self.__index = self
  return obj;
end

function Inimigo:moveX(x)
  self.px = self.px + x
end

function Inimigo:moveY(y)
  self.py = self.py + y
end


function Inimigo:getX()
  return self.px;
end

function Inimigo:getY()
  return self.py;
end

function Inimigo:setX(x)
  self.px = x;
end

function Inimigo:setY(y)
  self.py = y;
end

function Inimigo:getMovimento()
  return self.movimento;
end

function Inimigo:setMovimento(m)
  self.movimento = m;
end

function Inimigo:getWalk(i)
  return self.walk[self.direction][i];
end

function Inimigo:getKick(i)
  return self.kick[self.direction][i];
end

function Inimigo:getIdle(i)
  return self.idle[self.direction][i];
end

function Inimigo:getSlash(i)
  return self.slash[self.direction][i];
end

function Inimigo:getJump(i)
  return self.jump[self.direction][i];
end

function Inimigo:getMorte(i)
  return self.morte[self.direction][i];
end

function Inimigo:setWalk(x,d)
  if table.getn(self.walk) == 0 then
    self.walk[1] = {} --direita
    self.walk[2] = {} --esquerda
  end
  table.insert(self.walk[d],x);
end

function Inimigo:setKick(x,d)
  if table.getn(self.kick) == 0 then
    self.kick[1] = {} --direita
    self.kick[2] = {} --esquerda
  end
  table.insert(self.kick[d],x);
end

function Inimigo:setIdle(x,d)
  if table.getn(self.idle) == 0 then
    self.idle[1] = {} --direita
    self.idle[2] = {} --esquerda
  end
  table.insert(self.idle[d],x);
end

function Inimigo:setSlash(x,d)
  if table.getn(self.slash) == 0 then
    self.slash[1] = {} --direita
    self.slash[2] = {} --esquerda
  end
  table.insert(self.slash[d],x);
end

function Inimigo:setJump(x,d)
  if table.getn(self.jump) == 0 then
    self.jump[1] = {} --direita
    self.jump[2] = {} --esquerda
  end
  table.insert(self.jump[d],x);
end

function Inimigo:setMorte(x,d)
  if table.getn(self.morte) == 0 then
    self.morte[1] = {} --direita
    self.morte[2] = {} --esquerda
  end
  table.insert(self.morte[d],x);
end

function Inimigo:getVelocity_py()
  return self.velocity_py;
end

function Inimigo:setVelocity_py(y)
  self.velocity_py = y;
end

function Inimigo:getJumpHeight()
  return self.jump_height;
end

function Inimigo:setJumpHeight(h)
  self.jump_height = h;
end

function Inimigo:setGravity(g)
  self.gravity = g;
end

function Inimigo:getGravity()
  return self.gravity;
end

function Inimigo:getAnim_time()
  return self.anim_time;
end

function Inimigo:setAnim_time(x)
  self.anim_time = x
end

function Inimigo:getTiro_time()
  return self.tiro_time;
end

function Inimigo:setTiro_time(x)
  self.tiro_time = x
end

function Inimigo:setHp(h)
  if h >100 then
    self.hp = 100;
  else
    self.hp = h;
  end
end

function Inimigo:getHp()
  return self.hp;
end

function Inimigo:setDano(x)
  self.dano = x;
end

function Inimigo:getDano()
  return self.dano;
end


function Inimigo:isCollided()
  return self.collided;
end

function Inimigo:setCollided(x)
  self.collided = x;
end

function Inimigo:getTamVet(m)
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

function Inimigo:getAnim(m)
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

function Inimigo:getAnimFrame(m)
  return self.anim_frame[m];
end

function Inimigo:setAnimFrame(m,x)
  self.anim_frame[m] = x;
end

function Inimigo:getDirection()
  return self.direction;
end

function Inimigo:setDirection(d)
  self.direction = d;
end

function Inimigo:getHeight(m,x)
   local anim = self:getAnim(m):getHeight()*x;
   return anim;
 end
 
function Inimigo:getWidth(m,x)
  local anim = self:getAnim(m):getWidth()*x;
  return anim;
end
 
function Inimigo:setMapaParte(mp)
  self.mapa_parte = mp;
end
  
function Inimigo:getMapaParte()
  return self.mapa_parte;
end

function Inimigo:getMapa()
  return self.mapa;
end

function Inimigo:setMapa(m)
  self.mapa = m;
end

function Inimigo:getAtck()
  return self.atck;
end

function Inimigo:setAtck(x)
  self.atck = x;
end

function Inimigo:getDrop()
  return self.drop;
end

function Inimigo:setDrop(x)
  self.drop = x;
end

function Inimigo:getScaleX()
  return self.scalex;
end

function Inimigo:setScaleX(sx)
  self.scalex = sx;
end 

function Inimigo:getScaleY()
  return self.scaley;
end

function Inimigo:setScaleY(sy)
  self.scalex = sy;
end 
  
function Inimigo:setTiro(x)
  self.tiro = x;
end
function Inimigo:getTiro(x)
  return self.tiro;
end

function Inimigo:setExclamation(x)
  self.exclamation = x;
end
function Inimigo:getExclamation()
  return self.exclamation;
end

function Inimigo:setExclamationTemp(x)
  self.exclamation_tempo = x;
end
function Inimigo:getExclamationTemp()
  return self.exclamation_tempo;
end

function Inimigo:adcTiro(x)
  self.qtd_tiros =  self.qtd_tiros +1;
  table.insert(self.tiros,x);
end

function Inimigo:removeTiro(i)
  if self.qtd_tiros ~=0 then
    self.qtd_tiros =  self.qtd_tiros - 1;
    table.remove(self.tiros,i);
  end
end

function Inimigo:getQtdTiros()
  return self.qtd_tiros;
end

function Inimigo:removeTodosTiros()
    if self.qtd_tiros ~=0 then
      for i = self.qtd_tiros,1,-1 do
        self.qtd_tiros =  self.qtd_tiros - 1;
        table.remove(self.tiros,i);
      end
    end
  end

function Inimigo:setQtdTiros(x)
  self.qtd_tiros = x;
end

function Inimigo:Vettiro(i)
  if i ~=0 then
    return self.tiros[i];
  end
end

function Inimigo:getComportamento()
  return self.comportamento;
end

function Inimigo:setComportamento(x)
  self.comportamento = x;
end

function Inimigo:getDelay()
  return self.delay;
end

function Inimigo:setDelay(x)
  self.delay = x;
end

