function Animation(player,dt,bool)
  player:setAnim_time(player:getAnim_time() + dt)
  if player:getAnim_time() > 0.1  then
    player:setAnimFrame(player:getMovimento(),player:getAnimFrame(player:getMovimento())+1)
    if player:getAnimFrame(player:getMovimento()) > player:getTamVet(player:getMovimento()) then
      player:setAnimFrame(player:getMovimento(),1)
      if bool == 1 then --Alguns movimentos o personagem deve voltar para o idle
        player:setMovimento(1)
      end
    end
    player:setAnim_time(0)
  end
end
function AnimationDemorada(player,dt,bool)
  player:setAnim_time(player:getAnim_time() + dt)
  if player:getAnim_time() > 0.15  then
    player:setAnimFrame(player:getMovimento(),player:getAnimFrame(player:getMovimento())+1)
    if player:getAnimFrame(player:getMovimento()) > player:getTamVet(player:getMovimento()) then
      player:setAnimFrame(player:getMovimento(),1)
      if bool == 1 then --Alguns movimentos o personagem deve voltar para o idle
        player:setMovimento(1)
      end
    end
    player:setAnim_time(0)
  end
end


function CheckDirection(player,inimigo)
  if player:getDirection()==1 then 
    if inimigo:getX()-(inimigo:getWidth(inimigo:getMovimento(),inimigo:getScaleX())/2) > player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX())/2) then
      return true;
    else
      return false;
    end
  elseif player:getDirection()==2 then 
    if inimigo:getX()-(inimigo:getWidth(inimigo:getMovimento(),inimigo:getScaleX())/2) < player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX())/2) then
      return true;
    else
      return false;
    end
  end
end


function CheckPlace(player,inimigo)
  if player:getMapaParte()==inimigo:getMapaParte() and player:getMapa()==inimigo:getMapa() then
    return true;
  else
    return false;
  end
end

function CheckVida(item,player)
  if player:getDirection()==1 then
    if player:getX()- (player:getWidth(player:getMovimento(),player:getScaleX()))/1.5 > item:getX()+item:getImagem():getWidth()/2 and player:getX()- (player:getWidth(player:getMovimento(),player:getScaleX()))/2.8 < item:getX()+item:getImagem():getWidth()/2 and player:getY()>item:getY() then
      return true;
    else 
      return false;
    end
  elseif player:getDirection()==2 then
    if player:getX()- (player:getWidth(player:getMovimento(),player:getScaleX()))/1.5 < item:getX()+item:getImagem():getWidth()/2 and player:getX()- (player:getWidth(player:getMovimento(),player:getScaleX()))/2.8 > item:getX()+item:getImagem():getWidth()/2 and player:getY()>item:getY() then
      return true;
    else
      return false;
    end
  end
end


function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end



function MovCheck(player,inimigo1,vx)
  if CheckPlace(player,inimigo1) then
    if vx > 0 then
      if math.ceil(player:getX() -(player:getWidth(player:getMovimento(),player:getScaleX()))/2.8 +vx) > inimigo1:getX() -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) and math.ceil(player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2.2 +vx)  < inimigo1:getX() and player:getY() > inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())) then
        return true;
      else 
        return false;
      end
    elseif vx < 0 then
      if math.floor(player:getX() - (player:getWidth(player:getMovimento(),player:getScaleX()))/1.5 +vx) < inimigo1:getX()  and math.floor(player:getX() - (player:getWidth(player:getMovimento(),player:getScaleX()))/2 + vx) > inimigo1:getX() -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) and player:getY() > inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))  then
        return true;
      else
        return false;
      end
    end
  else
    return false;
  end
end

function CheckY(player,inimigo1,vy)
  if CheckPlace(player,inimigo1) then
    if vy > 0 then
      if player:getY() > inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())) and Check(player,inimigo1) then
        return true;
      else 
        return false;
      end
    else
      return false;
    end
  else
    return false;
  end
end

function CheckAnim(player,inimigo1)
  if CheckPlace(player,inimigo1) then
    if player:getDirection()==1 then
      if player:getX() > inimigo1:getX() -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())/2) and player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX())) < inimigo1:getX() then
        return true;
      else 
        return false;
      end
    elseif player:getDirection()==2 then
      if player:getX() - (player:getWidth(player:getMovimento(),player:getScaleX()))  < inimigo1:getX()  and player:getX()  > inimigo1:getX() -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())/2) then
        return true;
      else
        return false;
      end
    end
  else
    return false;
  end
end

function Check(player,inimigo1)
  if CheckPlace(player,inimigo1) then
    if player:getDirection()==1 then
      if math.ceil(player:getX() -(player:getWidth(player:getMovimento(),0.2))/1.5 + (player:getWidth(player:getMovimento(),player:getScaleX()))/2 ) > inimigo1:getX() -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) and math.ceil(player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/1.5)  < inimigo1:getX() then
        return true;
      else 
        return false;
      end
    elseif player:getDirection()==2 then
      if math.floor(player:getX() - (player:getWidth(player:getMovimento(),player:getScaleX()))/1.5 ) < inimigo1:getX()  and math.floor(player:getX() - (player:getWidth(player:getMovimento(),player:getScaleX()))/2) > inimigo1:getX() -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) then
        return true;
      else
        return false;
      end
    end
  else
    return false;
  end
end


