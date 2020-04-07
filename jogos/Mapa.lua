Mapa = {}

function Mapa:new(f,img,tsize,i,sx,sy)
  local obj = {filename =f,
               imagem = img,
               mapa_parte = 0,
               width = love.graphics.getWidth()/tsize,
               height =  love.graphics.getHeight()/tsize, --limite_y
               qtd_inimigos = {},
               inimigos={},
               camera_x = 1,
               camera_y = 1,
               item={},
               qtd_item={},
               total_partes,
               deltax = love.graphics.getWidth()/tsize,
               limite_x = love.graphics.getWidth()/tsize,
               tilesize = tsize,
               scalex = sx,
               scaley = sy,
               ind = i}
  setmetatable(obj,self)
  self.__index = self
  return obj;
end

function Mapa:LoadMap(mapa)
  local file = io.open(self.filename)
  local i = 1
  local x = 0
  for line in file:lines() do
    mapa[i] = {}
    for j=1,#line,1 do
      mapa[i][j] = line:sub(j,j)
      if(i==1)then
        x = x +1;
      end
    end
    i = i+1
  end
  self.total_partes = math.ceil(x/self.deltax)
  for k = 1,self.total_partes,1 do
      self.item[k] = {};
      self.qtd_item[k] = 0;
      self.qtd_inimigos[k] = 0;
      self.inimigos[k] = {};
    end
  file:close()
end

function Mapa:getImagem()
  return self.imagem;
end

function Mapa:setMapaParte(x)
  self.mapa_parte = x;
end

function Mapa:getMapaParte()
  return self.mapa_parte;
end

function Mapa:setWidth(x)
  self.width = x;
end

function Mapa:getWidth()
  return self.width;
end

function Mapa:setHeight(x)
  self.height = x;
end

function Mapa:getHeight()
  return self.height;
end
               
function Mapa:setCameraX(x)
  self.camera_x = x;
end

function Mapa:getCameraX()
  return self.camera_x;
end

function Mapa:setCameraY(x)
  self.camera_y = x;
end

function Mapa:getCameraY()
  return self.camera_y;
end

function Mapa:adcInimigo(mp,x)
  self.qtd_inimigos[mp] = self.qtd_inimigos[mp] + 1;
  table.insert(self.inimigos[mp],x);
end

function Mapa:VetInimigo(mp,i)
  if table.getn(self.inimigos[mp]) ~=0 then
    return self.inimigos[mp][i];
  end
end

function Mapa:removeInimigo(mp,x)
  if self.qtd_inimigos[mp] ~=0 then
    table.remove(self.inimigos[mp],x);
    self.qtd_inimigos[mp] = self.qtd_inimigos[mp] - 1;
  end
end

function Mapa:qtdInimigo(mp)
  return self.qtd_inimigos[mp];
end

function Mapa:getLimiteX()
  return self.limite_x;
end

function Mapa:getDeltaX()
  return self.deltax;
end

function Mapa:setLimiteX(x)
  self.limite_x = x;
end

function Mapa:getInd()
  return self.ind;
end

function Mapa:getScaleX()
  return self.scalex;
end

function Mapa:setScaleX(sx)
  self.scalex = sx;
end 

function Mapa:getScaleY()
  return self.scaley;
end

function Mapa:setScaleY(sy)
  self.scalex = sy;
end 

function Mapa:getTotalPartes()
  return self.total_partes;
end

function Mapa:getTileSize()
  return self.tilesize;
end

function Mapa:adcItem(mp,x)
  self.qtd_item[mp] = self.qtd_item[mp] + 1;
  table.insert(self.item[mp],x);
end

function Mapa:qtdItem(mp)
  return self.qtd_item[mp];
end

function Mapa:removeItem(mp,x)
  if self.qtd_item[mp] ~=0 then
    table.remove(self.item[mp],x);
    self.qtd_item[mp] = self.qtd_item[mp] - 1;
  end
end

function Mapa:VetItem(mp,i)
  if table.getn(self.item[mp]) ~=0 then
    return self.item[mp][i];
  end
end