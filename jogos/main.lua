require "Hero"
require "Movimentacao"
require "Inimigo"
require "Enemy"
require "Mapa"
require "Fisica"
require "Tiro"
require "Item"
--vetor dos mapas para acessar a partir do mapa do player
local exclamation_sound;
local exclamation_img;
local fase_sound={};
local mapa_1 = {}
local mapa_2 = {}
local mapa_3 = {}
local mapas_txt = {}
local mapas = {}
local fase
local hero_chao = 440
local tempo = 0;
local chao;
local spike;
local pause = 0;
local tiro_anim;
local acido;
local camera_x= 1;
local camera_y= 1;
local limite_x;
local plataforma = {};
local vida;
local mapa_parte = 0;
local deltax;
local altura;
local teste =0 ;
local teste2=0;
local teste3 =1;
local teste4 = 0;
local colisao = 0;
local text="";


function Save(filename,player)
  file = io.open(filename, "w");
  file:write(player:getHp());
  file:close();
end



function love.load()
    love.window.setMode(864, 672)
    love.window.setTitle("Cyber Venger")
    player = Hero:new(100,100,1,0,0.18,0.18)
    inimigo1 = Inimigo:new(600,400,1,0,0.4,0.4,1);
    inimigo2 = Inimigo:new(550,500,1,1,0.4,0.4,1);
    boss = Inimigo:new(700,400,1,0,0.4,0.4,2);
    drone1 = Inimigo:new(700,400,1,0,0.4,0.4,2);--nao aplicar fisica
    drone2 = Inimigo:new(700,400,1,0,0.4,0.4,2);-- criar comportamento 3
    player:setVelocity_py(player:getJumpHeight());
    inimigo1:setVelocity_py(player:getJumpHeight());
    inimigo2:setVelocity_py(player:getJumpHeight());
    boss:setVelocity_py(player:getJumpHeight());
    mapa1 = Mapa:new("mapa.txt",love.graphics.newImage("imagens/city.jpg"),96,1,1.1,1.1);
    mapa2 = Mapa:new("mapa2.txt",love.graphics.newImage("imagens/fase2.jpg"),96,2,0.5,0.5);
    mapa3 = Mapa:new("mapa3.txt",love.graphics.newImage("imagens/fase3.png"),96,3,1,1);
    mapa1:LoadMap(mapa_1);
    mapa2:LoadMap(mapa_2);
    mapa3:LoadMap(mapa_3);
    table.insert(mapas,mapa1);
    table.insert(mapas,mapa2);
    table.insert(mapas,mapa3);
    table.insert(mapas_txt,mapa_1);
    table.insert(mapas_txt,mapa_2);
    table.insert(mapas_txt,mapa_3);