function movimentacao(player,dt,mapa,mapa_parte,deltax,mapa1)
  if love.keyboard.isDown("right") then 
    player:setDirection(1)
    if mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor((player:getX()-((player:getWidth(player:getMovimento(),player:getScaleX())/4))+200*dt)/mapa1:getTileSize())+1+player:getMapaParte()*mapa1:getDeltaX()] =="X" then
        player:setDirection(1)
        if love.keyboard.isDown("space") or player:getMovimento()==3 then
          player:setMovimento(3) 
          player:moveX(200*dt)
          Animation(player,dt,0)
        else
          player:setMovimento(2) 
          player:moveX(200*dt)
          Animation(player,dt,0)
        end
      end
  elseif love.keyboard.isDown("left") then 
    player:setDirection(2)
    if mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/1.5)-200*dt)/mapa1:getTileSize())+1+(mapa_parte*deltax)]=="X" then
      player:setDirection(2)
      if love.keyboard.isDown("space") or player:getMovimento()==3 then
        player:setMovimento(3) 
        player:moveX(-200*dt)
        Animation(player,dt,0)
      else
        player:setMovimento(2)
        player:moveX(-200*dt)
        Animation(player,dt,0)
      end
    end
  elseif player:getMovimento()==4 and player:getMovimento()~=3 then
    Animation(player,dt,1)
  elseif player:getMovimento()==5 and player:getMovimento()~=3 then
    Animation(player,dt,1)
  elseif player:getMovimento()==3 then
    if love.keyboard.isDown("right") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor((player:getX()+200*dt)/mapa1:getTileSize())+1+(mapa_parte*deltax)] =="X" then
        player:setDirection(1)
        player:setMovimento(3) 
        player:moveX(200*dt)
        Animation(player,dt,0)
    elseif love.keyboard.isDown("left") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)-200*dt)/mapa1:getTileSize())+1+(mapa_parte*deltax)] =="X"  then
        player:setDirection(2)
        player:setMovimento(3) 
        player:moveX(-200*dt)
        Animation(player,dt,0)
    else
       player:setMovimento(3)
      Animation(player,dt,0)
    end
  elseif player:getMovimento()~=3 then
    player:setMovimento(1);
    Animation(player,dt,0)
  end
end

function movimentacaoInimigo(player,dt,mapa,mapa_parte,deltax,inimigo,mapa1)
  if love.keyboard.isDown("right") then 
    player:setDirection(1)
    if mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX())/4))/mapa1:getTileSize())+1+player:getMapaParte()*mapa1:getDeltaX()] =="X" and (not MovCheck(player,inimigo,200*dt) or inimigo:getHp()< 0) and (player:getX()+200*dt < love.graphics.getWidth() or mapa1:qtdInimigo(player:getMapaParte() + 1)==0 )then
        player:setDirection(1)
        if love.keyboard.isDown("space") or player:getMovimento()==3 then
          player:setMovimento(3) 
          player:moveX(200*dt)
          Animation(player,dt,0)
        else
          player:setMovimento(2) 
          player:moveX(200*dt)
          Animation(player,dt,0)
        end
    end
  elseif love.keyboard.isDown("left") then 
    player:setDirection(2)
    if mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/1.5)-200*dt)/mapa1:getTileSize())+1+(mapa_parte*deltax)]=="X" and (not MovCheck(player,inimigo,-200*dt) or inimigo:getHp()< 0) then
      player:setDirection(2)
      if love.keyboard.isDown("space") or player:getMovimento()==3 then
        player:setMovimento(3) 
        player:moveX(-200*dt)
        Animation(player,dt,0)
      else
        player:setMovimento(2)
        player:moveX(-200*dt)
        Animation(player,dt,0)
      end
    end
  elseif player:getMovimento()==4 and player:getMovimento()~=3 then
    Animation(player,dt,1)
    if CheckAnim(player,inimigo) and CheckDirection(player,inimigo) and inimigo:getHp()>0 then
      inimigo:setHp(inimigo:getHp() - player:getDano()*dt*2);
    end
  elseif player:getMovimento()==5 and player:getMovimento()~=3 then
    Animation(player,dt,1)
    if CheckAnim(player,inimigo) and CheckDirection(player,inimigo) and inimigo:getHp()>0 then
      inimigo:setHp(inimigo:getHp() - player:getDano()*dt*2);
      if player:getDirection()==1 then
        inimigo:moveX(350*dt);
      else
        inimigo:moveX(-350*dt);
      end
    end
  elseif player:getMovimento()==3 then
    if love.keyboard.isDown("right") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor((player:getX()+200*dt)/mapa1:getTileSize())+1+(mapa_parte*deltax)] =="X" and (not MovCheck(player,inimigo,200*dt) or inimigo:getHp()< 0)then
        player:setDirection(1)
        player:setMovimento(3) 
        player:moveX(200*dt)
        Animation(player,dt,0)
    elseif love.keyboard.isDown("left") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),player:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),player:getScaleX()))/2)-200*dt)/mapa1:getTileSize())+1+(mapa_parte*deltax)] =="X" and (not MovCheck(player,inimigo,200*dt) or inimigo:getHp()< 0) then
        player:setDirection(2)
        player:setMovimento(3) 
        player:moveX(-200*dt)
        Animation(player,dt,0)
    else
       player:setMovimento(3)
      Animation(player,dt,0)
    end
  elseif player:getMovimento()~=3 then
    player:setMovimento(1);
    Animation(player,dt,0)
  end
end

