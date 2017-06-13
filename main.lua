


local composer = require( "composer" )
local scene = composer.newScene()

--Options of the composer
local options = 
{ 
  effect = "fade",
  time = 50
}


--Go to mainscene
composer.gotoScene("mainscene", options);
