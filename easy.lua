

local composer = require( "composer" )

composer.removeScene( "level1", true )
local soundTable =require("soundTable")
local scene = composer.newScene();
local widget = require( "widget" );
local score = 0;

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

local cross_options =
{
  frames = 
  {
    { x = 285, y = 15, width = 188, height = 185}, --0
  } 
};
local crossData = {
  {name = "cross", frames={1}}
}

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

local heart_options =
{
  frames = 
  {
    { x = 24, y = 162, width = 156, height = 128}, --full
    { x = 24, y = 303, width = 156, height = 128}, --break

  } 
};

local heartData = {
  {name = "heart", frames={1}}
}

local heartbreakData = {
  {name = "heartbreak",frames={2}}
}
  


local op_options =
{
  frames = 
  {
    { x = 65, y = 61, width = 89, height = 89}, --add
    { x = 65, y = 168, width = 89, height = 84}, --sub
    { x = 250, y = 168, width = 80, height = 84}, --mul
    { x = 250, y = 59, width = 90, height = 60}, --equal
  }
};

local opseqData = {
  {name = "add", frames={1}}, 
  {name = "sub", frames={2}},
  {name = "mul", frames={3}},
  {name = "equal", frames={4}}
}

local div_options =
{
  frames = 
  {
    { x = 60, y = 45, width = 45, height = 35}, --add
  }
};

local divseqData = {
  {name = "div", frames={1}}
}

local bluenum_sheet = graphics.newImageSheet( "number.png", blue_options );

local rednum_sheet = graphics.newImageSheet( "number.png", red_options );

local op_sheet = graphics.newImageSheet( "operator.png", op_options );

local div_sheet = graphics.newImageSheet( "div.png",div_options);

local cross_sheet = graphics.newImageSheet( "cross.png", cross_options )

