local physics = require("physics")
player = {lifes = 3, 
        playerShip = display.newImage("Game Images/playerShip.png",160,460)
        }


local function onAccelerate(event)
    player.playerShip.x = display.contentCenterX + 
        (display.contentCenterX * (event.xGravity*2)) 
end

rect = display.newRect(20,20,50,50)

function shoot( event )
    if event.phase == "began" then
        shot = player:createBullet()

            local function moveShot()
                shot.y = shot.y - 5
            end

        timerPlayerShipShot = timer.performWithDelay(10,moveShot,0)
    end
end

rect:addEventListener("touch",shoot)

function onShipCollision(event)
    transition.fadeOut( player.playerShip, { time=500 })
    player:gameOver(player.lifes)
end

function player:onStartFunctions()
    physics.start()
    physics.addBody(player.playerShip,"static")

function onShotCollision()
    display.remove(shot)
    timer.cancel(timerPlayerShipShot)
end
    player.playerShip:addEventListener( "collision", onShipCollision )
    system.setAccelerometerInterval( 60 )
    Runtime:addEventListener ("accelerometer", onAccelerate)
end

function player:createBullet()
    return display.newRect(player.playerShip.x,player.playerShip.y - 35,5,25)
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