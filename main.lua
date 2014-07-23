--main.lua

require "TEsound"		local TEsound=TEsound
Moveable=require "moveable"	local Moveable=Moveable
World=require "world"		local World=World
local love=love
local ipairs=ipairs

local world
local keys,debug,paused
local duration,start
local oxygenmono,dayposterblack
local function round(num) return math.floor(num+0.5) end

function love.load()
	keys={["up"]="w",["down"]="s",["left"]="a",["right"]="d",
			["quit"]="escape",["debug"]="f3",["pause"]="q"}
	debug=false
	paused=false
	duration,start=0,love.timer.getTime()
	
	math.randomseed(os.time())
	
	world=World:loadFile("resources/worlds/testworld")
	world:initializeCollisions()
	world:basicSprites(randomcolor(false))
	if world.music then world:playMusic() end
	
	love.graphics.setBackgroundColor(255,255,255)
	oxygenmono,dayposterblack=love.graphics.newFont("resources/fonts/oxygenmono.otf"),
		love.graphics.newFont("resources/fonts/dayposterblack.ttf",60)
end

function love.update(dt)
	for i,ma in ipairs(world) do
		ma:update(dt)
	end
	duration=math.floor(love.timer.getTime()-start)
	TEsound.cleanup()
end
function pausedupdate() love.sleep(0.1) end

function randomcolor(set)
	local r,g,b=math.random(1,255),math.random(1,255),math.random(1,255)
	if set then love.graphics.setColor(r,g,b)
	else return r,g,b
end	end

function love.draw()
	for i,ma in ipairs(world) do
		love.graphics.draw(ma.sprite,ma.x,ma.y)
	end
    
	if debug then
		love.graphics.setColor(0,0,0)	love.graphics.setFont(oxygenmono)
		love.graphics.print("world name: "..world.name
		.."\nx: "..round(world.player.x)..", y: "..round(world.player.y).."\nfps: "..love.timer.getFPS(),10,10)
end	end

function pauseddraw()
	love.graphics.setColor(0,0,0)	love.graphics.setFont(oxygenmono)
	love.graphics.print("Current playtime: "..duration.." seconds",10,10)
	randomcolor(true)	love.graphics.setFont(dayposterblack)
	love.graphics.printf("GAME PAUSED",0,200,512,"center")
end

function love.keypressed(key)
	if key==keys.up then
		world.player.ay=world.player.ay-world.a
	elseif key==keys.down then
		world.player.ay=world.player.ay+world.a
	elseif key==keys.left then
		world.player.ax=world.player.ax-world.a
	elseif key==keys.right then
		world.player.ax=world.player.ax+world.a
	elseif key==keys.debug then
		debug=not debug
	elseif key==keys.pause then
		paused=not paused
		love.update,pausedupdate=pausedupdate,love.update
		love.draw,pauseddraw=pauseddraw,love.draw
        	if paused then world.pauseMusic() else world.resumeMusic() end
	elseif key==keys.quit then
		love.event.push("quit")
end	end

function love.keyreleased(key)
	if key==keys.up then
		world.player.ay=world.g
	elseif key==keys.down then
		world.player.ay=world.g
	elseif key==keys.left then
		world.player.ax=0
	elseif key==keys.right then
		world.player.ax=0
end	end
