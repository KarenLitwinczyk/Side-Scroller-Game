-----------------------------------------------------------------------------------------
--
-- main.lua
--Karen Litwinczyk
-----------------------------------------------------------------------------------------

--this is the width and the height of the display screen.
W = display.contentWidth
H = display.contentHeight

--this hides the status bar of the virtual phone at the top of the screen.
display.setStatusBar(display.HiddenStatusBar)   

--this imports the physics module, so physics and methods of physics are able to be used.
local physics = require("physics")
physics.start( )
--physics.setDrawMode( "hybrid" )

--this loads the background music for the game.
backgroundMusic = audio.loadStream("assets/sounds/Forest - New Super Mario Bros. Wii Music Extended.mp3")
--this plays the background music for the game.
audio.play(backgroundMusic)
--this loads the jump effect sound for the game.
jumpSound = audio.loadSound("assets/sounds/jump2.wav")

--this is a table to hold all of the images of the background.
local background = {}
--this creates a new image into the table, and sets the width and height of the image.
background[1] =  display.newImageRect("assets/freetileset/png/BG/BG.png",W, H+30)
--this sets the x and y values of the first image to the center of the display screen.
background[1].x = W/2 
background[1].y = H/2
--this creates a new image into the table, and sets the width and height of the image.
background[2] = display.newImageRect("assets/freetileset/png/BG/BG2.png",W, H+30)
--this sets the x and y of the image to the center of the screen (the y value), 
--and right next to the edge of the first image (the x value).
background[2].x = W/2 + W
background[2].y = H/2
--this creates a new image into the table, and sets the width and height of the image.
background[3] = display.newImageRect("assets/freetileset/png/BG/BG3.png",W, H+30)
--this sets the x and y of the image to the center of the screen (the y value),
--and right next to the edge of the second image (the x value).
background[3].x = W/2 + 2*W
background[3].y = H/2

--this requires/imports the game over screen.
local gameOver = require("gameOver")
gameOver.replayBtn.isVisible = false

--this requires/imports the player module.
local player = require("player")
player.playerSprite.isVisible = false
--this creates variables for the player's score and the number of lives the player has.
player.playerSprite.score = 0
player.playerSprite.lives = 1

--this requires/imports the start screen.
local startScreen = require("start")
startScreen.start.isVisible = true
local level1 = require("level1")
level1.firstLevel.isVisible = false

--this scales the player so they are a reasonable size in relation to the screen.
player.playerSprite:scale(0.2, 0.2)

--this sets the gravity in the game.
physics.setGravity( 0, 14)

for i=1, 10 do
	--this imports an image and creates the floor, wide enough so the object spawning off the screen will not fall off.
	floor = display.newImageRect("assets/freetileset/png/Tiles/2.png", i*1000, 25)
	--sets the x and y of the floor.
	floor.x = 0
	floor.y = H+20
	physics.addBody( floor, "static", {density = 1, bounce = 0} )
	floor.isVisible = false
end


--this is a group that updates certain values of the game.
local grpUpdate = display.newGroup()
grpUpdate.isVisible = false
--this is the score variable within this group.
grpUpdate.score = display.newText( grpUpdate, "Score: 0", W/2, 5, "Arial", 30 )
grpUpdate.score:setFillColor( 0,0,0 )

--this updates the score of the player when the function is called, concatenates the group score text
--with the player score variable/value.
local function updateVars()
	grpUpdate.score.text = "Score: " .. player.playerSprite.score
end

--this changes the score when called.
local function changeScore()
	player.playerSprite.score = player.playerSprite.score + 1
	updateVars()
end

--this changes the player's lives when called.
local function playerHit()
	player.playerSprite.lives = player.playerSprite.lives - 1
