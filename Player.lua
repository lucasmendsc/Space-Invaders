local physics = require("physics")
player = {lifes = 3, 
        playerShip = display.newImage("Game Images/playerShip.png",160,460),
        shots ={}
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

function shoot( event )
    if event.phase == "began" then
       shot = player:createBullet()

            local function moveShot()
                shot.y = shot.y - 5
                removeShot(shot)
            end
        timerPlayerShipShot = timer.performWithDelay(10,moveShot,0)
    end
end

function removeShot(shot)
  --[[]  if shot.y == 25 then
        display.remove(shot)
    end]]
end

Runtime:addEventListener("touch",shoot)

function onShipCollision(event)
    transition.fadeOut( player.playerShip, { time=500 })
    player:gameOver(player.lifes)
end

function player:onStartFunctions()
    physics.start()
    physics.addBody(player.playerShip,"static")
end

function onShotCollision()
    display.remove(shot)
    timer.cancel(timerPlayerShipShot)
end
    player.playerShip:addEventListener( "collision", onShipCollision )
    system.setAccelerometerInterval( 60 )
    Runtime:addEventListener ("accelerometer", onAccelerate)

function player:createBullet()
    shot = display.newRect(player.playerShip.x,player.playerShip.y -40 , 5, 25)
    physics.addBody(shot,"dynamic")
    shot.gravityScale = 0
    return shot
end

function player:ableToShoot()
    if timerPlayerShipShot == nil then
        return true
    else
        return false
    end
end

function player:gameOver(lifes)
    if player.lifes == 0 then
        --startOver()
    else
        player.lifes = player.lifes - 1
    end
end

return player