--    mapa1:adcInimigo(inimigo1:getMapaParte()+1,inimigo1);
--    mapa1:adcInimigo(inimigo2:getMapaParte()+1,inimigo2);
    --mapa1:adcInimigo(boss:getMapaParte()+1,boss);
    exclamation_sound = love.audio.newSource("sons/Metal Gear Solid - Exclamation Point Sound Effect.mp3", "static")
    
    exclamation_img = love.graphics.newImage("imagens/exclamation.png");
    for i=0,15,1 do
      if i < 10 then
        drone1:setIdle(love.graphics.newImage("imagens/Drone/Drone Idle_00"..i..".png"),1);
        drone1:setIdle(love.graphics.newImage("imagens/Drone/Drone IdleL_00"..i..".png"),2);
        drone1:setKick(love.graphics.newImage("imagens/Drone/Drone Shoot_00"..i..".png"),1);
        drone1:setKick(love.graphics.newImage("imagens/Drone/Drone ShootL_00"..i..".png"),2);
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/Walk_00"..i..".png"),1)
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/WalkL_00"..i..".png"),2)
        inimigo2:setWalk(love.graphics.newImage("imagens/dagger/Walk_00"..i..".png"),1)
        inimigo2:setWalk(love.graphics.newImage("imagens/dagger/WalkL_00"..i..".png"),2)
        boss:setWalk(love.graphics.newImage("imagens/boss/Run_00"..i..".png"),1)
        boss:setWalk(love.graphics.newImage("imagens/boss/RunL_00"..i..".png"),2)
        boss:setKick(love.graphics.newImage("imagens/boss/Shoot_00"..i..".png"),1);
        boss:setKick(love.graphics.newImage("imagens/boss/ShootL_00"..i..".png"),2);
        inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/Attack_00"..i..".png"),1)
        inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/AttackL_00"..i..".png"),2)
        inimigo2:setSlash(love.graphics.newImage("imagens/dagger/Attack_00"..i..".png"),1)
        inimigo2:setSlash(love.graphics.newImage("imagens/dagger/AttackL_00"..i..".png"),2)
      else
        drone1:setKick(love.graphics.newImage("imagens/Drone/Drone Shoot_0"..i..".png"),1);
        drone1:setKick(love.graphics.newImage("imagens/Drone/Drone ShootL_0"..i..".png"),2);
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/Walk_0"..i..".png"),1)
        inimigo1:setWalk(love.graphics.newImage("imagens/inimigo/WalkL_0"..i..".png"),2)
        inimigo2:setWalk(love.graphics.newImage("imagens/dagger/Walk_0"..i..".png"),1)
        inimigo2:setWalk(love.graphics.newImage("imagens/dagger/WalkL_0"..i..".png"),2)
        boss:setKick(love.graphics.newImage("imagens/boss/Shoot_0"..i..".png"),1);
        boss:setKick(love.graphics.newImage("imagens/boss/ShootL_0"..i..".png"),2);
      end
    end
    for i=1,11,1 do
      player:setJump(love.graphics.newImage("imagens/hero/jump_"..i..".png"),1);
      player:setJump(love.graphics.newImage("imagens/hero/jumpL_"..i..".png"),2);
    end
    for i=1,8,1 do
      boss:setSlash(love.graphics.newImage("imagens/boss/Knockback_00"..(i-1)..".png"),1)
      boss:setSlash(love.graphics.newImage("imagens/boss/KnockbackL_00"..(i-1)..".png"),2)
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
      if i < 4 then
        fase_sound[i] = love.audio.newSource("sons/Fase"..i..".mp3")
      end
      if i < 3 then
        drone1:setIdle(love.graphics.newImage("imagens/Drone/Drone Idle_0"..(i+9)..".png"),1);
        drone1:setIdle(love.graphics.newImage("imagens/Drone/Drone IdleL_0"..(i+9)..".png"),2);
      end
      inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/Attack_0"..(i+9)..".png"),1)
      inimigo1:setSlash(love.graphics.newImage("imagens/inimigo/AttackL_0"..(i+9)..".png"),2)
      inimigo2:setSlash(love.graphics.newImage("imagens/dagger/Attack_0"..(i+9)..".png"),1)
      inimigo2:setSlash(love.graphics.newImage("imagens/dagger/AttackL_0"..(i+9)..".png"),2)
      boss:setWalk(love.graphics.newImage("imagens/boss/Run_0"..(i+9)..".png"),1)
      boss:setWalk(love.graphics.newImage("imagens/boss/RunL_0"..(i+9)..".png"),2)
      plataforma[i] = love.graphics.newImage("imagens/Tile_1"..(i+1)..".png");
    end
    chao = love.graphics.newImage("imagens/Tile_2.png");
    tiro_anim = love.graphics.newImage("imagens/tiro.png");
  
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
  elseif key == "p" then
    if pause==0 then
      pause = 1;
    else
      pause = 0;
    end
  elseif key == "s" then
    Save("teste.txt",player);
--  else
--    text = text .. key
  end
end