end
--this function displays the in game level when the start button is pressed.
local function startLevel1()
	startScreen.start.isVisible = false
	level1.firstLevel.isVisible = true
	player.playerSprite.isVisible = true
	--this sets the player's x and y
	player.playerSprite.x = 75
	player.playerSprite.y = 280
	player.playerSprite:setSequence("run")
	player.playerSprite:play()
	--this displays the jump and slide button for the user.
	level1.showJumpBtn()
	level1.showSlideBtn()
	--this displays the group score so the player is able to keep track of their score.
	grpUpdate.isVisible = true
	grpUpdate.score.isVisible = true
	--this calls the function to create the obstacles in the game, after the level has begun.
	level1.makeObstacles()
	--this sets the floor to be visible in the game.
	floor.isVisible = true
	--this calls the changeScore function and updates it every half a second.
	changeScore()
	--make var == timer.performwith delay
	scoreTimer = timer.performWithDelay( 250, changeScore, -1)
end

--this displays the menu screen and resets the player's lives and score when called.
local function displayMenu()
	startScreen.start.isVisible = true
	level1.firstLevel.isVisible = false
	player.playerSprite.isVisible = false
	player.playerSprite.lives = 1
	player.playerSprite.score = 0
	gameOver.replayBtn.isVisible = false
	grpUpdate.score.isVisible = false
	floor.isVisible = false
end

local function exitToMenu()
	startScreen.start.isVisible = true
	level1.firstLevel.isVisible = false
	player.playerSprite.isVisible = false
	player.playerSprite.lives = 1
	player.playerSprite.score = 0
	gameOver.replayBtn.isVisible = false
	grpUpdate.score.isVisible = false
	floor.isVisible = false
	if(obstacles[1].x ~= nil)then
		obstacles[1]:removeSelf( )
	end
	if(obstacles[2].x~= nil)then 
		obstacles[2]:removeSelf( )
	end
	if(obstacles[3].x ~= nil)then
		obstacles[3]:removeSelf( )
	end
	if(obstacles[4].x ~= nil) then
		obstacles[4]:removeSelf( )
	end
end

--this repeatedly checks values and changes them accordingly at a fast pace.
 local function onRedraw()

	if(player.playerSprite.lives == 0) then
		print("lives are less than 0")
		if(player.playerSprite.sequence ~= "dead") then
			print("sequence is not dead setting to dead")
			player.playerSprite:setSequence( "dead" )
			player.playerSprite:play()
			gameOver.replayBtn.isVisible = true
			gameOver.replayBtn:toFront( )
			timer.cancel( scoreTimer )
		end
	end

	--this changes each of the background images left across the display screen.
	background[1].x = background[1].x -3
	background[2].x = background[2].x -3
	background[3].x = background[3].x -3

	--this switches the background images within the table when they reach a certain x value.
	--this makes the background scroll horizontally endlessly.
	if (background[1].x < 0-W) then
		background[1].x = background[3].x +W
		tmp = background[1]
		background[1] = background[2]
		background[2] = background[3]
		background[3] = tmp
	end

	--this checks if the player is on the floor of the game using the player's linear velocity.
	local vx, vy = player.playerSprite:getLinearVelocity()
	onGround = (vy < 2) and (vy > -2)	 

	--this checks if the player is on the floor, if they are not already running, and if they are not sliding
	--if this evalutates true then the player's sequence is set to run.
	if(onGround and player.playerSprite.sequence ~= "run" and player.playerSprite.lives > 0 and player.playerSprite.sequence ~= "slide") then
		print("sequence set to run")
		player.playerSprite:setSequence( "run" )
		player.playerSprite:play()		
	end

	--this checks if the level of the game is true 
	--(if the player has started the game and if they are alive).
	if(level1.firstLevel.isVisible == true) then
		if(player.playerSprite.lives > 0) then
			--this calls the level1's onRedraw function so it can be checked and updated accordingly at a fast pace.
			level1.onRedraw()
		end
	end

	--keeps the player from moving left off the screen when it collides with an object.
	if(player.playerSprite.x <= 74) then
		player.playerSprite.x = 75
	end
	
	--this sets the x velocity of the player to 0 if it is less than 0.
	if(vx < 0)then
		vx = 0
	end
	if(vx > 0)then
		vx = 0
	end
