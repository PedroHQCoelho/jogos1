GameObject = {}
function GameObject:new(x, y, w, h)
   local obj = {px = x,
                py = y,
                width = w,
                height = h,
                collided = false}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function GameObject:MoveX(x)
  self.px = self.px + x
end

function GameObject:MoveY(y)
  self.py = self.py + y
end

function GameObject:GetX()
  return self.px
end
function GameObject:GetY()
  return self.py
end

function GameObject:GetWidth()
  return self.width
end

function GameObject:GetHeight()
  return self.height
end

function GameObject:IsCollided()
  return self.collided
end

function GameObject:SetCollided(c)
  self.collided = c
end