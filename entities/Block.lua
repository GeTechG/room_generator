local Block = class("Block");

function Block:initialize(x, y, top, bottom, left, right)
  self.x = x;
  self.y = y;
  self.top = top;
  self.bottom = bottom;
  self.left = left;
  self.right = right;
end

return Block;
