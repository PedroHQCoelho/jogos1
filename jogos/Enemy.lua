require "Movimentacao"
require "Tiro"

function Atirar(inimigo1,x,dt)
    if inimigo1:getAnimFrame(inimigo1:getMovimento())==x then
      inimigo1:setTiro(1);
    end
end

function desenhaTiros(inimigo1)
  if inimigo1:getQtdTiros()~=0 then
    for i = 1, inimigo1:getQtdTiros(),1 do
      love.graphics.circle("fill",inimigo1:Vettiro(i):getX(),inimigo1:Vettiro(i):getY(),inimigo1:Vettiro(i):getRaio(),100);
    end
  end
end

function CheckChao(inimigo1,mapa,mapa1,dt)
  if inimigo1:getDirection()==1 then
    return mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+2][math.floor((inimigo1:getX()-((inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())/4))+100*dt)/mapa1:getTileSize())+1+inimigo1:getMapaParte()*mapa1:getDeltaX()];
  else
    return mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+2][math.floor(((inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX()))/1.5)-100*dt)/mapa1:getTileSize())+1+(inimigo1:getMapaParte()*mapa1:getDeltaX())];
  end
end


function CheckTiro(inimigo1,player,dt)
  if inimigo1:getQtdTiros()~=0 then
    for i = 1, inimigo1:getQtdTiros(),1 do
      if inimigo1:Vettiro(i):getDirection()==1 then
        if boss:Vettiro(i):getX()+boss:Vettiro(i):getRaio() > player:getX()-(player:getWidth(player:getMovimento(),0.2))/1.5 and boss:Vettiro(i):getY()< player:getY() and boss:Vettiro(i):getX()-boss:Vettiro(i):getRaio() < player:getX()-(player:getWidth(player:getMovimento(),0.2))/2 then
          player:setHp(player:getHp() - boss:Vettiro(i):getDano())
          inimigo1:removeTiro(i);
          break;
        end
      else
        if boss:Vettiro(i):getX()-boss:Vettiro(i):getRaio() < player:getX()-(player:getWidth(player:getMovimento(),0.2))/2 and boss:Vettiro(i):getY()< player:getY() and boss:Vettiro(i):getX()+boss:Vettiro(i):getRaio() > player:getX()-(player:getWidth(player:getMovimento(),0.2))/1.5  then
          player:setHp(player:getHp() - boss:Vettiro(i):getDano())
          inimigo1:removeTiro(i);
          break;
        end
      end
    end
  end
end

function moveTiros(inimigo1,dt)
  if inimigo1:getQtdTiros()~=0 then
    for i = 1, inimigo1:getQtdTiros(),1 do
      if inimigo1:Vettiro(i):getDirection()==1 then
        inimigo1:Vettiro(i):moveX(80*dt);
        love.graphics.circle("fill",inimigo1:Vettiro(i):getX(),inimigo1:Vettiro(i):getY(),inimigo1:Vettiro(i):getRaio(),100);
        if inimigo1:Vettiro(i):getX()>love.graphics.getWidth() then
          inimigo1:removeTiro(i);
          break;
        end
      else
        inimigo1:Vettiro(i):moveX(-80*dt);
        love.graphics.circle("fill",inimigo1:Vettiro(i):getX(),inimigo1:Vettiro(i):getY(),inimigo1:Vettiro(i):getRaio(),100);
        if inimigo1:Vettiro(i):getX()< 20 then
          inimigo1:removeTiro(i);
          break;
        end
      end
    end
  end
end

  
function atirando(inimigo1,dt)
  if inimigo1:getTiro()==1 then
    if inimigo1:getDirection() == 1 then
      tiro = Tiro:new(inimigo1:getX(),inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())/2),inimigo1:getDano(),5,1);
      inimigo1:adcTiro(tiro);
      inimigo1:setTiro(0);
    else
      tiro = Tiro:new(inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())),inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())/2),inimigo1:getDano(),5,2);
      inimigo1:adcTiro(tiro);
      inimigo1:setTiro(0);
    end
  end
end


