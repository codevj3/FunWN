

local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )
local soundTable =require("soundTable")


----- On scene create-----
function scene:create( event )
    local sceneGroup = self.view
    	--To display white background
        display.setDefault("background", 1, 1, 1)
end


-- On scene show--------------
function scene:show( event )
    local sceneGroup = self.view
    --local phase = event.phase
    if ( event.phase == "will" ) then


 
    elseif ( event.phase == "did" ) then
    	local bg = display.newImage ("bg1.jpg", display.contentCenterX, display.contentCenterY);
        bg:toBack();
        local bg1 = display.newImage ("mathathon.jpg", display.contentCenterX, display.contentCenterY-50);
        bg1:toFront();
        bg1:scale(0.5,0.5)

    	--Score of the game is displayed using params
        local score = event.params.ids;

        local scoreText = display.newText ({text="Score : "..score,x=display.contentCenterX, y=display.contentCenterY,fontSize=20,font="Arial Black"});
        scoreText:setFillColor(0,0,0)


        audio.play( soundTable["win"] );
        
        
        sceneGroup:insert(bg)
        sceneGroup:insert(bg1)

        local options = 
        { 
          effect = "fade",
          time = 800 

        }

        local btnOpt =
                {
                frames = {
                { x = 3, y = 2, width=70, height = 22}, --frame 1
                { x = 78, y = 2, width=70, height = 22}, --frame 2
                }
                };


        local buttonSheet = graphics.newImageSheet( "button.png", btnOpt );

        --Function to go to specified level on cick of the button
        local function toLevel(event)
            audio.play( soundTable["button"] );
            --To remove the score text
            if(scoreText~=nil) then
                scoreText:removeSelf()
            end
            --To remove the
            if(event.target.id == "lvl1") then
                composer.removeScene( "mainscene", false )
                composer.gotoScene("easy", options);
            elseif(event.target.id == "lvl2") then
                composer.removeScene( "mainscene", false )
                composer.gotoScene("medium", options);
            elseif(event.target.id == "lvl3") then
                composer.removeScene( "mainscene", false )
                composer.gotoScene("hard", options);
            elseif(event.target.id == "learn") then
                composer.removeScene( "mainscene", false )
                composer.gotoScene("learn", options);
            end
        end

        --Buttons for Easy,Medium,Hard and Learn
         learn = widget.newButton(
                    {
                    x = display.contentCenterX ,
                    y = display.contentCenterY +40,
                    id = "learn",
                    label = "Learn",
                    font = "Monotype Corsiva",
                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                    sheet = buttonSheet,
                    defaultFrame = 1,
                    overFrame = 2,
                    onPress = toLevel,
                    }
                    );


        level1 = widget.newButton(
                    {
                    x = display.contentCenterX - 100,
                    y = display.contentCenterY +90,
                    id = "lvl1",
                    label = "Easy",
                    font = "Monotype Corsiva",
                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                    sheet = buttonSheet,
                    defaultFrame = 1,
                    overFrame = 2,
                    onPress = toLevel,
                    }
                    );

        level2 = widget.newButton(
                    {
                    x = display.contentCenterX ,
                    y = display.contentCenterY +90,
                    id = "lvl2",
                    label = "Medium",
                    font = "Monotype Corsiva",
                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                    sheet = buttonSheet,
                    defaultFrame = 1,
                    overFrame = 2,
                    onPress = toLevel,
                    }
                    );

        level3 = widget.newButton(
                    {
                    x = display.contentCenterX + 100,
                    y = display.contentCenterY +90,
                    id = "lvl3",
                    label = "Hard",
                    font = "Monotype Corsiva",
                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                    sheet = buttonSheet,
                    defaultFrame = 1,
                    overFrame = 2,
                    onPress = toLevel,
                    }
                    );
        sceneGroup:insert(learn)
        sceneGroup:insert(level1)
        sceneGroup:insert(level2)
        sceneGroup:insert(level3)
    end

end

-- On scene hide...
function scene:hide( event )
    local sceneGroup = self.view
 
    if ( event.phase == "will" ) then
    	

    elseif (event.phase == "did" ) then

    end
end

-- On scene destroy...
function scene:destroy( event )
    local sceneGroup = self.view   
end
 
-- Composer scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene
