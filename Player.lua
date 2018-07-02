local physics = require("physics")

player = {lifes = 3, 
        playerShip = display.newImage("Game Images/playerShip.png",160,460),
        shotsHited = 0,
        score = 0
        }

local function onAccelerate(event)
    player.playerShip.x = display.contentCenterX + 
        (display.contentCenterX * (event.xGravity*2)) 
    if player.playerShip.x > 295 then
        player.playerShip.x = 295
    elseif player.playerShip.x < 25 then
        player.playerShip.x = 25
    end
end

function onShotCollision(event)
    display.remove(shot)
    display.remove(event.other)
    shot:removeSelf()
    event.other = nil
    timer.cancel(timerPlayerShipShot)
    Runtime:addEventListener("touch",shoot)
    shotsHited()
end

function onExit()
    os.exit()
end

function shotsHited()
   player.shotsHited = player.shotsHited + 1
   player.score = player.score + 120
   showScore()
   if  player.shotsHited >= 16 then
        gameOver()
   end
end

function checkShots(shot)
    if shot.y < 20 then
        display.remove(shot)
        Runtime:addEventListener("touch",shoot)
        timer.cancel(timerPlayerShipShot)
    end
end

function player:createBullet()
    shot = display.newRect(player.playerShip.x,player.playerShip.y -40 , 5, 25)
    Runtime:removeEventListener("touch",shoot)
    physics.addBody(shot,"dynamic")
    shot.gravityScale = 0
    shot:addEventListener( "collision", onShotCollision )
    shot.isBullet = true
    return shot
end

function shoot( event )
    if event.phase == "began" then
        shot = player:createBullet()

        local function moveShot()
            if shot.y ~= nil then
                shot.y = shot.y - 5
                checkShots(shot)
            end
        end
        shotAudio = audio.loadStream("Game Sounds/shoot.wav")
        audio.play(shotAudio)
    timerPlayerShipShot = timer.performWithDelay(15,moveShot,-1)
end
end

function onShipCollision(event)
    transition.to(player.playerShip,{ time=1000, alpha=0.3,delay=0})
    transition.to(player.playerShip,{ time=1000, alpha=1,delay=2500})
    player:lifeCount(player.lifes)
    display.remove(event.other)
end

function gameOver()
    local text
    display.newRect( 200, 250, 500, 520 )

    if player.shotsHited >= 16  then
        text = "Você venceu!"
    else
        text = "Você perdeu..."
    end
        collisionAudio = audio.loadStream("Game Sounds/explosion.wav")
        audio.play(collisionAudio)
        finalMessage = display.newText(text, 170, 240, native.systemFont, 40 )
        finalMessage:setFillColor( 0,0,0 )
        timer.performWithDelay(1500,onExit,1)
end

function player:lifeCount(lifes)
    if player.lifes > 1 then
        player.lifes = player.lifes - 1
        showLifes()
    else
        player.playerShip:removeEventListener("collision" , onShipCollision )
        gameOver()
    end
end

function showScore()
display.remove(scoreDisplay)
scoreDisplay = display.newText("Score : " .. player.score,270,30)
end

function showLifes()
    display.remove(lifeDisplay)
    lifeDisplay = display.newText("Lifes : " .. player.lifes,40,30)
end

function player:onStartFunctions()
    physics.addBody(player.playerShip,"static")
    player.playerShip:addEventListener( "collision", onShipCollision )
    system.setAccelerometerInterval( 60 )
    Runtime:addEventListener ("accelerometer", onAccelerate)
    Runtime:addEventListener("touch",shoot)
    lifeDisplay = display.newText("Lifes : " .. player.lifes,40,30)
    scoreDisplay = display.newText("Score : " .. player.score,270,30)
end

return player