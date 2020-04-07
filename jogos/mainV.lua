require "Hero"
local mapa = {}
local fase
local hero_chao = 440
local tempo = 0;
local chao;
local spike;
local acido;
local camera_x= 1;
local camera_y= 1;
local limite_x;
local plataforma = {};
local vida;
local qtd_vidas = 1;
local mapa_parte = 0;
local deltax;
local altura;
local atck = 0;
local teste =0 ;
local teste2=0;
local teste3 =0;

function LoadMap(filename)
  local file = io.open(filename)
  local i =1
  for line in file:lines() do
    mapa[i] = {}
    for j=1,#line,1 do
      mapa[i][j] = line:sub(j,j)
    end
    i = i+1
  end
  file:close()
end

function Collision(player,dt)
    return mapa[math.floor((player:getY()-player:getVelocity_py() * dt)/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)];
  end

function love.load()
    love.window.setMode(896, 640)
    love.window.setTitle("Cyber Venger")
    player = Hero:new(200,100,50)
    inimigo1 = Hero:new(400,390,50);
    player:setVelocity_py(player:getJumpHeight());
    inimigo1:setVelocity_py(player:getJumpHeight());
    fase = love.graphics.newImage("imagens/city.jpg")
    LoadMap("mapa.txt")
    for i=0,15,1 do
      if i < 10 then
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/Walk_00"..i..".png"),1)
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/WalkL_00"..i..".png"),2)
        inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/Attack_00"..i..".png"),1)
        inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/AttackL_00"..i..".png"),2)
      else
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/Walk_0"..i..".png"),1)
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/WalkL_0"..i..".png"),2)
      end
    end
    for i=1,11,1 do
      player:setJump(love.graphics.newImage("imagens/hero/jump_"..i..".png"),1);
      player:setJump(love.graphics.newImage("imagens/hero/jumpL_"..i..".png"),2);
    end
    for i=1,8,1 do
      player:setWalk(love.graphics.newImage("imagens/hero/run"..i..".png"),1);
      player:setWalk(love.graphics.newImage("imagens/hero/run_Left"..i..".png"),2);
    end
    for i=1,6,1 do
      player:setIdle(love.graphics.newImage("imagens/hero/idle"..i..".png"),1);
      player:setIdle(love.graphics.newImage("imagens/hero/idleL"..i..".png"),2);
      player:setSlash(love.graphics.newImage("imagens/hero/upslash"..i..".png"),1);
      player:setSlash(love.graphics.newImage("imagens/hero/upslashL"..i..".png"),2);
      player:setKick(love.graphics.newImage("imagens/hero/kick"..i..".png"),1);
      player:setKick(love.graphics.newImage("imagens/hero/kickL"..i..".png"),2);
    end
    acido = love.graphics.newImage("imagens/Acid.png");
    spike = love.graphics.newImage("imagens/Spike.png");
    vida = love.graphics.newImage("imagens/vida.png");
    for i=1,4,1 do
      inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/Attack_0"..(i+9)..".png"),1)
      inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/AttackL_0"..(i+9)..".png"),2)
      plataforma[i] = love.graphics.newImage("imagens/Tile_1"..(i+1)..".png");
    end
    chao = love.graphics.newImage("imagens/Tile_2.png");
    limite_x = love.graphics.getWidth()/128
    deltax = limite_x;
end
function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   elseif key == "z" then
     player:setMovimento(5)
   elseif key == "x" then
     player:setMovimento(4)
  elseif key == "space" then
     player:setMovimento(3)
   end
end

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


