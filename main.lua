require 'utils.math'
require 'lib.print_table'

local Camera = require 'lib.camera'

class = require 'lib.middleclass'
require 'lib.stream'
flux = require "lib.flux"

Block = require 'entities.Block'
Room = require 'entities.Room'

require "rooms_generator"
require 'room_docker'

local rooms = reroll_rooms();
docker(rooms);

function love.load()
	cam = Camera( 800, 600, { x = 0, y = 0, resizable = true, maintainAspectRatio = true } )
  cam_zoom = 1;
end

function love.keyreleased(key)
  if key == "space" then
    rooms = reroll_rooms();
    docker(rooms);
  end
end

function love.update(dt)

  if love.keyboard.isDown('left') then
    cam.translationX = cam.translationX - dt * 300 / cam.scale;
  end
  if love.keyboard.isDown('right') then
    cam.translationX = cam.translationX + dt * 300 / cam.scale;
  end
  if love.keyboard.isDown('up') then
    cam.translationY = cam.translationY - dt * 300 / cam.scale;
  end
  if love.keyboard.isDown('down') then
    cam.translationY = cam.translationY + dt * 300 / cam.scale;
  end

  flux.update(dt)

	cam:update() -- Needed to appropriately resize the camera
end

function love.wheelmoved(x, y)
    if y > 0 then
      cam_zoom = cam_zoom * y * 1.1;
    elseif y < 0 then
      cam_zoom = cam_zoom * math.abs(y * 0.9);
    end
    flux.to(cam, 2, {scale = cam_zoom}):ease('expoout')
end

function love.draw()
  cam:push()
  for i = 1, #rooms do
    rooms[i]:draw();
  end
  cam:pop()
end