end

--this checks to see if the player has collided with an enemy and if it has 
--it removes the object and calls the playerHit function.
local function playerCollided(event)
	if(event.other.type == "enemy") then
		local function destroy()
			if(obstacles[1].x ~= nil)then
				obstacles[1]:removeSelf( )
			end
			if(obstacles[2].x~= nil)then 
				obstacles[2]:removeSelf( )
			end
			if(obstacles[3].x ~= nil)then
				obstacles[3]:removeSelf( )
			end
			if(obstacles[4].x ~= nil) then
				obstacles[4]:removeSelf( )
			end
			-- obstacles[1]:removeSelf( )
			-- obstacles[2]:removeSelf( )
			-- obstacles[3]:removeSelf( )
			-- obstacles[4]:removeSelf( )
		end
		playerHit()
		timer.performWithDelay( 1, destroy)
	end
end

--this sets the player's sequence to "jump" if it is not already,
--and this is called on an event listener in the level1 module.
function jump()
	if (player.playerSprite.sequence ~= "jump") then
				player.playerSprite:applyForce( 0, -15, player.x, player.y )
				player.playerSprite:setSequence("jump")
				print("player set to jump")
				player.playerSprite:play()
				--this references to the number of times the sound button has been tapped, and if it
				--has been tapped an even amount of times it will play the jump sound.
				if(soundButtonTaps % 2 == 0) then
					audio.play( jumpSound)
				end
			end 
		end

--this sets the player's sequence to "slide" if it is not already,
--and this is called on an event listener in the level1 module.
function slide(event)
		if(event.phase == "began") then
			player.playerSprite:setSequence("slide")
			print("set to slide")
			--this removes the current physics body and adds a new physics body 
			--with the shape for the player when they are sliding.
			physics.removeBody( player.playerSprite )
			physics.addBody( player.playerSprite, "dynamic", {friction = 0, density = 0, bounce = 0, shape = player.slidingShape})
			player.playerSprite:play()
		end
		--this replaces the current physics body with a new physics body with the 
		--shape for the player when they are running and sets the sequnce to run.
		if (event.phase == "ended") then
			player.playerSprite:setSequence( "run" )
			physics.removeBody(player.playerSprite)
			physics.addBody( player.playerSprite,{friction = 0, density = 0, bounce = 0, shape = player.playerShape})
			player.playerSprite.angularDamping = 5000
			player.playerSprite:play( )
		end
end




--this is the event listener to display the menu while in the game.
level1.menuBtn:addEventListener( "tap" , exitToMenu )
--this is the event listener to display the how to play or info screen of the game, from the menu.
startScreen.btnDirection:addEventListener( "tap", startScreen.infoScreen )
--this is the event listener to bring the user back to the menu from another screen in 
--start screen (back to the main menu from the settings or info screen).
startScreen.homeBtn:addEventListener( "tap" , startScreen.backToMenu )
--this is the event listener to start the game and allows the user to play the game.
startScreen.startBtn:addEventListener( "tap", startLevel1 )
--this is the event listener to display the settings screen.
startScreen.btnSettings:addEventListener( "tap", startScreen.settingsScreen )
--this is the event listener to call the onRedraw function for 30 frames a second.
Runtime:addEventListener( "enterFrame", onRedraw)
--this is the event listener to detect if the player collides with an object in the game.
player.playerSprite:addEventListener( "collision", playerCollided )
--this is the event listener to detect if the music button has been tapped.
startScreen.musicBtn:addEventListener( "tap", startScreen.musicBtnTapped)
--this is the event listener to detect if the sound button has been tapped.
startScreen.soundBtn:addEventListener( "tap" , startScreen.soundBtnTapped )

gameOver.replayBtn:addEventListener( "tap", displayMenu)
