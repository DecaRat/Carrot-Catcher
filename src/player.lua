player={}

function player.load()
	player.x = 200
	player.y = 200
    player.speed = PlayerSpeed
    player.name = "Cat"
    player.level = 1
	player.carrotsCollected = 0
	player.sprite = love.graphics.newImage("images/cat.png")
end

function player.update(dt)
	if love.keyboard.isDown('d') or love.keyboard.isDown('right') then -- movement
		if ((player.x) < (720-70)) then
			player.x = player.x + player.speed*dt
			player.sprite = love.graphics.newImage("images/catright.png")
		end
	end
	if love.keyboard.isDown('a') or love.keyboard.isDown('left') then -- movement
		if ((player.x) > (0)) then
			player.x = player.x - player.speed*dt
			player.sprite = love.graphics.newImage("images/catleft.png")
		end
	end
	if love.keyboard.isDown('w') or love.keyboard.isDown('up') then -- movement
		if ((player.y) > (0)) then
			player.y = player.y - player.speed*dt
			player.sprite = love.graphics.newImage("images/catup.png")
		end
	end
	if love.keyboard.isDown('s') or love.keyboard.isDown('down') then -- movement
		if ((player.y) < (570-76)) then
			player.y = player.y + player.speed*dt
			player.sprite = love.graphics.newImage("images/catdown.png")
		end
	end	
	if love.keyboard.isDown('escape') then
		backgroundMusic:stop()
		love.window.close()
		love.event.quit()
	end
	if love.keyboard.isDown("k") and (sounds.isPlaying == false) then -- sound
		sounds.isPlaying=true
		love.audio.play(sounds.meow)
		player.sprite = love.graphics.newImage("images/cat.png")
		sounds.isPlaying=false
	end
end

function player.draw()
	love.graphics.setNewFont(11)
	love.graphics.setColor(1,1,1)
	love.graphics.draw(player.sprite, player.x, player.y)
	love.graphics.setColor(0,0,0)
	love.graphics.print("Carrots:" .. player.carrotsCollected, player.x, player.y+80)
	love.graphics.setNewFont(24)
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(ScoreFont)
	love.graphics.print("Total Carrots : " .. TOTALcarrotsCollected, 250, 10)
	if (OnionCounter>0) then
		love.graphics.print("Onions : " .. OnionCounter, 450, 10)
	end
end