function Comportamento1(player,inimigo1,mapa1,mapa,dt,exclamation_sound)
  if inimigo1:getX()<800 and inimigo1:getDirection() == 1 and inimigo1:getAtck()==0 then
    if  mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor((inimigo1:getX()-((inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())/4))+100*dt)/mapa1:getTileSize())+1+inimigo1:getMapaParte()*mapa1:getDeltaX()] == "X" and (CheckChao(inimigo1,mapa,mapa1,dt)== "G" or CheckChao(inimigo1,mapa,mapa1,dt)== "E"  or CheckChao(inimigo1,mapa,mapa1,dt)== "M" or CheckChao(inimigo1,mapa,mapa1,dt)== "D") then
    inimigo1:setMovimento(2)
    inimigo1:moveX(100*dt)
    Animation(inimigo1,dt,0)
      if inimigo1:getX() + 100> player:getX()- player:getWidth(player:getMovimento(),0.2)/2 and inimigo1:getX()< player:getX()- player:getWidth(player:getMovimento(),0.2) and inimigo1:getAtck()==0 then
        inimigo1:setExclamation(1);
        love.audio.play(exclamation_sound)
        inimigo1:setAtck(1);
        inimigo1:setDirection(1) 
      end
      if inimigo1:getX()>800 and inimigo1:getAtck() ==0 then
        inimigo1:setDirection(2)
      end
    else
      inimigo1:setDirection(2);
    end
  elseif inimigo1:getDirection()==2 and inimigo1:getX()>400 and inimigo1:getAtck()==0 then
    if mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor(((inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX()))/1.5)-100*dt)/mapa1:getTileSize())+1+(inimigo1:getMapaParte()*mapa1:getDeltaX())]=="X" and (CheckChao(inimigo1,mapa,mapa1,dt)== "G" or CheckChao(inimigo1,mapa,mapa1,dt)== "E"  or CheckChao(inimigo1,mapa,mapa1,dt)== "M" or CheckChao(inimigo1,mapa,mapa1,dt)== "D") then
    inimigo1:moveX(-100*dt)
    Animation(inimigo1,dt,0)
      if inimigo1:getX()-100 -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) < player:getX()and inimigo1:getX() > player:getX()- player:getWidth(player:getMovimento(),0.2) and inimigo1:getAtck()==0 then     
        love.audio.play(exclamation_sound)
        inimigo1:setExclamation(1);
        inimigo1:setAtck(1);
        inimigo1:setDirection(2)
      end
      if inimigo1:getX()<400 and inimigo1:getAtck()==0 then
        inimigo1:setDirection(1)
      end
    else
      inimigo1:setDirection(1);
    end
  elseif inimigo1:getAtck() == 1 then
    if CheckAnim(inimigo1,player) and player:getY() > inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))then
      inimigo1:setMovimento(4);
      Animation(inimigo1,dt,0);
      if inimigo1:getAnimFrame(inimigo1:getMovimento())==inimigo1:getTamVet(inimigo1:getMovimento()) then
        player:setHp(player:getHp() - 100*dt)
        if player:getHp() <=0 then
          inimigo1:setAtck(2);
          inimigo1:setMovimento(2);
        end
      end
    elseif inimigo1:getDirection()==2 and inimigo1:getX() + 100 > player:getX()- player:getWidth(player:getMovimento(),0.2)and inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) < player:getX()- player:getWidth(player:getMovimento(),0.2) then
        inimigo1:setAtck(1);
        inimigo1:setDirection(1)
    elseif inimigo1:getDirection()==1 and inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX()))-100 < player:getX()  and inimigo1:getX() > player:getX() then
        inimigo1:setAtck(1);
        inimigo1:setDirection(2)
    elseif inimigo1:getDirection()==1 and (inimigo1:getX() < player:getX()- player:getWidth(player:getMovimento(),0.2)/2 or not CheckAnim(inimigo1,player))then
      inimigo1:setAtck(1);
      inimigo1:setMovimento(2)
      inimigo1:moveX(100*dt)
      Animation(inimigo1,dt,0)
    elseif inimigo1:getDirection()==2 and (inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) > player:getX() or not CheckAnim(inimigo1,player)) then
      inimigo1:setAtck(1);
      inimigo1:setMovimento(2)
      inimigo1:moveX(-100*dt)
      Animation(inimigo1,dt,0)
    end
  elseif inimigo1:getAtck()==2 then
    if inimigo1:getX() < 400 then
      inimigo1:setDirection(1);
      inimigo1:moveX(100*dt);
      Animation(inimigo1,dt,0);
      if inimigo1:getX() >= 400 then
        inimigo1:setAtck(0);
      end
    elseif inimigo1:getX() > 800 then
      inimigo1:setDirection(2);
      inimigo1:moveX(-100*dt);
      Animation(inimigo1,dt,0);
      if inimigo1:getX() <= 800 then
        inimigo1:setAtck(0);
      end
    else
      inimigo1:setAtck(0);
    end
  end
