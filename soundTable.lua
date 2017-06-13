

--Sound Table decribed and returned for further usages

local soundTable = {
	win = audio.loadSound( "win.wav" ), 
	lose = audio.loadSound( "lose.wav" ), 
	option = audio.loadSound( "options.wav" ), 
	button = audio.loadSound( "buttons.wav" ),
	wrong = audio.loadSound( "wrong.wav")
}
return soundTable;