-- LOVE 11.5

Player = {
	x = 0,
	y = 0,
	vel = 1,
	w = 64,
	h = 64,
	sx = 2,
	sy = 2,
	isMoving = false,
}
Player.ox = Player.w / 2
Player.oy = Player.h / 2
Spritesheets = {}
Animations = {}

function love.load()
	Anim8 = require 'lib/anim8-231/anim8'
	love.graphics.setDefaultFilter("nearest", "nearest")
	Spritesheets.warriorIdle = love.graphics.newImage('sprite/dreamir_chars_v2/WarriorMan/WarriorManIdle.png')
	local g = Anim8.newGrid(Player.w, Player.h, Spritesheets.warriorIdle:getWidth(), Spritesheets.warriorIdle:getHeight())
	Animations.warriorIdle = Anim8.newAnimation(g('1-8', 1), 0.1)
	Spritesheets.warriorWalk = love.graphics.newImage('sprite/dreamir_chars_v2/WarriorMan/WarriorManWalk.png')
	local g2 = Anim8.newGrid(Player.w, Player.h, Spritesheets.warriorWalk:getWidth(), Spritesheets.warriorWalk:getHeight())
	Animations.warriorWalk = Anim8.newAnimation(g2('1-8', 1), 0.1)
end

function love.update(dt)
	Animations.warriorIdle:update(dt)
	Animations.warriorWalk:update(dt)
	Player.isMoving = false
	if love.keyboard.isScancodeDown("d") then
		Player.isMoving = true
		if Player.sx < 0 then Player.sx = Player.sx * -1 end
		Player.x = Player.x + Player.vel
	elseif love.keyboard.isScancodeDown("a") then
		Player.isMoving = true
		if Player.sx > 0 then Player.sx = Player.sx * -1 end
		Player.x = Player.x - Player.vel
	end
	if love.keyboard.isScancodeDown("s") then
		Player.isMoving = true
		Player.y = Player.y + Player.vel
	elseif love.keyboard.isScancodeDown("w") then
		Player.isMoving = true
		Player.y = Player.y - Player.vel
	end

	if Player.x - Player.ox < 0 then Player.x = Player.ox end
	if Player.x > love.graphics.getWidth() - (Player.ox) then
		Player.x = love.graphics.getWidth() - (Player.ox)
	end
	if Player.y - Player.oy < 0 then Player.y = Player.oy end
	if Player.y > love.graphics.getHeight() - (Player.oy) then
		Player.y = love.graphics.getHeight() - (Player.oy)
	end
end

function love.draw()
	love.graphics.print("Hey", 400, 300)
	if Player.isMoving then
		Animations.warriorWalk:draw(Spritesheets.warriorWalk, Player.x, Player.y, nil, Player.sx, Player.sy, Player.ox,
			Player.oy)
	else
		Animations.warriorIdle:draw(Spritesheets.warriorIdle, Player.x, Player.y, nil, Player.sx, Player.sy, Player.ox,
			Player.oy)
	end
end
