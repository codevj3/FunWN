

local composer = require( "composer" )

composer.removeScene( "level1", true )
local soundTable =require("soundTable")
local scene = composer.newScene();
local widget = require( "widget" );

-----------------------------------------------Sprite Descriptions--------------------------------------------
local red_options =
{
  frames = 
  {
    { x = 4, y = 144, width = 85, height = 100}, --0
    { x = 101, y = 144, width = 70, height = 100}, --1
    { x = 178, y = 144, width = 86, height = 100}, --2
    { x = 271, y = 144, width = 87, height = 100}, --3 
    { x = 366, y = 144, width = 80, height = 100}, --4
    { x = 455, y = 144, width = 90, height = 100}, --5
    { x = 551, y = 144, width = 86, height = 100}, --6
    { x = 640, y = 144, width = 91, height = 100}, --7
    { x = 739, y = 144, width = 86, height = 100}, --8
    { x = 833, y = 144, width = 87, height = 100}, --9
  }
};

local blue_options =
{
  frames = 
  {
    { x = 4, y = 338, width = 85, height = 100}, --0
    { x = 101, y = 338, width = 70, height = 100}, --1
    { x = 178, y = 338, width = 86, height = 100}, --2
    { x = 271, y = 338, width = 87, height = 100}, --3 
    { x = 366, y = 338, width = 80, height = 100}, --4
    { x = 455, y = 338, width = 90, height = 100}, --5
    { x = 551, y = 338, width = 86, height = 100}, --6
    { x = 640, y = 338, width = 91, height = 100}, --7
    { x = 739, y = 338, width = 86, height = 100}, --8
    { x = 833, y = 338, width = 87, height = 100}, --9
  } 
};


local seqData = {
  {name = "zero", frames={1}}, 
  {name = "one", frames={2}}, 
  {name = "two", frames={3}},
  {name = "three", frames={4}},
  {name = "four", frames={5}},
  {name = "five", frames={6}},
  {name = "six", frames={7}},
  {name = "seven", frames={8}},
  {name = "eight", frames={9}},
  {name = "nine", frames={10}},
}


local arrowr_options =
{
  frames = 
  {
    { x = 15, y = 58, width = 100, height = 162}--0
  } 
};
local rightData = {
  {name = "right", frames={1}}
}

local arrowl_options =
{
  frames = 
  {--
    { x = 228, y = 58, width = 100, height = 162},--0
  } 
};
local leftData = {
  {name = "left", frames={1}}
}
local btnOpt =
                {
                frames = {
                { x = 3, y = 2, width=70, height = 22}, --frame 1
                { x = 78, y = 2, width=70, height = 22}, --frame 2
                }
                };

  

local bluenum_sheet = graphics.newImageSheet( "number.png", blue_options );

local rednum_sheet = graphics.newImageSheet( "number.png", red_options );

local arrowr_sheet = graphics.newImageSheet( "arrows.png",arrowr_options);

local arrowl_sheet = graphics.newImageSheet( "arrows.png",arrowl_options);

local buttonSheet = graphics.newImageSheet( "button.png", btnOpt );


