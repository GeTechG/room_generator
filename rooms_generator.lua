function reroll_room(rand)
  local width = math.floor(math.boxMullerRandom() * 50);
  local height = math.floor(math.boxMullerRandom() * 50);
  width = math.max(width, 3);
  height = math.max(height, 3);
  if (width / height > 2) or (width / height < 0.5) then
    return reroll_room();
  end
  return Room:new(width, height);
end

function reroll_rooms()
  local rooms = {};
  local rand = math.random();
  for i = 1, love.math.random(1, 10) do
    rooms[i] = reroll_room(rand);
  end
  return rooms;
end
