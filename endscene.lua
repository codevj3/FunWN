

----------------------SCENE ONE------------------------
local composer = require( "composer" )
local scene = composer.newScene();
local soundTable =require("soundTable")


function scene:create( event ) 
    local sceneGroup = self.view
    local bg = display.newImage ("gameover.jpg", display.contentCenterX, display.contentCenterY);
    sceneGroup:insert( bg)
    
    
end
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        audio.play( soundTable["lose"] );

        --Function to go to main page automatically after 4 seconds
   		local function levelselect()	
   			composer.removeScene( "endscene", false )
   			composer.gotoScene( "mainscene", {effect = "slideRight", time = 500} )
   		end	
   		tmr = timer.performWithDelay( 4000, levelselect )	
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
    if (tmr ~= nil) then
    	timer.cancel( tmr )
    end
    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene