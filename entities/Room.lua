local Room = class("Room");

function Room:initialize(width, height)
  self.x = 0;
  self.y = 0;
  self.width = width;
  self.height = height;
  self.blocks = {};
  for x = 0, self.width - 1 do
    for y = 0, self.height - 1 do
      local top = y == 0;
      local bottom = y == self.height - 1;
      local left = x == 0;
      local right = x == self.width - 1;
      if top or bottom or left or right then
        self.blocks[#self.blocks + 1] = Block:new(x, y, top, bottom, left, right);
      end
    end
  end
end

function Room:draw()
  for _,block in pairs(self.blocks) do
    local red = block.top and 1 or 0.5;
    local green = block.bottom and 1 or 0.5;
    local blue = block.left and 1 or 0.5;
    local alpha = block.right and 1 or 0.5;
    love.graphics.setColor(red, green, blue, alpha);
    love.graphics.rectangle('fill', (self.x  + block.x) * 8, (self.y + block.y) * 8, 8, 8);
  end
  love.graphics.print(self.width .. ", " .. self.height, (self.x  + self.width + 1) * 8, (self.y + self.height) * 8);
end

function Room:overlap(other)
  local self_top_left = {x = self.x, y = self.y}
  local self_bottom_right = {x = self.x + self.width - 1, y = self.y + self.height - 1}

  local other_top_left = {x = other.x, y = other.y}
  local other_bottom_right = {x = other.x + other.width - 1, y = other.y + other.height - 1}

  if (self_top_left.x >= other_bottom_right.x -- R1 is right to R2
  or self_bottom_right.x <= other_top_left.x -- R1 is left to R2
  or self_top_left.y >= other_bottom_right.y -- R1 is above R2
  or self_bottom_right.y <= other_top_left.y) then -- R1 is below R1
    return false;
  end
  return true;
end

function Room:removeBlock(block)
  self.blocks = stream(self.blocks).filter(function(b) return b ~= block end).toarray();
end

return Room
