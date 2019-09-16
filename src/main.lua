require "player"
require "carrots"
require "rats"
require "rhinos"
require "bats"
socket = require("socket")

function sleep(sec)
    socket.sleep(sec)
end
DefaultFont=love.graphics.newFont(14)
ScoreFont = love.graphics.newImageFont("images/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")

sounds = {}
pause=false
gameOver=false
PlayerSpeed=365
gameOverScreen=love.graphics.newImage("images/gameover.png")
easterEggScreen=love.graphics.newImage("images/garbage.png")
goldenCarrotSprite=love.graphics.newImage("images/goldenC.png")
backgroundImage=love.graphics.newImage("images/background2.png")
beingTrampled=1
oneOnion=false 
twoOnion=false
OnionCounter=0
BatsReleased=false
BatsProb=15

function love.load() -- This code gets executed once
	math.randomseed( os.time() )

    love.graphics.setBackgroundColor(199/255,189/255,100/255) -- Background
	
	player.load()
	
	bats.load()
	
    sounds.meow = love.audio.newSource("audio/meow.mp3","stream")
	backgroundMusic = love.audio.newSource("audio/background.ogg","static")
	collisionSound = love.audio.newSource("audio/collision.ogg","static")
	backgroundMusic:setLooping(true)
	backgroundMusic:play()
    sounds.isPlaying = false
	
	carrots.load()
	
	rats.load()
	
	rhinos.load()
end

function love.update(dt)-- this code gets executed every "tick"
	if dt>1/30 then
		dt=1/30
	end
	player.update(dt)
	if gameOver==false then
		
		player.speed=PlayerSpeed
		if (rhinoTime() == true) then
			rhinos.update(dt)
		end
		
		if (oneOnionTime() == true) then
			oneOnion=true
		end
		
		if (twoOnionTime() == true) then
			twoOnion=true
		end
		
		if OnionCounter>1 and BatsReleased==false then
			local thingy = math.ceil(OnionCounter/7)
			if thingy > 7 then 
				thingy = 7 
			end
			countTo=(8-thingy)
			countingUp=countingUp+dt
			if countingUp>=countTo then
				BatsReleased=true
			end
			
		end
		
		player.update(dt)
		
		ratCheck(TOTALcarrotsCollected)
		carrots.update(dt)
		
		rats.update(dt)
		
		if BatsReleased == true then
			bats.update(dt)
		end
		
	else
		for i,v in pairs (carrots.list) do
			table.remove(carrots.list,i)
		end
	end
end

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function CheckCollisionSides(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1
end

function CheckCollisionTopBot(x1,y1,w1,h1, x2,y2,w2,h2)
  return y1 < y2+h2 and
         y2 < y1+h1
end

function love.draw() -- this code gets executed after every update. The only difference between this and the update is that this can draw.
	love.graphics.setNewFont(10)
	love.graphics.setColor(1,1,1)
	love.graphics.draw(backgroundImage,0,0)
	love.graphics.setColor(0,0,0)
	love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
	if gameOver == true then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(gameOverScreen,0,0)
		love.graphics.setColor(1,1,1)
		love.graphics.setFont(ScoreFont)
		love.graphics.print("Total Score : " .. TOTALcarrotsCollected + math.floor(OnionCounter/7), 280, 10)
		
	elseif goldenGot==true then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(easterEggScreen,0,0)
		backgroundMusic:stop()
		--sleep(0.2)
		--love.window.close()
		--love.event.quit()
	elseif gameOver == false then
		
		player.draw()
		
		love.graphics.setColor(1,1,1)
		
		rats.draw()
		
		if (rhinoTime() == true) then
			rhinos.draw(dt)
		end
		
		carrots.draw()
		
		if BatsReleased==true then
			bats.draw()
		end
	end
end


function love.mousepressed(x,y,button)

end

function love.mousereleased(x,y,button)

end

function love.keypressed( key )

end

