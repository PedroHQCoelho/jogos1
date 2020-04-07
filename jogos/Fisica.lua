
function Collision(player,mapa,dt)
    return mapa[math.floor((player:getY()-player:getVelocity_py() * dt)/96)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/96)+1+(player:getMapaParte()*mapa1:getDeltaX())];
end

function ColisaoInimigo(player,inimigo1,dt)
  if CheckY(player,inimigo1,player:getVelocity_py()) and player:getMapaParte()==inimigo1:getMapaParte() and player:getMapa()==inimigo1:getMapa()  and inimigo1:getHp()>0 then
    player:setHp(player:getHp() - 250*dt);
    player:moveX(200*dt)
    player:setMovimento(3);
    player:setVelocity_py(player:getJumpHeight()); 
  end 
end

function transicao(player,mapa1,dt)
  if(player:getX()>love.graphics.getWidth() and mapa1:qtdInimigo(player:getMapaParte()+1)==0) and mapa1:getTotalPartes() >= player:getMapaParte() + 2 then
   player:setMapaParte(player:getMapaParte() + 1)
   mapa1:setCameraX(mapa1:getCameraX()+ mapa1:getDeltaX())
   mapa1:setLimiteX(mapa1:getLimiteX()+ mapa1:getDeltaX())
   player:setX(30)
  elseif (player:getX()>love.graphics.getWidth() and mapa1:qtdInimigo(player:getMapaParte()+1)==0) and mapa1:getTotalPartes() < (player:getMapaParte() +2) then
   mapa1:setCameraX(1)
   mapa1:setLimiteX(mapa1:getDeltaX())
   player:setX(30)
   player:setMapa(player:getMapa()+1);
   player:setMapaParte(0) 
  elseif player:getMapaParte()~=0 and player:getX()<0 then
    mapa1:setCameraX(mapa1:getCameraX()- mapa1:getDeltaX())
    mapa1:setLimiteX(mapa1:getLimiteX()- mapa1:getDeltaX())
    player:setX(love.graphics.getWidth() - 30)
    player:setMapaParte(player:getMapaParte()- 1)
  end
  if(player:getHp()<=0) then
      player:setX(200);
      player:setY(100);
      mapa1:setCameraX(1)
      mapa1:setLimiteX(mapa1:getDeltaX())
      player:setMapaParte(0);
      player:setHp(100);
    end
  end


function fisica(player,mapa1,dt,mapa)
  if player:getVelocity_py() ~= 0 and (mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2+player:getVelocity_py() * dt)/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX())]=="X" or mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2+player:getVelocity_py() * dt)/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX()
)]=="A" ) and player:getMovimento()==3 then
    player:setVelocity_py(player:getVelocity_py() - player:getGravity()*dt)
    player:moveY(player:getVelocity_py() * dt)  
    if player:getY() > love.graphics.getHeight() - 20 then
      player:setHp(0);
      player:setX(200);
      player:setY(100);
      mapa1:setCameraX(1)
      mapa1:setLimiteX(mapa1:getDeltaX())
      player:setMapaParte(0)
      player:setHp(100);
    end
  elseif player:getVelocity_py() ~= 0 and player:getMovimento()==3 then
    player:setVelocity_py(player:getVelocity_py() - player:getGravity()*dt)
  elseif player:getMovimento()~=3 and player:getVelocity_py() ~= 0 and (Collision(player,mapa,dt)=="X" or Collision(player,mapa,dt) =="A") then
    player:setVelocity_py(player:getJumpHeight());
    player:moveY(math.floor(-player:getVelocity_py() * dt));
    if player:getY() > love.graphics.getHeight() - 20 then
      player:setHp(0);
      player:setX(200);
      player:setY(100);
      mapa1:setCameraX(1)
      mapa1:setLimiteX(mapa1:getDeltaX())
      player:setMapaParte(0)
      player:setHp(100);
    end
  end
  
  
  if mapa[math.floor((player:getY())/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX())]=="S" then
    player:setHp(player:getHp() - 250*dt);
    player:moveX(200*dt)
    player:setMovimento(3);
    player:setVelocity_py(player:getJumpHeight()); 
  end

  if mapa[math.floor((player:getY())/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX())]~="X"  and mapa[math.floor((player:getY())/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX())]~="A"then
    if player:getY()> (math.floor((player:getY())/mapa1:getTileSize()))*mapa1:getTileSize()  then   
      player:setY((math.floor((player:getY())/mapa1:getTileSize()))*mapa1:getTileSize());
      player:setVelocity_py(player:getJumpHeight());     
      if(player:getMovimento()==3) then
        player:setAnimFrame(3,1);
        player:setMovimento(1);
      end
    end
  end
end

function fisicaIA(player,mapa1,dt,mapa)
  if player:getHp() > 0 then
    if player:getVelocity_py() ~= 0 and (mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2+player:getVelocity_py() * dt)/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX())]=="X" or mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2+player:getVelocity_py() * dt)/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)/mapa1:getTileSize())+1+(player:getMapaParte()*mapa1:getDeltaX()
  )]=="A" ) and player:getMovimento()==3 then
      player:setVelocity_py(player:getVelocity_py() - player:getGravity()*dt)
      player:moveY(player:getVelocity_py() * dt)  
      if player:getY() > love.graphics.getHeight() - 20 then
        player:setHp(0);
      end
    elseif player:getVelocity_py() ~= 0 and player:getMovimento()==3 then
      player:setVelocity_py(player:getVelocity_py() - player:getGravity()*dt)
    elseif player:getMovimento()~=3 and player:getVelocity_py() ~= 0 and (Collision(player,mapa,dt)=="X" or Collision(player,mapa,dt) =="A") then
      player:setVelocity_py(player:getJumpHeight());
      player:moveY(math.floor(-player:getVelocity_py() * dt));
      if player:getY() > love.graphics.getHeight() - 20 then
        player:setHp(0);
      end
    end
    
  end
end

