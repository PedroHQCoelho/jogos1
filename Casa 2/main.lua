function love.load()
  love.window.setTitle("Minha Casa - Com Mouse Movendo O Sol")
  --Fundo/Céu--
  love.graphics.setBackgroundColor(152,209,250)
  pxn = 0
  pxs = 0
  pys = 0
  dir = 1
end
function love.update(dt)
  --Movimentação das Nuvens--
    if dir == 1 then
      if pxn< 235 then
        pxn = pxn + (100 * dt)
      else
        dir = -1
      end
    elseif dir == -1 then
      if pxn > -450 then
        pxn = pxn - (100 * dt)
      else
        dir = 1
      end
    end
    --Movimentação do Sol--
if love.mouse.isDown("1") then
    pxs = love.mouse.getX() - 70
    pys = love.mouse.getY() - 70
    mousex = love.mouse.getX()
    mousey = love.mouse.getY()
       if pys > 100 then
         pys = 100
         end
       end 
       --Cor do Céu--
              if pxs + 110 >= pxn + 452 and pxs + 40 <= pxn + 565  and pys + 40 <= 105 and pys + 110 >= 40 then
                love.graphics.setBackgroundColor(140,140,142)
		else 
		love.graphics.setBackgroundColor(152,209,250)
	end
end
function love.draw()
  --Grama--
  love.graphics.setColor(20,225,50)
  love.graphics.rectangle("fill",0,500,800,100)
  
  --Sol--
    --Circulo--
      love.graphics.setColor(250,250,10)
      love.graphics.circle("fill",pxs + 75,pys + 75,35,500)
    --Raios Solares--
      love.graphics.setLineWidth(5)
      love.graphics.line(pxs + 25,pys + 25,pxs + 125,pys + 125)
      love.graphics.circle("fill",pxs + 25,pys + 25,2,500)
      love.graphics.circle("fill",pxs + 125,pys + 125,2,500)
      love.graphics.line(pxs + 125,pys + 25,pxs + 25,pys + 125)
      love.graphics.circle("fill",pxs + 125,pys + 25,2,500)
      love.graphics.circle("fill",pxs + 25,pys + 125,2,500)
      love.graphics.line(pxs + 75,pys + 10,pxs + 75,pys + 140)
      love.graphics.circle("fill",pxs + 75,pys + 10,2,500)
      love.graphics.circle("fill",pxs + 75,pys + 140,2,500)
      love.graphics.line(pxs + 10,pys + 75,pxs + 140,pys + 75)
      love.graphics.circle("fill",pxs + 10,pys + 75,2,500)
      love.graphics.circle("fill",pxs + 140,pys + 75,2,500)
  
  --Nuvem--
    love.graphics.setColor(255,255,255)
    love.graphics.circle("fill",pxn + 465,70,18,500)
    love.graphics.circle("fill",pxn + 490,75,25,500)
    love.graphics.circle("fill",pxn + 520,75,25,500)
    love.graphics.circle("fill",pxn + 545,80,18,500)
    love.graphics.circle("fill",pxn + 505,55,15,500)
    love.graphics.circle("fill",pxn + 505,90,15,500)
    love.graphics.circle("fill",pxn + 465,80,20,500)
    love.graphics.circle("fill",pxn + 555,70,10,500)
  
  --Árvore--
    --Tronco--
      love.graphics.setColor(110,60,2)
      love.graphics.rectangle("fill", 545, 375, 25, 125)
    --Folhas--
      love.graphics.setColor(20,225,50)
      love.graphics.circle("fill",560, 350, 75, 500)
    --Maçãs--
      love.graphics.setColor(255,0,0)
      love.graphics.circle("fill", 545, 290, 5, 125)
      love.graphics.circle("fill", 530, 300, 5, 125)
      love.graphics.circle("fill", 510, 320, 5, 125)
      love.graphics.circle("fill", 545, 325, 5, 125)
      love.graphics.circle("fill", 560, 330, 5, 125)
      love.graphics.circle("fill", 575, 315, 5, 125)
      love.graphics.circle("fill", 590, 335, 5, 125)
      love.graphics.circle("fill", 525, 330, 5, 125)
      love.graphics.circle("fill", 545, 290, 5, 125)
      love.graphics.circle("fill", 565, 290, 5, 125)
      love.graphics.circle("fill", 530, 300, 5, 125)
      love.graphics.circle("fill", 510, 320, 5, 125)
      love.graphics.circle("fill", 545, 355, 5, 125)
      love.graphics.circle("fill", 560, 360, 5, 125)
      love.graphics.circle("fill", 580, 365, 5, 125)
      love.graphics.circle("fill", 600, 345, 5, 125)
      love.graphics.circle("fill", 600, 300, 5, 125)
      love.graphics.circle("fill", 615, 315, 5, 125)
      love.graphics.circle("fill", 620, 340, 5, 125)
      love.graphics.circle("fill", 610, 360, 5, 125)
      love.graphics.circle("fill", 600, 390, 5, 125)
      love.graphics.circle("fill", 570, 345, 5, 125)
      love.graphics.circle("fill", 500, 345, 5, 125)
      love.graphics.circle("fill", 515, 360, 5, 125)
      love.graphics.circle("fill", 575, 385, 5, 125)
      love.graphics.circle("fill", 590, 375, 5, 125)
      love.graphics.circle("fill", 525, 380, 5, 125)
      love.graphics.circle("fill", 550, 390, 5, 125)
      love.graphics.circle("fill", 580, 400, 5, 125)
      
  
  --Casa--
    --Parede--
      love.graphics.setColor(250, 10,240)
      love.graphics.rectangle("fill", 140, 360, 160, 140)
    --Porta--
      love.graphics.setColor(110,60,2)
      love.graphics.rectangle("fill", 230, 420, 50, 80)
    --Janela--
      love.graphics.setColor(250,250,10)
      love.graphics.rectangle("fill", 150, 425, 40, 40)
      love.graphics.setColor(80,60,40)
      love.graphics.setLineWidth(3)
      love.graphics.line(150,445,190,445)
      love.graphics.line(170,425,170,465)
    --Telhado--
      love.graphics.setColor(230,150,20)
      love.graphics.polygon("fill",140, 360, 300, 360, 220, 250)
    --Maçaneta--
      love.graphics.setColor(80,60,40)
      love.graphics.circle("fill",240,460,5,500)  
end
