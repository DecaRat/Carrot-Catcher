rhinos={}
rhinos.list={}

rhinoUpSprite=love.graphics.newImage("images/rhinoup.png")
rhinoDownSprite=love.graphics.newImage("images/rhinodown.png")
rhinoWidth=rhinoUpSprite:getWidth()
rhinoHeight=rhinoUpSprite:getHeight()
--canPlayCollision=true

function rhinos.load()
	rhinos.list[1]={}
	rhinos.list[1].x=(math.random(0,720-rhinoWidth))
	rhinos.list[1].y=(570+math.random(300,400))
	rhinos.list[1].speed=50
	rhinos.list[1].direction="up"
end

function rhinos.update(dt)
	if (rhinos.list[1].direction=="up") then
		rhinos.list[1].y = (rhinos.list[1].y - rhinos.list[1].speed*dt)
	else
		rhinos.list[1].y = (rhinos.list[1].y + rhinos.list[1].speed*dt)
	end
	
	if (rhinos.list[1].y<(-401)) and (rhinos.list[1].direction=="up") then
		rhinos.list[1].x=(math.random(0,720-rhinoWidth))
		rhinos.list[1].y=(0-math.random(300,400))
		rhinos.list[1].direction = "down"
	elseif (rhinos.list[1].y>(1000)) and (rhinos.list[1].direction=="down") then
		rhinos.list[1].x=(math.random(0,720-rhinoWidth))
		rhinos.list[1].y=(570+math.random(300,400))
		rhinos.list[1].direction = "up"
	end
	
	if CheckCollision(rhinos.list[1].x,rhinos.list[1].y,rhinoWidth,rhinoHeight,player.x,player.y,player.sprite:getWidth(),player.sprite:getHeight()) then
		player.speed=0
		beingTrampled=5
		--if canPlayCollision==true then
			collisionSound:play()
			--canPlayCollision=false
		--end
	else
		--canPlayCollision=true
		beingTrampled=1
	end
	
end

function rhinos.draw()
	if rhinos.list[1].direction=="up" then
		love.graphics.draw(rhinoUpSprite, rhinos.list[1].x, rhinos.list[1].y)
	elseif rhinos.list[1].direction=="down" then
		love.graphics.draw(rhinoDownSprite, rhinos.list[1].x, rhinos.list[1].y)
	end
	--print("X :: " .. (rhinos.list[1].x) .. ": Y :: " .. (rhinos.list[1].y))
end