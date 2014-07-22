--world.lua

local World={}
local mt={__index=World}
local Moveable=Moveable

function World:new(friction,acceleration,gravity)
	local w={f=friction,a=acceleration,g=gravity}
	setmetatable(w,mt)
	return w
end

function World:loadFile(filepath)
	w={}
	local file=love.filesystem.newFile(filepath)
	if assert(file:open("r"),"not a valid file!") then
		for line in file:lines() do
			if string.sub(line,1,2)=="n=" then
				w["name"]=string.gsub(line,"n=","",1)
			elseif string.sub(line,1,2)=="f=" then
				w["f"]=string.gsub(line,"f=","",1)
			elseif string.sub(line,1,2)=="a=" then
				w["a"]=string.gsub(line,"a=","",1)
			elseif string.sub(line,1,2)=="g=" then
				w["g"]=string.gsub(line,"g=","",1)
			else
				w[string.gsub(line,"=.+","")]=
				assert(loadstring("return Moveable:new(w,"..string.gsub(line,".+=","")..")")(),"could not load line: "..line)
	end	end	end
	setmetatable(w,mt)
	local rw=w;w=nil
	return rw
end

function World:initializeCollisions()
	for i,ma in ipairs(self) do
		for imi,imma in ipairs(self) do
			if type(ma)=="table" and type(imma)=="table" then
				ma.worldxcount[imma]=0
				ma.worldycount[imma]=0
end	end	end	end

return World
