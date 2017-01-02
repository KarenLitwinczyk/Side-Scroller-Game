--this is the start menu screen

--this is a table to return any values/objects that will be needed outside the module.
local startTbl = {}

--this keeps track of how many times the music button has been tapped.
local musicButtonTaps = 0
--this keeps track of how many times the sound button has been tapped.
soundButtonTaps = 0

start = display.newGroup( )

--this is the title of the game text.
-- local title = display.newText(start, "Karen's Krazy Kat Game! " , W/2, H/4, "Arial", 40)
-- title:setFillColor(0,0,0)

--this is the button to toggle the music in the game.
local musicBtn = display.newImage( start, "assets/buttons/btnMusic.png", W/3, H/2)
musicBtn.isVisible = false
musicBtn:scale( 0.18, 0.18 )

--this is the text to show the user what the happens when the music button is pressed.
local toggleMusicText = display.newText(start, "Toggle Music", W*5/9, H/2, "Arial", 20)
toggleMusicText.isVisible = false
toggleMusicText:setFillColor(0,0,0)

--this is the button to toggle the sounds in the game.
local soundBtn = display.newImage( start, "assets/buttons/btnSounds.png", W/3, H*3/4 )
soundBtn.isVisible = false
soundBtn:scale( 0.18, 0.18 )

--this is the text to show the user what happens when the sound button is pressed.
local toggleSoundText = display.newText(start, "Toggle Sound", W*5/9, H*3/4, "Arial", 20)
toggleSoundText.isVisible = false
toggleSoundText:setFillColor(0,0,0)

--this button when pressed brings you back to the start menu.
local homeBtn = display.newImage( start, "assets/buttons/btnHome.png", 25, 15 )
homeBtn:scale( 0.18, 0.18)
homeBtn.isVisible = false

--this is the text to show the user what screen they are on.
local settingsText = display.newText(start, "Settings", W/2, H/4, "Arial", 30)
settingsText.isVisible = false
settingsText:setFillColor(0,0,0)

--this is the button to display the info screen of the game when pressed, with directions on how to play the game.
local btnDirection = display.newImage(start, "assets/buttons/btnInfo.png", W-25, H -5)
btnDirection:scale(0.18, 0.18)

--this is the button to display the settings screen when it is pressed.
local btnSettings = display.newImage(start, "assets/buttons/btnSettings.png", 25, H-5)
btnSettings:scale( 0.18, 0.18 )

--this is the button to start the game when it is pressed.
local startBtn = display.newImage(start, "assets/buttons/btnRight.png", W/2, H/2)
startBtn:scale(0.5, 0.5)

--this button is to show the user what the slide button looks like in the game while they are on the info screen.
local slideBtn = display.newImage(start, "assets/buttons/btnDown.png", W/2, H*3/4)
slideBtn:scale( 0.18, 0.18 )
slideBtn.isVisible = false

--this button is to show the user what the jump button looks like in the game while they are on the info screen.
local jumpBtn = display.newImage( start, "assets/buttons/btnUP.png", W/2, H/2)
jumpBtn:scale( 0.18, 0.18 )
jumpBtn.isVisible = false

--this is the text to show the user what the slide button does when they are in the game.
local slideText = display.newText(start, "Press To Slide", W*3/4, H*3/4, "Arial", 20)
slideText:setFillColor( 0,0,0 )
slideText.isVisible = false

--this is the text to show the user what the jump button does when they are in the game.
local jumpText = display.newText(start, "Press To Jump", W*3/4, H/2, "Arial", 20)
jumpText:setFillColor( 0,0,0 )
jumpText.isVisible = false

--this function displays the settings screen where the user can toggle game sounds and music.
local function settingsScreen()
	--title.isVisible = false
	startBtn.isVisible = false
	btnDirection.isVisible = false
	btnSettings.isVisible = false
	musicBtn.isVisible = true
	toggleMusicText.isVisible = true
	btnSettings.isVisible = true
	soundBtn.isVisible = true
	toggleSoundText.isVisible = true
	homeBtn.isVisible = true
	settingsText.isVisible = true
	jumpBtn.isVisible = false
	jumpText.isVisible = false
	slideText.isVisible = false
	slideBtn.isVisible = false
end

--this function displays the screen for how to play the game.
local function infoScreen()
	--title.isVisible = false
	startBtn.isVisible = false
	btnSettings.isVisible = false
	musicBtn.isVisible = false
	toggleMusicText.isVisible = false
	toggleSoundText.isVisible = false
	homeBtn.isVisible = true
	settingsText.isVisible = false
	jumpBtn.isVisible = true
	jumpText.isVisible = true
	slideText.isVisible = true
	slideBtn.isVisible = true
	
end

--displays the menu screen again when the "home button" is pressed.
local function backToMenu()
	--title.isVisible = true
	musicBtn.isVisible = false
	toggleMusicText.isVisible = false
	soundBtn.isVisible = false
	toggleSoundText.isVisible = false
	btnDirection.isVisible = true
	homeBtn.isVisible = false
	btnSettings.isVisible = true
	settingsText.isVisible = false
	startBtn.isVisible = true
	slideText.isVisible = false
	slideBtn.isVisible = false
	jumpText.isVisible = false
	jumpBtn.isVisible = false
end

--this function increments the button taps variable by 1 everytime the sound button is clicked.
local function soundBtnTapped()
	soundButtonTaps = soundButtonTaps + 1
end

--this function keeps to see if the music button has been tapped an even number of times 
--if so it will play the background music, if not it will pause the music.
local function musicBtnTapped()
	musicButtonTaps = musicButtonTaps + 1
	if(musicButtonTaps % 2 == 0) then
		audio.resume(backgroundMusic)
		print("music play")
	else
		audio.pause(backgroundMusic)
	end
end	
--this is a table for all the values that need to be return and referenced to outside the module.
startTbl.btnDirection = btnDirection
startTbl.btnSettings = btnSettings
startTbl.startBtn = startBtn
startTbl.infoScreen = infoScreen
startTbl.backToMenu = backToMenu
startTbl.startGame = startGame
startTbl.start = start
startTbl.musicBtn = musicBtn
startTbl.soundBtn = soundBtn
startTbl.settingsScreen = settingsScreen
startTbl.homeBtn = homeBtn
startTbl.musicBtnTapped = musicBtnTapped
startTbl.soundBtnTapped = soundBtnTapped
--this returns the table.
return startTbl