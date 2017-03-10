-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
cx=display.contentCenterX
cy=display.contentCenterY



local grass=display.newImage( "floor.jpg")
grass.x=cx
grass.y=cy

local gnom1opt={width=120, height=130, numFrames=80}
local gnom1Sheet=graphics.newImageSheet( "gnom-sheet.png", gnom1opt )
local seqData=
{
	{name="left", start=51, count=10, time=800},
	{name="right", start=71, count=10, time=800},
	{name="down", start=41, count=10, time=800},
	{name="up", start=61, count=10, time=800},

}
local gnom=display.newSprite(gnom1Sheet,seqData)
gnom.x=cx
gnom.y=cy



local skopt={width=64, height=64, numFrames=72}
local skSheet=graphics.newImageSheet( "skeleton-sheet.png", skopt )
local skData=
{
	{name="left", start=19, count=7, time=800},
	{name="right", start=64, count=9, time=800},
	{name="down", start=10, count=9, time=800},
	{name="up", start=46, count=9, time=800},
	{name="figtLeft", start=28, count=9, time=800},

}
local skeleton=display.newSprite(skSheet,skData)
skeleton.x=100
skeleton.y=100
skeleton.yScale=5
skeleton.xScale=5
skeleton:play()


local speed=0.3
local skspeed=0.2

local function onGrassTouch( event )
    if ( event.phase == "began" ) then

    	if event.x>=gnom.x then 
        	gnom:setSequence( "right")
    	end

    	if event.x<gnom.x then 
        	gnom:setSequence("left")
    	end

		if event.y<gnom.y and math.abs(event.y-gnom.y)>200 then 
        	gnom:setSequence("up")
    	end

    	if event.y>gnom.y and math.abs(event.y-gnom.y)>200 then 
        	gnom:setSequence("down")
    	end

    	local path=math.sqrt(math.pow((event.x-gnom.x),2)+math.pow((event.y-gnom.y),2))
    
        gnom:play()
        transition.moveTo( gnom, {x=event.x, y=event.y, time=path/speed} )
    elseif ( event.phase == "ended" ) then
       
    end
    return true
end

local isFighting=false
local function enterFrame(event)
	local path=math.sqrt(math.pow((skeleton.x-gnom.x),2)+math.pow((skeleton.y-gnom.y),2))
	transition.moveTo( skeleton, {x=gnom.x, y=gnom.y, time=path/skspeed} )
	if path<=50 and isFighting==false then 
		skeleton:setSequence( "figtLeft")
		skeleton:play()
		isFighting=true
	end
end




grass:addEventListener( "touch", onGrassTouch )
Runtime:addEventListener("enterFrame", enterFrame)