function jogo(player,mapa1,mapa,dt)
  if mapa1:qtdInimigo(player:getMapaParte()+1)~=0 then
      for i = 1,mapa1:qtdInimigo(player:getMapaParte()+1),1 do
        movimentacaoInimigo(player,dt,mapa,player:getMapaParte(),mapa1:getDeltaX(),mapa1:VetInimigo(player:getMapaParte()+1,i),mapa1)
        if mapa1:VetInimigo(player:getMapaParte()+1,i):getHp() > 0 and CheckPlace(player,mapa1:VetInimigo(player:getMapaParte()+1,i)) then
          if mapa1:VetInimigo(player:getMapaParte()+1,i):getComportamento() ==1 then
            Comportamento1(player,mapa1:VetInimigo(player:getMapaParte()+1,i),mapa1,mapa,dt,exclamation_sound);
          else
            Comportamento2(player,mapa1:VetInimigo(player:getMapaParte()+1,i),dt,mapa,mapa1,exclamation_sound);
            moveTiros(mapa1:VetInimigo(player:getMapaParte()+1,i),dt);
            CheckTiro(mapa1:VetInimigo(player:getMapaParte()+1,i),player,dt);
          end
          fisicaIA(mapa1:VetInimigo(player:getMapaParte()+1,i),mapa1,dt,mapa);
          ColisaoInimigo(player,mapa1:VetInimigo(player:getMapaParte()+1,i),dt);
        elseif mapa1:VetInimigo(player:getMapaParte()+1,i):getHp() <=0 then 
          mapa1:VetInimigo(player:getMapaParte()+1,i):removeTodosTiros();
          if mapa1:VetInimigo(player:getMapaParte()+1,i):getDrop()==1 then
            local x = mapa1:VetInimigo(player:getMapaParte()+1,i);
            item = Item:new(x:getX()-x:getWidth(x:getMovimento(),x:getScaleX())/2,x:getY()-x:getHeight(x:getMovimento(),x:getScaleY())/2,x:getMapaParte(),x:getMapa(),0.4,0.4,vida);
            mapa1:adcItem(player:getMapaParte()+1,item);
          end
          mapa1:removeInimigo(player:getMapaParte()+1,i);
          i = i-1;
        end
      end
    else
       movimentacao(player,dt,mapa,player:getMapaParte(),mapa1:getDeltaX(),mapa1)
    end
    fisica(player,mapa1,dt,mapa);
    transicao(player,mapa1,dt);
  end


function love.update(dt)
  if pause==0 then
    tempo = tempo + dt;
    love.audio.play(fase_sound[player:getMapa()]);
    jogo(player,mapas[player:getMapa()],mapas_txt[player:getMapa()],dt)
    if player:getMapa()~=1 then
      love.audio.stop(fase_sound[player:getMapa()-1]);
    end
  else
    love.audio.pause(fase_sound[player:getMapa()]);
  end
end

function Desenha(player,m,r,sx,sy)
  love.graphics.draw(player:getAnim(m),player:getX(),player:getY(),r,sx,sy,player:getAnim(m):getWidth(),player:getAnim(m):getHeight());
end

function DesenhaInimigo(inimigo1,player,exclamation_img)
  if inimigo1:getHp()>0 and CheckPlace(player,inimigo1) then
    Desenha(inimigo1,inimigo1:getMovimento(),0,inimigo1:getScaleX(),inimigo1:getScaleY())
    if(inimigo1:getExclamation()==1) then
        love.graphics.draw(exclamation_img,inimigo1:getX()-inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())/2,inimigo1:getY()-(boss:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())),0,0.5,0.5,exclamation_img:getWidth(),exclamation_img:getHeight());
        if inimigo1:getExclamationTemp() == 20 then
          inimigo1:setExclamation(0);
          inimigo1:setExclamationTemp(0);
        else
          inimigo1:setExclamationTemp(inimigo1:getExclamationTemp()+1);
        end
      end 
  end
end

function DesenhaItem(mapa1,player)
  if mapa1:qtdItem(player:getMapaParte()+1)~=0 then
    for i = 1,mapa1:qtdItem(player:getMapaParte()+1),1 do
      love.graphics.draw(mapa1:VetItem(player:getMapaParte()+1,i):getImagem(),mapa1:VetItem(player:getMapaParte()+1,i):getX(),mapa1:VetItem(player:getMapaParte()+1,i):getY(),0,mapa1:VetItem(player:getMapaParte()+1,i):getScaleX(),mapa1:VetItem(player:getMapaParte()+1,i):getScaleY());
      if CheckVida(mapa1:VetItem(player:getMapaParte()+1,i),player) then
        mapa1:removeItem(player:getMapaParte()+1,i);
        i = i-1;
        player:setHp(player:getHp() + 15);
      end
    end
  end