local number1 = nil;
local number2 = nil;
local number3 = nil;
local divsprite = nil;
local operatorsprite = nil;
local answers = nil;
local answered = nil;
local score = 0;
local life = 3;
 local countDownTimer =nil;

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    local bg = display.newImage ("bg3.jpg", display.contentCenterX, display.contentCenterY);
    sceneGroup:insert( bg)

    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
    	local number3 = 0;
        display.setDefault("background", 1, 1, 1)

        frames = {[0]="zero",
        		  [1]="one",
        		  [2]="two",
        		  [3]="three",
        		  [4]="four",
        		  [5]="five",
        		  [6]="six",
        		  [7]="seven",
        		  [8]="eight",
        		  [9]="nine"}

        operators = {[1]="add",
    				 [2]="sub",
    				 [3]="mul",
                     [4]="div"}

	   	alpha = {[0]="Zero",
		  [1]="One",
		  [2]="Two",
		  [3]="Three",
		  [4]="Four",
		  [5]="Five",
		  [6]="Six",
		  [7]="Seven",
		  [8]="Eight",
		  [9]="Nine",
		  [10]="Ten",
		  [11]="Eleven",
		  [12]="Twelve",
		  [13]="Thirteen",
		  [14]="Fourteen",
		  [15]="Fifteen",
		  [16]="Sixteen",
		  [17]="Seventeen",
		  [18]="Eightteen",
		  [19]="Nineteen",
		  [20]="Twenty",
		  [21]="Twentyone",
		  [22]="TwentyTwo",
		  [23]="TwentyThree",
		  [24]="TwentyFour",
		  [25]="TwentyFive",
		  [26]="TwentySix",
		  [27]="TwentySeven",
		  [28]="TwentyEight",
		  [29]="TwentyNine",[30]="Thirty",
		  [31]="ThirtyOne",
		  [32]="ThirtyTwo",
		  [33]="ThirtyThree",
		  [34]="ThirtyFour",
		  [35]="ThirtyFive",
		  [36]="ThirtySix",
		  [37]="ThirtySeven",
		  [38]="ThirtyEight",
		  [39]="ThirtyNine",
		  [40]="Forty",
		  [41]="FortyOne",
		  [42]="FortyTwo",
		  [43]="FortyThree",
		  [44]="FortyFour",
		  [45]="FortyFive",
		  [46]="FortySix",
		  [47]="FortySeven",
		  [48]="FortyEight",
		  [49]="FortyNine",
		  [50]="Fifty",
		  [51]="FiftyOne",
		  [52]="FiftyTwo",
		  [53]="FiftyThree",
		  [54]="FiftyFour",
		  [55]="FiftyFive",
		  [56]="FiftySix",
		  [57]="FiftySeven",
		  [58]="FiftyEight",
		  [59]="FiftyNine"}


        number1sprite = display.newSprite( rednum_sheet, seqData)
        number1sprite.x = display.contentCenterX-50;
        number1sprite.y = display.contentCenterY;
        number1sprite:scale(.8, .8);

        number2sprite = display.newSprite( rednum_sheet, seqData)
        number2sprite.x = display.contentCenterX+30;
        number2sprite.y = display.contentCenterY;
        number2sprite:scale(.8, .8);

        local scoreText = display.newText ({text="Zero",x=display.contentCenterX, y=display.contentCenterY+80,fontSize=30,font="Arial Black"});
        scoreText:setFillColor(0,0,0)

        --Function to decrement the number and show
        local function moveRight()
        	if(number3 > 0) then
        		audio.play( soundTable["option"] );
        		number3 = number3 -1
        		scoreText.text = alpha[number3]
        		if(number3 >=10) then
	    	        local number4 = "'"..number3.."'";
	    	        n1 = tonumber( number4:sub(2,2) )
	    	        n2 = tonumber( number4:sub(3,3) )
	    	        number1sprite:setSequence( frames[n1] )
	    	        number2sprite:setSequence( frames[n2] )
	    		else
	    			 number1sprite:setSequence( frames[0] )
	    			 number2sprite:setSequence( frames[number3] )
	    		end
        	end
        end

        --Function to increment the number and show
        local function moveLeft()
			
        	if(number3 >= 0) then
        		audio.play( soundTable["option"] );
        		number3 = number3 + 1
        		scoreText.text = alpha[number3]
        		if(number3 >=10) then
	    	        local number4 = "'"..number3.."'";
	    	        n1 = tonumber( number4:sub(2,2) )
	    	        n2 = tonumber( number4:sub(3,3) )
	    	        number1sprite:setSequence( frames[n1] )
	    	        number2sprite:setSequence( frames[n2] )
	    		else
	    			 number1sprite:setSequence( frames[0] )
	    			number2sprite:setSequence( frames[number3] )
	    		end
        	end
        end

    	

        rightsprite = display.newSprite( arrowr_sheet, rightData )
        rightsprite.x = display.contentCenterx;
        rightsprite.y = display.contentCenterY-15;
        rightsprite:scale(.6, .6);
        rightsprite:addEventListener( "tap", moveRight )

        leftsprite = display.newSprite( arrowl_sheet, leftData )
        leftsprite.x = display.contentCenterX+150;
        leftsprite.y = display.contentCenterY-15;
        leftsprite:scale(.6, .6);
        leftsprite:addEventListener( "tap", moveLeft )

        sceneGroup:insert(rightsprite)
        sceneGroup:insert(leftsprite)
        sceneGroup:insert(scoreText)

        sceneGroup:insert(number1sprite)
        sceneGroup:insert(number2sprite)


        --Function to go back to main screen
        local function toLevel(event)
        	if(event.target.id == "play") then
                composer.removeScene( "learn", false )
                composer.gotoScene("mainscene", options);
            end
        end

        --Button to go back to main screen

        play = widget.newButton(
                    {
                    x = display.contentCenterX +150,
                    y = display.contentCenterY +90,
                    id = "play",
                    label = "Play",
                    font = "Monotype Corsiva",
                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                    sheet = buttonSheet,
                    defaultFrame = 1,
                    overFrame = 2,
                    onPress = toLevel,
                    }
                    );

        sceneGroup:insert(play)
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

-- -------------------------------------------------------------------------------

return scene