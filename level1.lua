--this is the level screen/ in game play.

--this is a table for anything that needs to be returned.
local Level1 = {}

local firstLevel = display.newGroup()

--this imports the physics module, so physics and methods of physics are able to be used.
local physics = require("physics" )
physics.start( )

--this is a button that when pressed brings the user back to the main screen/menu screen.
local menuBtn = display.newImage( firstLevel, "assets/buttons/btnHome.png", 30, 10)
menuBtn:scale( 0.18, 0.18)

--this variable is used to move the obstacles or keep the obstacles in the game from moving.
local readyToMove = false

--this function makes the obstacles that the user must avoid in the game.	
local function makeObstacles()
	--this is a table where all the obstacles are kept.
	obstacles = {}

	--this creates the first obstacle in the game.
	obstacles[1] = display.newImage("assets/freetileset/png/Object/Bush (3).png", W+80, 290)
	--this adds a physics body to the object with a shape suitable for the object image.
	physics.addBody( obstacles[1], "dynamic" , {friction = 0, bounce = 0, density = 0, shape = {-22, -22, -22, 22, 22, 22, 22, -22}} )
	--this sets the type of the obstacle to "enemy", used for checking collisions between this and the player.
	obstacles[1].type = "enemy"
	--obstacles[2].action = "jump"
	obstacles[1].isVisible = false

	--this displays the object after 1 second of being in the game.
	timer.performWithDelay( 1000, 
			function ()
				obstacles[1].isVisible = true
			end)

	--this creates the second obstacle in the game.
	obstacles[2] = display.newImage("assets/freetileset/png/Object/Tree_1.png", W+220, 305 )
	--this adds a physics body to the object with a shape suitable for the object image.
	physics.addBody( obstacles[2],"dynamic" , {friction = 0, bounce = 0, density = 0, shape = {-22, -16, -22, 14, 22, 14, 22, -16}})
	--this sets the type of the obstacle to "enemy", used for checking collisions between this and the player.
	obstacles[2].type = "enemy"
	--obstacles[2].action = "jump"
	obstacles[2]:scale( 0.8, 0.8 )
	obstacles[2].isVisible = false

	--this displays the object after 2 seconds of being in the game.
	timer.performWithDelay(2000,
			function()
				obstacles[2].isVisible = true
			end)
	
	--this creates the third obstacle in the game.
	obstacles[3] = display.newImage("assets/freetileset/png/Object/Stone.png", W+340, 305)
	obstacles[3]:scale( 0.8, 0.8)
	--this adds a physics body to the object with a shape suitable for the object image.
	physics.addBody( obstacles[3], "dynamic" , {friction = 0, bounce = 0, density = 0, shape = {-22, -15, -22, 15, 22, 15, 22, -15}} )
	--this sets the type of the obstacle to "enemy", used for checking collisions between this and the player.
	obstacles[3].type = "enemy"
	--obstacles[2].action = "jump"
	obstacles[3].isVisible = false

	--this displays the object after 3 seconds of being in the game.
	timer.performWithDelay( 3000, 
		function()
			obstacles[3].isVisible = true
		end)

	--this creates the fourth obstacle in the game.
	obstacles[4] = display.newImageRect("assets/freetileset/png/Tiles/2.png", 100, 50)
	--this sets the x and y of the object (fixed y)
	obstacles[4].x = W+460
	obstacles[4].y = H*3/4
	physics.addBody( obstacles[4], "dynamic", {friction = 0, bounce = 0, density = 0})
	--this alters the object so that gravity does not effect this object (so the y value stays fixed).
	obstacles[4].gravityScale = 0
	--this sets the type of the obstacle to "enemy", used for checking collisions between this and the player.
	obstacles[4].type = "enemy"
	--obstacles[2].action = "slide"
	obstacles[4].isVisible = false

	--this displays the object after 4 seconds of being in the game.
	timer.performWithDelay( 4000, 
		function()
			obstacles[4].isVisible = true
		end)
end

