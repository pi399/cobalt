--[[conf.lua
	Copyright 2014 Ian DeWalt
	This is a project intended solely to create fully-fledged collision detection
	from scratch. It has dragged on for too long, but I want to do it. Some
	assistance comes from Brett Sears.
	
	Things that may be added:
	Making velocity on diagonals the same as on the axes
	Sprites
]]

function love.conf(t)
	t.identity="./"
	t.window.width=512
	t.window.height=512
end
