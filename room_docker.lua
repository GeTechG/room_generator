
function filter_left(block)
  if (block.top or block.bottom) then
    return false;
  end
  if (block.left) then
    return true
  end
end

function filter_right(block)
  if (block.top or block.bottom) then
    return false;
  end
  if (block.right) then
    return true
  end
end

function filter_top(block)
  if (block.left or block.right) then
    return false;
  end
  if (block.top) then
    return true
  end
end

function filter_bottom(block)
  if (block.left or block.right) then
    return false;
  end
  if (block.bottom) then
    return true
  end
end

local function docking()

end

function docker(rooms)
  local temp_rooms_undocker = {};
  for k,v in pairs(rooms) do
    temp_rooms_undocker[k] = v;
  end
  local temp_rooms_docker = {};

  while(#temp_rooms_undocker > 0) do
    local horizontal = math.random() > 0.5;
    if #temp_rooms_docker > 0 then
      local docking;
      docking = function()
        local docker_room = math.choose(temp_rooms_docker);

        local undocker_blocks;
        local docker_blocks;

        if horizontal then
          undocker_blocks = stream(temp_rooms_undocker[1].blocks).filter(filter_left).toarray()
          docker_blocks = stream(docker_room.blocks).filter(filter_right).toarray()
        else
          undocker_blocks = stream(temp_rooms_undocker[1].blocks).filter(filter_top).toarray()
          docker_blocks = stream(docker_room.blocks).filter(filter_bottom).toarray()
        end

        local choosed_left = math.choose(undocker_blocks);
        local choosed_right = math.choose(docker_blocks);
        local offset_x = docker_room.x + choosed_right.x - choosed_left.x;
        local offset_y = docker_room.y + choosed_right.y - choosed_left.y;
        temp_rooms_undocker[1].x = offset_x;
        temp_rooms_undocker[1].y = offset_y;

        local confirm = true;
        for _,other_room in pairs(temp_rooms_docker) do
            if temp_rooms_undocker[1]:overlap(other_room) then
              docking();
              confirm = false;
            end
        end

        if confirm then
          temp_rooms_undocker[1]:removeBlock(choosed_left);
          docker_room:removeBlock(choosed_right);
        end

      end
      docking();
    end
    table.insert(temp_rooms_docker, temp_rooms_undocker[1]);
    table.remove(temp_rooms_undocker, 1);
  end

end