local heart_sheet = graphics.newImageSheet( "heart.png", heart_options )


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
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then

        display.setDefault("background", 1, 1, 1)

        local scoreText = display.newText ({text="Score : "..score,x=display.contentCenterX, y=20,fontSize=20, font="Arial Black"});
        scoreText:setFillColor(0,0,0)

        sceneGroup:insert(scoreText);

        -- Keep track of time in seconds
        local secondsLeft =1 * 60   -- 20 minutes * 60 seconds

        local clockText = display.newText("1:00", 340, 20, native.systemFontBold, 20)
        clockText:setFillColor(0,0,0)
         sceneGroup:insert(clockText );

        --Function to update the clock
        local function updateTime()
            -- decrement the number of seconds
            secondsLeft = secondsLeft - 1
            
            -- time is tracked in seconds.  We need to convert it to minutes and seconds
            local minutes = math.floor( secondsLeft / 60 )
            local seconds = secondsLeft % 60
            if(seconds==00) then
                --Go to gameover screen
                composer.removeScene( "easy", false )
                local options =
                { 
                    effect = "slideRight",
                    params= {ids = score},
                    time = 500
                }
                
                composer.gotoScene( "score", options)
            end
            
            -- make it a string using string format. 
            local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
            clockText.text = timeDisplay
        end

        -- run them timer
        countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
        

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


        -------------------------------Sprite Declaration-------------------------
    	number1sprite = display.newSprite( rednum_sheet, seqData)
        number1sprite.x = display.contentCenterX-130;
        number1sprite.y = display.contentCenterY;
        number1sprite:setFrame(1);
        number1sprite:scale(.5, .5);

        number2sprite = display.newSprite( rednum_sheet, seqData)
        number2sprite.x = display.contentCenterX-10;
        number2sprite.y = display.contentCenterY;
        number2sprite:scale(.5, .5);

        equalsprite = display.newSprite( op_sheet, opseqData)
        equalsprite.x = display.contentCenterX+40;
        equalsprite.y = display.contentCenterY;
        equalsprite:scale(.5,.5)
        equalsprite:setSequence( "equal" )

        number3sprite = display.newSprite( rednum_sheet, seqData)
        number3sprite.x = display.contentCenterX+90;
        number3sprite.y = display.contentCenterY;
        number3sprite:scale(.5, .5);
        number3sprite.alpha = 0;

        number4sprite = display.newSprite( rednum_sheet, seqData)
        number4sprite.x = display.contentCenterX+140;
        number4sprite.y = display.contentCenterY;
        number4sprite:scale(.5, .5);
        number4sprite.alpha = 0;

        crsprite = display.newSprite( cross_sheet, crossData)
        crsprite.x = display.contentCenterX+110;
        crsprite.y = display.contentCenterY;
        crsprite:scale(.3, .3);
        crsprite.alpha = 0;

        sceneGroup:insert(number1sprite)
        sceneGroup:insert(number2sprite)
        sceneGroup:insert(number3sprite)
        sceneGroup:insert(number4sprite)
        sceneGroup:insert(equalsprite)
        sceneGroup:insert(crsprite)

        heart1sprtie = display.newSprite( heart_sheet, heartData )
        heart1sprtie.x = -30
        heart1sprtie.y = 20
        heart1sprtie:scale(.17,.17)

        heart2sprtie = display.newSprite( heart_sheet, heartData )
        heart2sprtie.x = -3
        heart2sprtie.y = 20
        heart2sprtie:scale(.17,.17)

        heart3sprtie = display.newSprite( heart_sheet, heartData )
        heart3sprtie.x = 24
        heart3sprtie.y = 20
        heart3sprtie:scale(.17,.17)

        hb1sprtie = display.newSprite( heart_sheet, heartbreakData )
        hb1sprtie.x = -30
        hb1sprtie.y = 20
        hb1sprtie:scale(.17,.17)
        hb1sprtie.alpha = 0;

        hb2sprtie = display.newSprite( heart_sheet, heartbreakData )
        hb2sprtie.x = -3
        hb2sprtie.y = 20
        hb2sprtie:scale(.17,.17)
        hb2sprtie.alpha = 0;

        hb3sprtie = display.newSprite( heart_sheet, heartbreakData )
        hb3sprtie.x = 24
        hb3sprtie.y = 20
        hb3sprtie:scale(.17,.17)
        hb3sprtie.alpha = 0;

        sceneGroup:insert(heart1sprtie);
        sceneGroup:insert(heart2sprtie)
        sceneGroup:insert(heart3sprtie)

        sceneGroup:insert(hb1sprtie)
        sceneGroup:insert(hb2sprtie)
        sceneGroup:insert(hb3sprtie)
    

        
        rs1sprite = display.newSprite( bluenum_sheet, seqData)
        rs1sprite.x = display.contentCenterX-140;
        rs1sprite.y = display.contentCenterY + 81;
        rs1sprite:scale(.2, .2);

        rs2sprite = display.newSprite( bluenum_sheet, seqData)
        rs2sprite.x = display.contentCenterX-120;
        rs2sprite.y = display.contentCenterY + 81;
        rs2sprite:scale(.2, .2);

        rs3sprite = display.newSprite( bluenum_sheet, seqData)
        rs3sprite.x = display.contentCenterX-60;
        rs3sprite.y = display.contentCenterY + 81;
        rs3sprite:scale(.2, .2);

        rs4sprite = display.newSprite( bluenum_sheet, seqData)
        rs4sprite.x = display.contentCenterX-40;
        rs4sprite.y = display.contentCenterY + 81;
        rs4sprite:scale(.2, .2);

        rs5sprite = display.newSprite( bluenum_sheet, seqData)
        rs5sprite.x = display.contentCenterX+20;
        rs5sprite.y = display.contentCenterY + 81;
        rs5sprite:scale(.2, .2);

        rs6sprite = display.newSprite( bluenum_sheet, seqData)
        rs6sprite.x = display.contentCenterX+40;
        rs6sprite.y = display.contentCenterY + 81;
        rs6sprite:scale(.2, .2);

        rs7sprite = display.newSprite( bluenum_sheet, seqData)
        rs7sprite.x = display.contentCenterX+100;
        rs7sprite.y = display.contentCenterY + 81;
        rs7sprite:scale(.2, .2);

        rs8sprite = display.newSprite( bluenum_sheet, seqData)
        rs8sprite.x = display.contentCenterX+120;
        rs8sprite.y = display.contentCenterY + 81;
        rs8sprite:scale(.2, .2);

        operatorsprite = display.newSprite( op_sheet, opseqData)
        operatorsprite.x = display.contentCenterX-70;
        operatorsprite.y = display.contentCenterY;
        operatorsprite:scale(.5,.5)
        operatorsprite.alpha = 0;

        divsprite = display.newSprite(div_sheet,divseqData)
        divsprite.x = display.contentCenterX-70;
        divsprite.y = display.contentCenterY;
        divsprite.alpha = 0;

        sceneGroup:insert(rs1sprite)
        sceneGroup:insert(rs2sprite)
        sceneGroup:insert(rs3sprite)
        sceneGroup:insert(rs4sprite)
        sceneGroup:insert(rs5sprite)
        sceneGroup:insert(rs6sprite)
        sceneGroup:insert(rs7sprite)
        sceneGroup:insert(rs8sprite)

        sceneGroup:insert(operatorsprite)
        sceneGroup:insert(divsprite)
        
        --------------------------------------Operations to generate number -------------------------------
        local function generateNumber()

           --Based on the operation choosed random number is generated
            op = math.random(1,4)

            --Choosing a number
            if(op== 4) then
                check = 1;
                while(check ==1) do
                    number1 = math.random( 0, 9 )
                    number2 = math.random( 0, 9 )
                    if(number1 % number2==0 and number1~=0 and number2~=0) then
                        check =0
                    end
                end
                number3 = number1 / number2
            elseif(op==3) then
                number1 = math.random( 0, 9 )
                number2 = math.random( 0, 9 )
                number3 = number1 * number2
            elseif(op==2) then
                number1 = math.random( 0, 9 )
                number2 = math.random( 0, 9 )
                if(number1 < number2) then
                    temp = number1;
                    number1 = number2;
                    number2 = temp;
                end
                number3 = number1 - number2
            elseif(op == 1) then
                number1 = math.random( 0, 9 )
                number2 = math.random( 0, 9 )
                number3 = number1 + number2
            end

            if(op == 1 or op==2 or op==3) then
                if(divsprite~=nil) then
                    divsprite.alpha = 0
                end
                operatorsprite:setSequence( operators[op] )
                operatorsprite.alpha = 1;
            else
                if(operatorsprite~=nil) then
                    operatorsprite.alpha = 0;
                end
                divsprite.alpha = 1
            end


            number1sprite:setSequence( frames[number1] )
            number2sprite:setSequence( frames[number2] )

            number3sprite.alpha = 0;
            number4sprite.alpha = 0;
            crsprite.alpha = 0;

            ---Postion of the answer is randamozied
            answerposition = math.random( 1, 4 )
            answers = {}
            answers[answerposition] = number3

            --Other options are generated
            for i=1,4 do
                if(answers[i]==nil) then
                    if(number3 - 20 <= 0) then
                        answers[i] = math.random( 0, number3 + 20 )
                    else
                        answers[i] = math.random( number3 - 20, number3 + 20 )
                    end
                end
                if(answers[i] >=10) then
                    number4 = "'"..answers[i].."'";
                    n1 = tonumber( number4:sub(2,2) )
                    n2 = tonumber( number4:sub(3,3) )                
                    if( i == 1) then
                        rs1sprite:setSequence( frames[n1] )
                        rs2sprite:setSequence( frames[n2] )
                    elseif(i==2) then
                        rs3sprite:setSequence( frames[n1] )
                        rs4sprite:setSequence( frames[n2] )
                    elseif(i==3) then
                        rs5sprite:setSequence( frames[n1] )
                        rs6sprite:setSequence( frames[n2] )
                    elseif(i==4) then
                        rs7sprite:setSequence( frames[n1] )
                        rs8sprite:setSequence( frames[n2] )
                    end
                else
                    if( i == 1) then
                        rs1sprite:setSequence( frames[0] )
                        rs2sprite:setSequence( frames[answers[i]] )
                    elseif(i==2) then
                        rs3sprite:setSequence( frames[0] )
                        rs4sprite:setSequence( frames[answers[i]] )
                    elseif(i==3) then
                        rs5sprite:setSequence( frames[0] )
                        rs6sprite:setSequence( frames[answers[i]] )
                    elseif(i==4) then
                        rs7sprite:setSequence( frames[0] )
                        rs8sprite:setSequence( frames[answers[i]] )
                    end
                end
            end
        end

        generateNumber()


        ---Functon to check the answer and move to next question
        local function checkAnswer(event)
                    
            if(number3 == answers[event.target.id]) then
                audio.play( soundTable["option"] );
                score = score + 1;
                scoreText.text = "Score : "..score
                if(number3 >=10) then
                    local number4 = "'"..number3.."'";
                    n1 = tonumber( number4:sub(2,2) )
                    n2 = tonumber( number4:sub(3,3) )
                    number3sprite:setSequence( frames[n1] )
                    number4sprite:setSequence( frames[n2] )
                    number3sprite.alpha = 1;
                    number4sprite.alpha = 1;
                else
                    number3sprite:setSequence( frames[number3] )
                    number3sprite.alpha = 1;
                end
                Timer = timer.performWithDelay( 2000, generateNumber)
            else
                audio.play( soundTable["wrong"] );
                system.vibrate()
                crsprite.alpha = 1
                life = life - 1;
                if(life == 2) then
                    heart3sprtie.alpha= 0;
                    hb3sprtie.alpha = 1;
                    timer.performWithDelay( 2000, generateNumber)
                elseif life ==1 then
                    heart2sprtie.alpha = 0;
                    hb2sprtie.alpha =1;
                    timer.performWithDelay( 2000, generateNumber)
                elseif(life <= 0) then
                    heart1sprtie.alpha = 0;
                    hb1sprtie.alpha =1;
                    timer.performWithDelay( 1000,function () 
                        composer.removeScene( "easy", false )
                        composer.gotoScene( "endscene", {effect = "slideRight", time = 500})
                        end )
                end
            end
        end


        --------------------------------Using circles to detect the options-----------------------
        
        local c1 = display.newCircle( display.contentCenterX-130, display.contentCenterY + 80,30 )
        c1.alpha = 0.2
        c1.id = 1
        c1:setFillColor( 0,0,0)
        c1:addEventListener( "tap", checkAnswer)

        local c2 = display.newCircle( display.contentCenterX - 50, display.contentCenterY + 80,30 )
        c2.alpha = 0.2
        c2.id = 2
        c2:setFillColor( 0,0,0)
        c2:addEventListener( "tap", checkAnswer )
        --c2:setFillColor( 0.5 )

        local c3 = display.newCircle( display.contentCenterX +30, display.contentCenterY + 80,30 )
        c3.alpha = 0.2
        c3.id = 3
        c3:setFillColor( 0,0,0)
        c3:addEventListener( "tap", checkAnswer )
        --c2:setFillColor( 0.5 )

        local c4 = display.newCircle( display.contentCenterX+ 110, display.contentCenterY + 80,30 )
        c4.alpha = 0.2
        c4.id = 4
        c4:setFillColor( 0,0,0)
        --c2:setFillColor( 0.5 )
        c4:addEventListener( "tap", checkAnswer )

        sceneGroup:insert(c1)
        sceneGroup:insert(c2)
        sceneGroup:insert(c3)
        sceneGroup:insert(c4)
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        timer.cancel( countDownTimer )

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