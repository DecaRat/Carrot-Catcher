bats={}
batsLoaded=false

function bats.load()
	bats.sprite=love.graphics.newImage("images/bats.png")
	batWidth=bats.sprite:getHeight()
	batHeight=bats.sprite:getWidth()
	
	bats.radiusFromCenter = 550
	bats.angleInRadians=((2*math.pi*(math.random(1,360)))/360)
	bats.xPos=(bats.radiusFromCenter*math.cos(bats.angleInRadians) + 310)
	bats.yPos=(bats.radiusFromCenter*math.sin(bats.angleInRadians) + 233)
	bats.xCompR=0
	bats.yCompR=0
	bats.velocity=200
	bats.xVel=0
	bats.yVel=0
	bats.satisfied=false
	
	bats.xCompR=(player.x-bats.xPos)
	bats.yCompR=(player.y-bats.yPos)
	bats.xyAngle=math.atan2(bats.xCompR,bats.yCompR)
	bats.xVel=(bats.velocity*math.sin(bats.xyAngle))
	bats.yVel=(bats.velocity*math.cos(bats.xyAngle))
end

function bats.update(dt)
	if batsLoaded==false then
		bats.load()
		batsLoaded=true
	end
	bats.xPos=(bats.xPos+bats.xVel*dt)
	bats.yPos=(bats.yPos+bats.yVel*dt)
	
	
	------------
	if CheckCollision(bats.xPos,bats.yPos,batWidth,batHeight,player.x,player.y,player.sprite:getWidth(),player.sprite:getHeight()) and pause == false and bats.satisfied==false then
		pause=true
		bats.satisfied=true
		player.carrotsCollected=player.carrotsCollected-25
		collisionSound:play()
		if player.carrotsCollected < 0 then
			gameOver=true
			player.carrotsCollected = 0
		end
		
		pause=false
	elseif ((((bats.xPos-310)^2 + (bats.yPos-233)^2)^(1/2))>555) and pause == false then
		pause=true
		
		batsLoaded=false
		BatsReleased=false
		pause = false
	end
	---------------
end

function bats.draw()
	love.graphics.draw(bats.sprite,bats.xPos,bats.yPos)
end