end

function DesenhaMapa(mapa1,mapa,plataforma)
  for i=mapa1:getCameraY(),mapa1:getHeight(),1 do
    for j=mapa1:getCameraX(),mapa1:getLimiteX(),1 do
      if mapa[i][j]=="G" then
        love.graphics.draw(chao,(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      elseif mapa[i][j] =="M" then
        love.graphics.draw(plataforma[2],(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      elseif mapa[i][j] =="E" then
        love.graphics.draw(plataforma[1],(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      elseif mapa[i][j] =="D" then
        love.graphics.draw(plataforma[3],(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      elseif mapa[i][j] =="A" then
        love.graphics.draw(acido,(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      elseif mapa[i][j] =="S" then
        love.graphics.draw(spike,(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      elseif mapa[i][j]=="L" then
        if qtd.vida>0 then
          love.graphics.draw(vida,(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
        end
      elseif mapa[i][j] =="H" then
        love.graphics.draw(plataforma[4],(j-mapa1:getCameraX())*mapa1:getTileSize(),(i-mapa1:getCameraY())*mapa1:getTileSize(),0,0.375,0.375)
      end
    end
  end
end



function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(mapas[player:getMapa()]:getImagem(),0,0,0,mapas[player:getMapa()]:getScaleX(),mapas[player:getMapa()]:getScaleY())
  love.graphics.setLineWidth(2);
  love.graphics.setColor(255,255,255);
  love.graphics.rectangle("line",30,30,155,10);
  love.graphics.setColor(255,0,0)
  love.graphics.setLineWidth(6);
  love.graphics.line(31,35,1.53 * player:getHp() + 31,35);
  love.graphics.setColor(255,255,255);
  DesenhaMapa(mapas[player:getMapa()],mapas_txt[player:getMapa()],plataforma)
  Desenha(player,player:getMovimento(),0,player:getScaleX(),player:getScaleY())
--  love.graphics.print(mapas[player:getMapa()]:qtdInimigo(player:getMapaParte()+1),0,0);
--  love.graphics.print(mapas[1]:getTotalPartes(),0,15);
--  love.graphics.print(player:getMapaParte(),0,30);
  if mapas[player:getMapa()]:qtdInimigo(player:getMapaParte()+1)~=0 then
    for i = 1,mapas[player:getMapa()]:qtdInimigo(player:getMapaParte()+1),1 do
      DesenhaInimigo(mapas[player:getMapa()]:VetInimigo(player:getMapaParte()+1,i),player,exclamation_img);
    end
  end
    
  
  DesenhaItem(mapas[player:getMapa()],player);
  love.graphics.setColor(52,191,237)
  desenhaTiros(boss)
  
  love.graphics.setLineWidth(1);
  love.graphics.setColor(255,255,255)
  if boss:getQtdTiros()~=0 then
  love.graphics.rectangle("line",boss:Vettiro(1):getX(),360,(player:getWidth(player:getMovimento(),0.2)),(player:getHeight(player:getMovimento(),0.2)));
  end
  --love.graphics.rectangle("line",inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())),inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())),(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX())),(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY())));
 
  love.graphics.print(math.ceil(player:getHp()).."/100",100,30,0,0.8,0.8);
  --love.graphics.print(mapa[math.floor((inimigo1:getY()-(inimigo1:getHeight(inimigo1:getMovimento(),inimigo1:getScaleY()))/2)/mapa1:getTileSize())+2][math.floor(((inimigo1:getX()-(inimigo1:getWidth(inimigo1:getMovimento(),inimigo1:getScaleX()))/1.5))/mapa1:getTileSize())+1+(inimigo1:getMapaParte()*mapa1:getDeltaX())],0,0)
  --love.graphics.print(atck ,0,15)
  if pause == 1 then
    love.graphics.print("Pause",love.graphics.getWidth()/2,love.graphics.getHeight()/2,0,1.5,1.5)
  end
    --love.graphics.print(mapa1:VetInimigo(player:getMapaParte()+1,1):getHp(),0,0)
  
end