end

function Comportamento2(player,inimigo1,dt,mapa,mapa1,exclamation_sound)
  inimigo1:setTiro_time(inimigo1:getTiro_time() + dt)
  if inimigo1:getX()<800 and inimigo1:getDirection() == 1 and inimigo1:getAtck()==0 then
    if  mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor((inimigo1:getX()-((inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())/4))+100*dt)/mapa1:getTileSize())+1+inimigo1:getMapaParte()*mapa1:getDeltaX()] == "X" and (CheckChao(inimigo1,mapa,mapa1,dt)== "G" or CheckChao(inimigo1,mapa,mapa1,dt)== "E"  or CheckChao(inimigo1,mapa,mapa1,dt)== "M" or CheckChao(inimigo1,mapa,mapa1,dt)== "D") then
      inimigo1:setMovimento(2)
      inimigo1:moveX(100*dt)
      Animation(inimigo1,dt,0)
      if inimigo1:getX() + 200> player:getX()- player:getWidth(player:getMovimento(),0.2)/2 and inimigo1:getX()< player:getX()- player:getWidth(player:getMovimento(),0.2) and inimigo1:getAtck()==0 then
        love.audio.play(exclamation_sound)
        inimigo1:setExclamation(1);
        inimigo1:setAtck(1);
        inimigo1:setDirection(1) 
      end
      if inimigo1:getX()>800 and inimigo1:getAtck() ==0 then
        inimigo1:setDirection(2)
      end
    else
      inimigo1:setDirection(2);
    end
  elseif inimigo1:getDirection()==2 and inimigo1:getX()>400 and inimigo1:getAtck()==0 then
    if mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+1][math.floor(((inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX()))/1.5)-100*dt)/mapa1:getTileSize())+1+(inimigo1:getMapaParte()*mapa1:getDeltaX())]=="X" and (CheckChao(inimigo1,mapa,mapa1,dt)== "G" or CheckChao(inimigo1,mapa,mapa1,dt)== "E"  or CheckChao(inimigo1,mapa,mapa1,dt)== "M" or CheckChao(inimigo1,mapa,mapa1,dt)== "D") then
      inimigo1:moveX(-100*dt)
      Animation(inimigo1,dt,0)
      if inimigo1:getX()-200 -(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) < player:getX()and inimigo1:getX() > player:getX()- player:getWidth(player:getMovimento(),0.2) and inimigo1:getAtck()==0 then
        love.audio.play(exclamation_sound)
        inimigo1:setExclamation(1);
        inimigo1:setAtck(1);
        inimigo1:setDirection(2)
      end
      if inimigo1:getX()<400 and inimigo1:getAtck()==0 then
        inimigo1:setDirection(1)
      end
    else
      inimigo1:setDirection(1);
    end
  elseif inimigo1:getAtck() == 1 then
      if inimigo1:getDirection()==1 and player:getX()- (player:getWidth(player:getMovimento(),0.2)/1.5) < inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())) then
        inimigo1:setDirection(2);
        inimigo1:setTiro_time(0)
        if(inimigo1:getMovimento()==5) then
          inimigo1:setAnimFrame(5,1);
        end
      elseif inimigo1:getDirection()==2 and player:getX()- (player:getWidth(player:getMovimento(),0.2)/3) > inimigo1:getX() then
        inimigo1:setDirection(1);
        inimigo1:setTiro_time(0)
        if(inimigo1:getMovimento()==5) then
          inimigo1:setAnimFrame(5,1);
        end
      elseif inimigo1:getTiro_time() > 0.15 then
        Atirar(inimigo1,2,dt);
        atirando(inimigo1,dt);
        inimigo1:setTiro_time(0)
      elseif player:getHp() < 0 then 
        inimigo1:setAtck(2);
      end
      inimigo1:setMovimento(5);
      AnimationDemorada(inimigo1,dt,0);
      
  elseif inimigo1:getAtck()==2 then
    if inimigo1:getX() < 400 then
      inimigo1:setDirection(1);
      inimigo1:moveX(100*dt);
      Animation(inimigo1,dt,0);
      if inimigo1:getX() >= 400 then
        inimigo1:setAtck(0);
      end
    elseif inimigo1:getX() > 800 then
      inimigo1:setDirection(2);
      inimigo1:moveX(-100*dt);
      Animation(inimigo1,dt,0);
      if inimigo1:getX() <= 800 then
        inimigo1:setAtck(0);
      end
    else
      inimigo1:setAtck(0);
    end
  end
end