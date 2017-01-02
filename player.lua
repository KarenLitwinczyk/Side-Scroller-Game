--this makes a player sprite

--this imports the physics module, so physics and methods of physics are able to be used.
local physics = require("physics")
physics.start()

--this is a table to return any values/objects needed outside the module.
local Player = {}

--this is the width and height of each individual image, and the number of frames that are in the Sprite Sheet.
local playerOptions = {
	width = 508,
	height = 444,
	numFrames = 36
}

--this makes a player sheet with the sprite sheet added and the options for each image.
local playerSheet = graphics.newImageSheet( "assets/cat/CatSheet.png", playerOptions)

--this defines different sequences of player actions that will be used within the game.
local playerSeqData = { 
	-- "Dead" is frames 1-10
	{name = "dead", frames = {1, 3, 4, 5, 6, 7, 8,9,10, 2}, time = 1300, loopCount = 1, loopDirection = "forward"},
	-- "Jump" is frames 11- 18
	{name = "jump", start = 11, count = 8, time = 1000, loopCount = 1, loopDirection = "forward"},
	-- "Run" is frames 19 - 26
	{name = "run", start = 19, count = 8, time = 900, loopCount = 0, loopDirection = "forward"},
	-- "Slide" is frames 27 - 36
	{name = "slide", start = 27, count = 9, time = 900, loopCount= 0, loopDirection = "forward"}


}

--this creates a sprite usable for in game and to display different sequences upon request.
local playerSprite = display.newSprite( playerSheet, playerSeqData )

--this defines a physics body shape for the player when they are standing up (running).
local playerShape = {-27, -30, 27, -30, 27, 40, -27, 40}

--this defines a physics body shape for the player when they are laying down (sliding).
local slidingShape = {-20, -20, 20, -20, 27, 40, -27, 40}

--this adds a physics body to the player with the shape fit for running.
physics.addBody( playerSprite, "dynamic", { bounce = 0,shape=playerShape})

--this reduces the rotation of the player when they collide with another object.
playerSprite.angularDamping = 5000

--this sets the type of the player to "player".
playerSprite.type = "player"

--this adds objects to the table so they can be returned and referenced back to in another module.
Player.playerSprite = playerSprite
Player.slidingShape = slidingShape
Player.playerShape = playerShape

--this returns table.
return Player