function love.update(dt)
  tempo = tempo + dt;
  
  if love.keyboard.isDown("right") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2)/128)+1][math.floor((player:getX()+200*dt)/128)+1+(mapa_parte*deltax)] =="X" then
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
  elseif love.keyboard.isDown("right") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2)/128)+1][math.floor((player:getX()+200*dt)/128)+1+(mapa_parte*deltax)] =="L" then
    player:setMovimento(2);
    player:moveX(200*dt);
    Animation(player,dt,0);
    if qtd_vidas>0 then
      player:setHp(player:getHp()+15);
      qtd_vidas = qtd_vidas - 1;
    end
  elseif love.keyboard.isDown("left") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2)/128)+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)-200*dt)/128)+1+(mapa_parte*deltax)]=="X" then
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
  elseif love.keyboard.isDown("left") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2)/128)+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)-200*dt)/128)+1+(mapa_parte*deltax)]=="L" then
    player:setMovimento(2);
    player:moveX(-200*dt);
    Animation(player,dt,0);
    if qtd_vidas>0 then
      player:setHp(player:getHp()+15);
      qtd_vidas = qtd_vidas - 1;
    end
  elseif player:getMovimento()==4 and player:getMovimento()~=3 then
    Animation(player,dt,1)
  elseif player:getMovimento()==5 and player:getMovimento()~=3 then
    Animation(player,dt,1)
  elseif player:getMovimento()==3 then
    if love.keyboard.isDown("right") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2)/128)+1][math.floor((player:getX()+200*dt)/128)+1+(mapa_parte*deltax)] =="X"then
        player:setDirection(1)
        player:setMovimento(3) 
        player:moveX(200*dt)
        Animation(player,dt,0)
    elseif love.keyboard.isDown("left") and mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2)/128)+1][math.floor(((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)-200*dt)/128)+1+(mapa_parte*deltax)] =="X" then
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
  ---inimigo
  if inimigo1:getX()<800 and inimigo1:getDirection() == 1 and atck==0 then
    inimigo1:setMovimento(2)
    inimigo1:moveX(100*dt)
    Animation(inimigo1,dt,0)
    if inimigo1:getX() + 50> player:getX()- player:getWidth(player:getMovimento(),0.2)and inimigo1:getX()< player:getX()- player:getWidth(player:getMovimento(),0.2) and atck==0 then
      atck = 1;
      teste = atck
      inimigo1:setDirection(1)
    end
    if inimigo1:getX()>800 and atck ==0 then
      inimigo1:setDirection(2)
    end
    
  elseif inimigo1:getDirection()==2 and inimigo1:getX()>400 and atck==0 then
    inimigo1:moveX(-100*dt)
    Animation(inimigo1,dt,0)
    if inimigo1:getX()-50 < player:getX()- player:getWidth(player:getMovimento(),0.2)and inimigo1:getX() > player:getX()- player:getWidth(player:getMovimento(),0.2) and atck==0 then
      atck = 1;
      teste2 = atck
      inimigo1:setDirection(2)
    end
    if inimigo1:getX()<400 and atck==0 then
      inimigo1:setDirection(1)
    end
  elseif atck == 1 then
    if math.abs((inimigo1:getX() + 50) - (player:getX()- player:getWidth(player:getMovimento(),0.2)))<=30 then
      inimigo1:setMovimento(4);
      Animation(inimigo1,dt,0);
    elseif math.abs((inimigo1:getX() - 50) - (player:getX()- player:getWidth(player:getMovimento(),0.2)))<=30 then
      inimigo1:setMovimento(4);
      Animation(inimigo1,dt,0);
    elseif inimigo1:getDirection()==1 and inimigo1:getX() + 50 <player:getX()- player:getWidth(player:getMovimento(),0.2) then
      atck =1
      inimigo1:setMovimento(2)
      inimigo1:moveX(100*dt)
      Animation(inimigo1,dt,0)
    elseif inimigo1:getDirection()==2 and inimigo1:getX() - 50 > player:getX()- player:getWidth(player:getMovimento(),0.2) then
      atck =1
      inimigo1:setMovimento(2)
      inimigo1:moveX(-100*dt)
      Animation(inimigo1,dt,0)
    elseif inimigo1:getDirection()==2 and inimigo1:getX() + 50 > player:getX()- player:getWidth(player:getMovimento(),0.2)and inimigo1:getX() < player:getX()- player:getWidth(player:getMovimento(),0.2) then
        atck =1
        inimigo1:setDirection(1)
    elseif inimigo1:getDirection()==1 and inimigo1:getX()-50 < player:getX()- player:getWidth(player:getMovimento(),0.2) and inimigo1:getX() > player:getX()- player:getWidth(player:getMovimento(),0.2) then
        atck =1
        inimigo1:setDirection(2)
    
    end
  end
  ---fim inimigo
  teste = Collision(player,dt);
  if player:getVelocity_py() ~= 0 and (mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2+player:getVelocity_py() * dt)/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)]=="X" or mapa[math.floor((player:getY()-(player:getHeight(player:getMovimento(),0.2))/2+player:getVelocity_py() * dt)/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)]=="A") and player:getMovimento()==3 then
    player:setVelocity_py(player:getVelocity_py() - player:getGravity()*dt)
    player:moveY(player:getVelocity_py() * dt)  
    if player:getY() > love.graphics.getHeight() - 20 then
      player:setHp(0);
      player:setX(200);
      player:setY(100);
      camera_y = 1
      limite_x = deltax
      mapa_parte = 0;
      player:setHp(100);
    end
  elseif player:getVelocity_py() ~= 0 and player:getMovimento()==3 then
    player:setVelocity_py(player:getVelocity_py() - player:getGravity()*dt)
  elseif player:getMovimento()~=3 and player:getVelocity_py() ~= 0 and (Collision(player,dt)=="X" or Collision(player,dt) =="A") then
    player:setVelocity_py(player:getJumpHeight());
    player:moveY(math.floor(-player:getVelocity_py() * dt));
    if player:getY() > love.graphics.getHeight() - 20 then
      player:setHp(0);
      player:setX(200);
      player:setY(100);
      camera_y = 1
      limite_x = deltax
      mapa_parte = 0;
      player:setHp(100);
    end
  end
  
  if mapa[math.floor((player:getY())/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)]=="S" then
    player:setHp(player:getHp() - 200*dt);
    player:setMovimento(3);
    player:moveY(player:getJumpHeight()*dt)
  end

  if mapa[math.floor((player:getY())/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)]~="X"  and mapa[math.floor((player:getY())/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)]~="A"then
    if player:getY()> (math.floor((player:getY())/128))*128  then   
      teste2 = teste2+1
      player:setY((math.floor((player:getY())/128))*128);
      player:setVelocity_py(player:getJumpHeight());     
      if(player:getMovimento()==3) then
        player:setAnimFrame(3,1);
        player:setMovimento(1);
      end
    end
  end
  
  if(player:getX()>love.graphics.getWidth())then
   camera_y = camera_y + deltax
   limite_x = limite_x + deltax
   player:setX(30)
   mapa_parte = mapa_parte + 1
  elseif mapa_parte~=0 and player:getX()<0 then
    camera_y = camera_y - deltax
    limite_x = limite_x - deltax
    player:setX(love.graphics.getWidth() - 30)
    mapa_parte = mapa_parte - 1;
  end
  
  if(player:getHp()<=0) then
    player:setX(200);
    player:setY(100);
    camera_y = 1
    limite_x = deltax
    mapa_parte = 0;
    player:setHp(100);
  end
