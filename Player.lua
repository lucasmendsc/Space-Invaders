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

function onShotCollision()
    display.remove(shot)
    timer.cancel(timerPlayerShipShot)
end

function shoot( event )
    if event.phase == "began" then
        shot = player:createBullet()
        table.insert(player.shots,shot)
        shot.isBullet = true
            local function moveShot()
                if ableToMoveShot(shot) then
                    for i,shot in ipairs(player.shots) do
                        shot.y = shot.y - 5
                    end
                end
            end

        timerPlayerShipShot = timer.performWithDelay(10,moveShot,0)
    end
end

function ableToMoveShot(shot)
    if shot.y < 2 then
        display.remove(shot)
        timer.cancel(timerPlayerShipShot)
        return false
    else 
        return true
    end
end

function onShipCollision(event)
    transition.fadeOut( player.playerShip, { time=500 })
    transition.fadeOut( player.playerShip, { time=500 })
    player:gameOver(player.lifes)
end

function player:createBullet()
    shot = display.newRect(player.playerShip.x,player.playerShip.y -40 , 5, 25)
    physics.addBody(shot,"dynamic")
    shot.gravityScale = 0
    shot:addEventListener( "collision", onShotCollision )
    shot.isBullet = true
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
        display.remove(player.playerShip)
    else
        player.lifes = player.lifes - 1
    end
end

function player:onStartFunctions()
    physics.addBody(player.playerShip,"static")
    player.playerShip:addEventListener( "collision", onShipCollision )
    system.setAccelerometerInterval( 60 )
    Runtime:addEventListener ("accelerometer", onAccelerate)
    Runtime:addEventListener("touch",shoot)
end

return player