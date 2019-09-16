rats={}
rats.list={}
ratSpeed=200
absMaxRats=4
maxRats=1
fourHundredReached=false
fiveHundredReached=false

function rats.load()
	ratSprite=love.graphics.newImage("images/rat.png")
	rightRatSprite=love.graphics.newImage("images/rat2.png")
	ratWidth=ratSprite:getWidth()
	ratHeight=ratSprite:getHeight()
	
	for i=1,maxRats do
		rats.list[i] = {}	
		rats.list[i].x=(-200-ratWidth*1.5)
		rats.list[i].speed=ratSpeed
		rats.list[i].y=(math.random(0,570-ratHeight))
		rats.list[i].direction="left"
	end
end

function rats.update(dt)
	for i,v in pairs (rats.list) do
		if (rats.list[i].direction=="left") then
			rats.list[i].x = (rats.list[i].speed*dt + rats.list[i].x)
		else 
			rats.list[i].x = (rats.list[i].x - rats.list[i].speed*dt)
		end
	end
	
	for i,v in pairs (rats.list) do
		if CheckCollision(rats.list[i].x,rats.list[i].y,ratWidth,ratHeight,player.x,player.y,player.sprite:getWidth(),player.sprite:getHeight()) and pause == false then
			pause=true
			player.carrotsCollected=player.carrotsCollected-10*beingTrampled
			collisionSound:play()
			if player.carrotsCollected < 0 then
				gameOver=true
				player.carrotsCollected = 0
			end
			
			if (rats.list[i].direction == "left") then
				rats.list[i].x=(0-ratWidth*1.5)
			else
				rats.list[i].x=(720+ratWidth*1.5)
			end
			rats.list[i].speed=math.random(ratSpeed-25,ratSpeed)
			rats.list[i].y=(math.random(0,570-ratHeight))
			pause=false
		elseif (rats.list[i].x>750) and (rats.list[i].direction=="left") and pause == false then
			pause=true
			
			if (rats.list[i].direction == "left") then
				rats.list[i].x=(0-ratWidth*1.5)
			else
				rats.list[i].x=(720+ratWidth*1.5)
			end
			rats.list[i].speed=math.random(ratSpeed-25,ratSpeed)
			rats.list[i].y=(math.random(0,570-ratHeight))
			pause=false
		elseif (rats.list[i].x<-30) and (rats.list[i].direction=="right") and pause == false then
			pause=true
			
			if (rats.list[i].direction == "left") then
				rats.list[i].x=(0-ratWidth*1.5)
			else
				rats.list[i].x=(720+ratWidth*1.5)
			end
			rats.list[i].speed=math.random(ratSpeed-25,ratSpeed)
			rats.list[i].y=(math.random(0,570-ratHeight))
			pause=false
		end
	end
end

function rats.draw()
	for i,v in pairs (rats.list) do
		if rats.list[i].direction == "left" then
			love.graphics.draw(ratSprite, rats.list[i].x, rats.list[i].y)
		elseif rats.list[i].direction == "right" then
			love.graphics.draw(rightRatSprite, rats.list[i].x, rats.list[i].y)
		end
	end
end

--[[-----------------------------------------------------
---------------------------------------------------------
---------------DIFFICULTY BASED FUNCTIONS----------------
---------------------------------------------------------
--]]-----------------------------------------------------

function ratCheck(howMany)
	maxRats=(math.ceil(howMany)/100)
	if maxRats==5 and fourHundredReached==false then
		fourHundredReached=true
		rats.list[2].direction="right"
	elseif maxRats==6 and fiveHundredReached==false then
		fiveHundredReached=true
		rats.list[4].direction="right"	
	end
	ratSpeed=200+maxRats*50
	if ratSpeed>300 then
		ratSpeed=300
	end
	if (#(rats.list) < maxRats) and (#(rats.list) < absMaxRats) then
		local inte=(#(rats.list)+1)
		rats.list[inte] = {}
		rats.list[inte].x = (-200-ratWidth*1.5)
		rats.list[inte].speed=math.random(ratSpeed-25,ratSpeed)
		rats.list[inte].y=(math.random(0,570-ratHeight))
		rats.list[inte].direction="left"
	end
	
end

function rhinoTime()
	if maxRats>=4 then
		return true
	else
		return false
	end
end

function oneOnionTime()
	if maxRats>=7 then
		return true
	else
		return false
	end
end

function twoOnionTime()
	if maxRats>=8 then
		return true
	else
		return false
	end
end

function moreRatsTime()

end