end

function Desenha(player,m,r,sx,sy)
  love.graphics.draw(player:getAnim(m),player:getX(),player:getY(),r,sx,sy,player:getAnim(m):getWidth(),player:getAnim(m):getHeight());
end

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(fase,0,0,0,1.05,1.05)
  love.graphics.setLineWidth(2);
  love.graphics.setColor(255,255,255);
  love.graphics.rectangle("line",30,30,155,10);
  love.graphics.setColor(255,0,0)
  love.graphics.setLineWidth(6);
  love.graphics.line(31,35,1.53 * player:getHp() + 31,35);
  love.graphics.setColor(255,255,255);
  for i=camera_x,table.maxn(mapa),1 do
    for j=camera_y,limite_x,1 do
      if mapa[i][j]=="G" then
        love.graphics.draw(chao,(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      elseif mapa[i][j] =="M" then
        love.graphics.draw(plataforma[2],(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      elseif mapa[i][j] =="E" then
        love.graphics.draw(plataforma[1],(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      elseif mapa[i][j] =="D" then
        love.graphics.draw(plataforma[3],(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      elseif mapa[i][j] =="A" then
        love.graphics.draw(acido,(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      elseif mapa[i][j] =="S" then
        love.graphics.draw(spike,(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      elseif mapa[i][j]=="L" then
        if qtd_vidas>0 then
          love.graphics.draw(vida,(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
        end
      elseif mapa[i][j] =="H" then
        love.graphics.draw(plataforma[4],(j-camera_y)*128,(i-camera_x)*128,0,0.5,0.5)
      end
    end
  end
  
  local m = player:getMovimento();
  Desenha(player,m,0,0.2,0.2)
  if inimigo1:getHp()>0 and mapa_parte ==0 then
    love.graphics.draw(inimigo1:getAnim(inimigo1:getMovimento()),inimigo1:getX(),inimigo1:getY(),0,0.2,0.2,player:getAnim(inimigo1:getMovimento()):getWidth(),player:getAnim(inimigo1:getMovimento()):getHeight());
  end
  --Desenha(inimigo1,2,0,0.2,0.2)
  love.graphics.setColor(255,255,255)
  love.graphics.print(math.ceil(player:getHp()).."/100",100,30,0,0.8,0.8);
  love.graphics.print(teste,0,0)
  love.graphics.print(teste2,0,15)
  love.graphics.print(mapa[math.floor((player:getY())/128)+1][math.floor((player:getX()-(player:getWidth(player:getMovimento(),0.2))/2)/128)+1+(mapa_parte*deltax)],0,30)
  
end