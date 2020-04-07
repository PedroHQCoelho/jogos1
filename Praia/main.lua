local mapa = {}

function LoadMap(filename)
 local file = io.open(filename)
 local i = 1
 for line in file:lines() do
 mapa[i] = {}
 for j=1, #line, 1 do
 mapa[i][j] = line:sub(j,j)
 end
 i = i + 1
 end
 file:close()
end
function love.load()
 LoadMap("Mapa.txt")
end

function love.draw()
 for i=1, 10, 1 do 
 for j=1, 14, 1 do
 if (mapa[i][j] == "P") then
 love.graphics.setColor(230,235,134)
 elseif (mapa[i][j] == "G") then
 love.graphics.setColor(39,153,0)
 elseif (mapa[i][j] == "A") then
 love.graphics.setColor(63,125,232)
 end
 love.graphics.rectangle("fill", (j * 50), (i * 50), 50, 50)
 end
 end
end