--this function checks values frequently so they can be updated at a faster pace.
local function onRedraw()
	--this checks if the obstacle is off the screen and if it is visible,
	--if this is true, the obstacle moves left across the screen.
	if(obstacles[1].x > -55 and obstacles[1].isVisible == true) then
		obstacles[1].x = obstacles[1].x - 3
	end
	--this checks if the obstacle is off the screen and if it is not ready to move
	--if this is true, it sets the readyToMove variable to true, waits an amount of time (1.3 seconds), 
	--then sets the objects x value to the right side of the screen so it can be moved across again.
	if(obstacles[1].x < -55 and readyToMove == false) then
		readyToMove = true
		time = 1300
		timer.performWithDelay( time, 
			function() 
				readyToMove = false
				obstacles[1].x = W+220
			end)
	end

	--this checks if the obstacle is off the screen and if it is visible,
	--if this is true, the obstacle moves left across the screen.
	if(obstacles[2].x > -55 and obstacles[2].isVisible == true) then
		obstacles[2].x = obstacles[2].x - 3
	end
	--this checks if the obstacle is off the screen and if it is not ready to move
	--if this is true, it sets the readyToMove variable to true, waits an amount of time (1.3 seconds), 
	--then sets the objects x value to the right side of the screen so it can be moved across again.
	if(obstacles[2].x < -55 and readyToMove == false) then
		readyToMove = true
		time = 1300
		timer.performWithDelay( time, 
			function() 
				readyToMove = false
				obstacles[2].x = W+220
			end)
	end

	--this checks if the obstacle is off the screen and if it is visible,
	--if this is true, the obstacle moves left across the screen.
	if(obstacles[3].x > -55 and obstacles[3].isVisible == true) then
		obstacles[3].x = obstacles[3].x - 3
		print("moving")
	end
	--this checks if the obstacle is off the screen and if it is not ready to move
	--if this is true, it sets the readyToMove variable to true, waits an amount of time (1.3 seconds), 
	--then sets the objects x value to the right side of the screen so it can be moved across again.
	if(obstacles[3].x < -55 and readyToMove == false) then
		readyToMove = true
		time = 1300
		timer.performWithDelay( time, 
			function() 
				readyToMove = false
				obstacles[3].x = W+220
			end)
	end

	--this checks if the obstacle is off the screen and if it is visible,
	--if this is true, the obstacle moves left across the screen.
	if(obstacles[4].x > -55 and obstacles[4].isVisible == true) then
		obstacles[4].x = obstacles[4].x - 3
	end
	--this checks if the obstacle is off the screen and if it is not ready to move
	--if this is true, it sets the readyToMove variable to true, waits an amount of time (1.3 seconds), 
	--then sets the objects x value to the right side of the screen so it can be moved across again.
	if(obstacles[4].x < -55 and readyToMove == false) then
		readyToMove = true
		time = 1300
		timer.performWithDelay( time, 
			function() 
				readyToMove = false
				obstacles[4].x = W+220
			end)
	end
end

--this function creates a jump button and adds an event listener so that the player jumps when the button is pressed.
local function showJumpBtn()
	local jumpBtn = display.newImage( firstLevel, "assets/buttons/btnUP.png", W/2, H/2)
	jumpBtn:scale( 0.18, 0.18 )
	jumpBtn:toFront()
	jumpBtn:addEventListener( "tap" , jump)
end

--this function creates a slide button and adds an event listener so that the player slides when the button is pressed.
local function showSlideBtn()
	local slideBtn = display.newImage( firstLevel, "assets/buttons/btnDown.png", W*2/5, H/2)
	slideBtn:scale(0.18, 0.18)
	slideBtn:addEventListener("touch", slide)
end


--this adds all the values that needs to be returned from the module for use in another module.
Level1.firstLevel = firstLevel
Level1.menuBtn = menuBtn
Level1.makeObstacles = makeObstacles 
Level1.jumpHandler = jumpHandler
Level1.showJumpBtn = showJumpBtn
Level1.showSlideBtn = showSlideBtn
Level1.slideHandler = slideHandler
Level1.onRedraw = onRedraw

--this returns the table.
return Level1