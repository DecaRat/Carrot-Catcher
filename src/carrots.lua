carrots={}
carrots.list={}
maxCarrots=5
accelVarLow=200
accelVarHigh=350
pointsPerCarrot=1
goldenCarrotChance=21212
goldenGot=false
countingUp=0

function carrots.load()
	TOTALcarrotsCollected = 0
	
	carrotSprite=love.graphics.newImage("images/carrot.png")
	carrotWidth=carrotSprite:getWidth()
	carrotHeight=carrotSprite:getHeight()
	
	onionSprite=love.graphics.newImage("images/onion.png")
	onionWidth=onionSprite:getWidth()
	onionHeight=onionSprite:getHeight()
	
	for i=1,maxCarrots do
		carrots.list[i] = {}
		carrots.list[i].x=math.random(0,(720-carrotWidth))
		carrots.list[i].y=(0-carrotHeight*(math.random(10,15)/10))--math.random(0,(570-carrotHeight))
		carrots.list[i].accel=math.random(accelVarLow,accelVarHigh)
		carrots.list[i].golden=false
		carrots.list[i].isOnion=false
	end
	
end

function carrots.update(dt)
	for i,v in pairs (carrots.list) do
		carrots.list[i].y = (carrots.list[i].accel*dt + carrots.list[i].y)
	end

	for i,v in pairs (carrots.list) do
		if CheckCollision(carrots.list[i].x,carrots.list[i].y,carrotWidth,carrotHeight,player.x,player.y,player.sprite:getWidth(),player.sprite:getHeight()) and pause == false then
			pause=true
			
			if (carrots.list[i].isOnion==false) then
				player.carrotsCollected=player.carrotsCollected+pointsPerCarrot
				TOTALcarrotsCollected=TOTALcarrotsCollected+pointsPerCarrot
			else
				OnionCounter=OnionCounter+pointsPerCarrot
			end
			
			carrots.list[i].x=math.random(0,(720-carrotWidth))
			carrots.list[i].y=(0-carrotHeight*(math.random(10,15)/10))
			carrots.list[i].accel=math.random(accelVarLow,accelVarHigh)
			if (oneOnion==true) and (i==2) then --turns a carrots into onion  #1
				carrots.list[i].isOnion=true
			elseif (twoOnion==true) and (i==3) then --turns a carrots into onion #2
				carrots.list[i].isOnion=true
			end
			if carrots.list[i].golden == true then
				goldenGot=true
			end
			if math.random(0,goldenCarrotChance) == 42 and (carrots.list[i].isOnion == false) then
				carrots.list[i].golden=true
			else 
				carrots.list[i].golden=false
			end
			pause=false
		elseif (carrots.list[i].y>650) and pause == false then
			pause=true
			
			carrots.list[i].x=math.random(0,(720-carrotWidth))
			carrots.list[i].y=(0-carrotHeight*(math.random(10,15)/10))
			carrots.list[i].accel=math.random(accelVarLow,accelVarHigh)
			carrots.list[i].golden = false
			if (oneOnion==true) and (i==2) then --turns a carrot into onion  #1
				carrots.list[i].isOnion=true
			elseif (twoOnion==true) and (i==3) then --turns a carrot into onion #2
				carrots.list[i].isOnion=true
			end
			if math.random(0,goldenCarrotChance) == 42 and (carrots.list[i].isOnion == false)then
				carrots.list[i].golden=true
			end
			pause=false
		end
	end
end

function carrots.draw()
	for i,v in pairs (carrots.list) do
		if (carrots.list[i].golden == false) and (carrots.list[i].isOnion == false) then
			love.graphics.draw(carrotSprite, carrots.list[i].x, carrots.list[i].y)
		elseif (carrots.list[i].golden == true) and (carrots.list[i].isOnion == false) then
			love.graphics.draw(goldenCarrotSprite, carrots.list[i].x, carrots.list[i].y)
		else
			love.graphics.draw(onionSprite, carrots.list[i].x, carrots.list[i].y)
		end
	end
end