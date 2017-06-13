

local composer = require( "composer" )

composer.removeScene( "level1", true )
local soundTable =require("soundTable")
local scene = composer.newScene();
local widget = require( "widget" );
local score = 0;
local life = 5;

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

local heart_sheet = graphics.newImageSheet( "heart.png", heart_options )

local number1 = nil;
local number2 = nil;
local number3 = nil;
local divsprite = nil;
local operatorsprite = nil;
local answers = nil;
local answered = nil;
local score = 0;
local life = 5;
local countDownTimer =nil;
local op = 0;

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    local background= display.newImage ("bg3.jpg", display.contentCenterX, display.contentCenterY);
    sceneGroup:insert( background );
    

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

        display.setDefault("background", 1, 1, 1)
        local scoreText = display.newText ({text="Score : "..score,x=display.contentCenterX, y=20,fontSize=20, font="Arial Black"});
        scoreText:setFillColor(0,0,0)

        -- sceneGroup:insert(lifeText);
        sceneGroup:insert(scoreText);

        -- Keep track of time in seconds
        local secondsLeft = 1 * 60   -- 20 minutes * 60 seconds

        local clockText = display.newText("2:00", 340, 20, native.systemFontBold, 20)
        clockText:setFillColor(0,0,0)
         sceneGroup:insert(clockText );

         -----Function to update the time
        local function updateTime()
            -- decrement the number of seconds
            secondsLeft = secondsLeft - 1
            
            -- time is tracked in seconds.  We need to convert it to minutes and seconds
            local minutes = math.floor( secondsLeft / 60 )
            local seconds = secondsLeft % 60
            if(seconds==00 and minutes==00) then
                --Go to gameover screen
               local options =
                { 
                    effect = "slideRight",
                    params= {ids = score},
                    time = 500
                }
                composer.removeScene( "hard", false )
                composer.gotoScene( "score", options)
            end
            
            -- make it a string using string format. 
            local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
            clockText.text = timeDisplay
        end

        -- run them timer
        countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
        --exitTimer = timer.performWithDelay( 120000, goToLevel2 )
        

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

        questions = {[1]="Tap the numbers in ascending order",
                     [2]="Tap the numbers in decending order",
                     [3]="which one of the following is a sqaure root of ",
                     [4]="which one of the following is a cube root of ",
                     [5]="which one of the following is a multiple of ",
                     [6]="which one of the following is a prime number?",
                     [7]="which one of the following is a palindrome?"}


        local questionText = display.newText ({text=questions[1],x=display.contentCenterX, y=display.contentCenterY-20,fontSize=20});
        questionText:setFillColor(0,0,0)

        sceneGroup:insert(questionText)
        
        rs1sprite = display.newSprite( rednum_sheet, seqData)
        rs1sprite.x = display.contentCenterX-140;
        rs1sprite.y = display.contentCenterY +40;
        rs1sprite:scale(.2, .2);

        rs2sprite = display.newSprite( rednum_sheet, seqData)
        rs2sprite.x = display.contentCenterX-120;
        rs2sprite.y = display.contentCenterY + 40;
        rs2sprite:scale(.2, .2);

        rs3sprite = display.newSprite( rednum_sheet, seqData)
        rs3sprite.x = display.contentCenterX-60;
        rs3sprite.y = display.contentCenterY + 40;
        rs3sprite:scale(.2, .2);

        rs4sprite = display.newSprite( rednum_sheet, seqData)
        rs4sprite.x = display.contentCenterX-40;
        rs4sprite.y = display.contentCenterY + 40;
        rs4sprite:scale(.2, .2);

        rs5sprite = display.newSprite( rednum_sheet, seqData)
        rs5sprite.x = display.contentCenterX+20;
        rs5sprite.y = display.contentCenterY + 40;
        rs5sprite:scale(.2, .2);

        rs6sprite = display.newSprite( rednum_sheet, seqData)
        rs6sprite.x = display.contentCenterX+40;
        rs6sprite.y = display.contentCenterY + 40;
        rs6sprite:scale(.2, .2);

        rs7sprite = display.newSprite( rednum_sheet, seqData)
        rs7sprite.x = display.contentCenterX+100;
        rs7sprite.y = display.contentCenterY + 40;
        rs7sprite:scale(.2, .2);

        rs8sprite = display.newSprite( rednum_sheet, seqData)
        rs8sprite.x = display.contentCenterX+120;
        rs8sprite.y = display.contentCenterY + 40;
        rs8sprite:scale(.2, .2);

        sceneGroup:insert(rs1sprite)
        sceneGroup:insert(rs2sprite)
        sceneGroup:insert(rs3sprite)
        sceneGroup:insert(rs4sprite)
        sceneGroup:insert(rs5sprite)
        sceneGroup:insert(rs6sprite)
        sceneGroup:insert(rs7sprite)
        sceneGroup:insert(rs8sprite)

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

        heart4sprtie = display.newSprite( heart_sheet, heartData )
        heart4sprtie.x = 50
        heart4sprtie.y = 20
        heart4sprtie:scale(.17,.17)

        heart5sprtie = display.newSprite( heart_sheet, heartData )
        heart5sprtie.x = 77
        heart5sprtie.y = 20
        heart5sprtie:scale(.17,.17)

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

        hb4sprtie = display.newSprite( heart_sheet, heartbreakData )
        hb4sprtie.x = 50
        hb4sprtie.y = 20
        hb4sprtie:scale(.17,.17)
        hb4sprtie.alpha = 0;

        hb5sprtie = display.newSprite( heart_sheet, heartbreakData )
        hb5sprtie.x = 77
        hb5sprtie.y = 20
        hb5sprtie:scale(.17,.17)
        hb5sprtie.alpha = 0;

        sceneGroup:insert(heart1sprtie);
        sceneGroup:insert(heart2sprtie)
        sceneGroup:insert(heart3sprtie)
        sceneGroup:insert(heart4sprtie)
        sceneGroup:insert(heart5sprtie)

        sceneGroup:insert(hb1sprtie)
        sceneGroup:insert(hb2sprtie)
        sceneGroup:insert(hb3sprtie)
        sceneGroup:insert(hb4sprtie)
        sceneGroup:insert(hb5sprtie)


        local answer = 0;
        local answers = {}
        local temp = {}
        local c1 = nil;
        local c2 = nil;
        local c3 = nil;
        local c4 =nil;

        ------------Function for finding prime number or not
        local function sieve (x)
              if x < 2 then 
                 return false
              end

              -- Assume all numbers are prime until proven not-prime.
              local prime = {}
              prime[1] = false
              for i = 2, x do 
                  prime[i] = true 
              end 

              -- For each prime we find, mark all multiples as not-prime.
              for i = 2, math.sqrt(x) do
                  if prime[i] then
                     for j = i*i, x, i do
                         prime[j] = false
                     end
                  end
              end

              return prime
            end
     --    --------------------------------------Operations for generating numbers-------------------------------
        local function generateNumber()
        	---Depending upon the operator the numbers are generated
             op = math.random( 1,7)
             
             questionText.text = questions[op]
             squares = {4,9,16,25,36,49,64,81};
             cubes = {8,27,64}
             cubesans = {2,3,4}
             palin = {11,22,33,44,55,66,77,88,99}

             
             ---For ascending and decending operations
            if(op ==1 or op==2) then
                for i =1,4 do
                    answers[i] = math.random( 0,99 )
                    temp[i] = answers[i]

                    if(answers[i]~=nil and answers[i] >=10) then
                        number4 = "'"..answers[i].."'";
                        n1 = tonumber( number4:sub(2,2) )
                        n2 = tonumber( number4:sub(3,3) )                
                        if( i == 1) then
                            rs1sprite.alpha = 1
                            rs2sprite.alpha = 1
                            rs1sprite:setSequence( frames[n1] )
                            rs2sprite:setSequence( frames[n2] )
                            if(c1~=nil) then
                                c1.alpha = .2
                            end
                        elseif(i==2) then
                            rs3sprite.alpha = 1
                            rs4sprite.alpha = 1
                            rs3sprite:setSequence( frames[n1] )
                            rs4sprite:setSequence( frames[n2] )
                            if(c2~=nil) then
                                c2.alpha = .2
                            end
                        elseif(i==3) then
                            rs5sprite.alpha = 1
                            rs6sprite.alpha = 1
                            rs5sprite:setSequence( frames[n1] )
                            rs6sprite:setSequence( frames[n2] )
                            if(c3~=nil) then
                                c3.alpha = .2
                            end
                        elseif(i==4) then
                            rs7sprite.alpha = 1
                            rs8sprite.alpha = 1
                            rs7sprite:setSequence( frames[n1] )
                            rs8sprite:setSequence( frames[n2] )
                            if(c4~=nil) then
                                c4.alpha = .2
                            end
                        end
                    else
                        if( i == 1) then
                            rs1sprite.alpha = 1
                            rs2sprite.alpha = 1
                            rs1sprite:setSequence( frames[0] )
                            rs2sprite:setSequence( frames[answers[i]] )
                            if(c1~=nil) then
                                c1.alpha = .2
                            end
                        elseif(i==2) then
                            rs3sprite.alpha = 1
                            rs4sprite.alpha = 1
                            rs3sprite:setSequence( frames[0] )
                            rs4sprite:setSequence( frames[answers[i]] )
                            if(c2~=nil) then
                                c2.alpha = .2
                            end
                        elseif(i==3) then
                            rs5sprite.alpha = 1
                            rs6sprite.alpha = 1
                            rs5sprite:setSequence( frames[0] )
                            rs6sprite:setSequence( frames[answers[i]] )
                            if(c3~=nil) then
                                c3.alpha = .2
                            end
                        elseif(i==4) then
                            rs7sprite.alpha = 1
                            rs8sprite.alpha = 1
                            rs7sprite:setSequence( frames[0] )
                            rs8sprite:setSequence( frames[answers[i]] )
                            if(c4~=nil) then
                                c4.alpha = .2
                            end
                        end
                    end
                end
             end
             ---For squareroot
             if(op==3) then
                chose = math.random( 1,8 )
                number1 = squares[chose]
                questionText.text = questions[op]..number1
                number3 = math.sqrt( number1 )
             end
             --For cuberoot
             if(op==4) then
                chose = math.random( 1,3 )
                number1 = cubes[chose]
                questionText.text = questions[op]..number1
                i =1;
                while(i<4) do
                    t = cubesans[i]
                    if(number1 == t *t *t ) then
                        number3 = t
                        i=4;
                    end
                    i = i +1;
                end
             end
             ---For mulitples
             if(op==5) then
                chose = math.random( 2,10 )
                questionText.text = questions[op]..chose
                j = 0
                while(j==0) do 
                    t = math.random(2,99)
                    if (t%chose == 0) then
                        j=1
                        number3 = t
                    end
                end
             end
             --For prime numbers
             if(op==6) then
                j=0
                number3 = 0
                questionText.text = questions[op]
                while(j==0) do
                    chose = math.random( 2,100 ) 
                    prime = sieve(chose)
                    if prime[chose] then
                        j=1
                        number3 = chose
                    end
                end
             end
             --For palindrome
            if(op==7) then
                chose = math.random( 1,9 )
                number3 = palin[chose]
            end

            --Randamizing the options
             if(op== 3 or op== 4 or op==5 or op==6 or op==7) then
                answerposition = math.random( 1, 4 )
                answers[answerposition] = number3
            end


            --Generating other answers for options
            for i=1,4 do
                if(op == 3 or op == 4) then
                    if(answers[i] == nil) then
                        j=0
                        while(j==0) do
                            t = math.random( 1,99 )
                            if(t~= number3) then
                                answers[i]= t
                                j=1
                            end
                        end
                    end
                elseif(op== 5) then
                    if(answers[i] == nil) then
                        j=0
                        while(j==0) do
                            t = math.random( 2,99 )
                             if(t%chose ~= 0) then
                                answers[i] = t;
                                j=1;
                            end
                        end
                    end
                elseif(op== 6) then
                    if(answers[i] == nil) then
                        j=0
                        while(j==0) do
                            t = math.random( 2,99 )
                            prime = sieve(t)
                             if prime[t]==false then
                                answers[i] = t;
                                j=1;
                            end
                        end
                    end
                elseif(op== 7) then
                    if(answers[i] == nil) then
                       j=0
                        while(j==0) do
                            t = math.random( 1,99 )
                            if(t~= number3) then
                                answers[i]= t
                                j=1
                            end
                        end
                    end
                end
                
                --Assigning it to sprite sheet
                if(answers[i]~=nil and answers[i] >=10) then
                    number4 = "'"..answers[i].."'";
                    n1 = tonumber( number4:sub(2,2) )
                    n2 = tonumber( number4:sub(3,3) )                
                    if( i == 1) then
                        rs1sprite:setSequence( frames[n1] )
                        rs2sprite:setSequence( frames[n2] )
                        rs1sprite.alpha = 1
                        rs2sprite.alpha = 1
                    elseif(i==2) then
                        rs3sprite:setSequence( frames[n1] )
                        rs4sprite:setSequence( frames[n2] )
                        rs3sprite.alpha = 1
                        rs4sprite.alpha = 1
                    elseif(i==3) then
                        rs5sprite:setSequence( frames[n1] )
                        rs6sprite:setSequence( frames[n2] )
                        rs5sprite.alpha = 1
                        rs6sprite.alpha = 1
                    elseif(i==4) then
                        rs7sprite:setSequence( frames[n1] )
                        rs8sprite:setSequence( frames[n2] )
                        rs7sprite.alpha = 1
                        rs8sprite.alpha = 1
                    end
                else
                    if( i == 1) then
                        rs1sprite:setSequence( frames[0] )
                        rs2sprite:setSequence( frames[answers[i]] )
                        rs1sprite.alpha = 1
                        rs2sprite.alpha = 1
                    elseif(i==2) then
                        rs3sprite:setSequence( frames[0] )
                        rs4sprite:setSequence( frames[answers[i]] )
                        rs3sprite.alpha = 1
                        rs4sprite.alpha = 1
                    elseif(i==3) then
                        rs5sprite:setSequence( frames[0] )
                        rs6sprite:setSequence( frames[answers[i]] )
                        rs5sprite.alpha = 1
                        rs6sprite.alpha = 1
                    elseif(i==4) then
                        rs7sprite:setSequence( frames[0] )
                        rs8sprite:setSequence( frames[answers[i]] )
                        rs7sprite.alpha = 1
                        rs8sprite.alpha = 1
                    end
                end
            end
        end
          --------------------------------Using circles to detect the options-----------------------
        
        local c1 = display.newCircle( display.contentCenterX-130, display.contentCenterY +40,30 )
        c1.alpha = 0.2
        local c2 = display.newCircle( display.contentCenterX - 50, display.contentCenterY + 40,30 )
        c2.alpha = 0.2
        local c3 = display.newCircle( display.contentCenterX +30, display.contentCenterY + 40,30 )
        c3.alpha = 0.2
        local c4 = display.newCircle( display.contentCenterX+ 110, display.contentCenterY + 40,30 )
        c4.alpha = 0.2


        --------------------Function to check the answer-----------------
        local function checkAnswer(event)  
        		---For ascending and decending
                if(op==1 or op==2) then                
                    table.sort(temp)
                    if(op==1 and temp[1] == answers[event.target.id]) then
                        audio.play( soundTable["option"] );
                        temp[1] = 100
                        answers[event.target.id] = nil;
                        score = score + 1;
                        scoreText.text = "Score : "..score
                        if(event.target.id==1) then
                            rs1sprite.alpha = 0
                            c1.alpha = .1
                            rs2sprite.alpha = 0
                        elseif(event.target.id==2) then
                            c2.alpha = .1
                            rs3sprite.alpha = 0
                            rs4sprite.alpha = 0
                        elseif(event.target.id ==3) then
                            c3.alpha = .1
                            rs5sprite.alpha = 0
                            rs6sprite.alpha = 0
                        elseif(event.target.id==4 )then
                            c4.alpha = .1
                            rs7sprite.alpha = 0
                            rs8sprite.alpha = 0
                        end
                    elseif(op==2 and temp[#temp] == answers[event.target.id]) then
                        audio.play( soundTable["option"] );
                        temp[#temp] = -1
                        answers[event.target.id] = nil;
                        score = score + 1;
                        scoreText.text = "Score : "..score
                        if(event.target.id==1) then
                            c1.alpha = .1
                            rs1sprite.alpha = 0
                            rs2sprite.alpha = 0
                        elseif(event.target.id==2) then
                            c2.alpha = .1
                            rs3sprite.alpha = 0
                            rs4sprite.alpha = 0
                        elseif(event.target.id ==3) then
                            c3.alpha = .1
                            rs5sprite.alpha = 0
                            rs6sprite.alpha = 0
                        elseif(event.target.id==4 )then
                            c4.alpha = .1
                            rs7sprite.alpha = 0
                            rs8sprite.alpha = 0
                        end
                    else
                        audio.play( soundTable["wrong"] );
                        system.vibrate()
                        life = life - 1;
                        if(life == 4) then
                            heart5sprtie.alpha= 0;
                            hb5sprtie.alpha = 1;
                        elseif(life == 3) then
                            heart4sprtie.alpha= 0;
                            hb4sprtie.alpha = 1;
                        elseif(life == 2) then
                            heart3sprtie.alpha= 0;
                            hb3sprtie.alpha = 1;
                        elseif life ==1 then
                            heart2sprtie.alpha = 0;
                            hb2sprtie.alpha =1;
                        elseif(life <= 0) then
                            heart1sprtie.alpha = 0;
                            hb1sprtie.alpha =1;
                            timer.performWithDelay( 1000,function () 
                                composer.removeScene( "medium", false )
                                composer.gotoScene( "endscene", {effect = "slideRight", time = 500})
                                end )
                        end

                    end
                    table.sort(temp)
                    if(op==1 and temp[1]==100) then
                        generateNumber()
                    end
                    if(op==2 and temp[#temp]==-1)then
                        generateNumber()
                    end
                 ----For other types of numbers
                elseif(op==3 or op==4 or op==5 or op==6 or op==7) then
                    if(number3 == answers[event.target.id]) then
                        audio.play( soundTable["option"] );
                        score = score + 1;
                        scoreText.text = "Score : "..score
                        chose = 0
                        number3 = 0;
                        answers = {};
                        generateNumber()
                    else
                        audio.play( soundTable["wrong"] );
                        system.vibrate()
                        life = life - 1;
                        if(life == 4) then
                            heart5sprtie.alpha= 0;
                            hb5sprtie.alpha = 1;
                            timer.performWithDelay( 1000, generateNumber)
                        elseif(life == 3) then
                            heart4sprtie.alpha= 0;
                            hb4sprtie.alpha = 1;
                            timer.performWithDelay( 1000, generateNumber)
                        elseif(life == 2) then
                            heart3sprtie.alpha= 0;
                            hb3sprtie.alpha = 1;
                            timer.performWithDelay( 1000, generateNumber)
                        elseif life ==1 then
                            heart2sprtie.alpha = 0;
                            hb2sprtie.alpha =1;
                            timer.performWithDelay( 1000, generateNumber)
                        elseif(life <= 0) then
                            heart1sprtie.alpha = 0;
                            hb1sprtie.alpha =1;
                            timer.performWithDelay( 1000,function () 
                                composer.removeScene( "medium", false )
                                composer.gotoScene( "endscene", {effect = "slideRight", time = 500})
                                end )
                        end
                        number3 = 0;
                        answers = {};
                        chose = 0
                    end
                end
                
        end
       
        c1:setFillColor(0,0,0)
        c1:addEventListener( "tap", checkAnswer)
        c1.id = 1
        
        

        c2:setFillColor(0,0,0)
        c2:addEventListener( "tap", checkAnswer)
        c2.id = 2

        c3:setFillColor(0,0,0)
        c3:addEventListener( "tap", checkAnswer)
        c3.id = 3

        c4:setFillColor(0,0,0)
        c4:addEventListener( "tap", checkAnswer)
        c4.id = 4

        sceneGroup:insert(c1)
        sceneGroup:insert(c2)
        sceneGroup:insert(c3)
        sceneGroup:insert(c4)

        generateNumber();

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