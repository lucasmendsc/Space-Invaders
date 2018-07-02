local physics = require("physics")
enemyShips = {{},{},{},{},
            shipsAlive = 16}
local bullet = nil 
local rightMovement = true

function enemyShips:setShips()
    x = 20
    y = 50

    for i=1,4 do
        if i ~= 1 then
            x = x + 70
        end

        for j=1,4 do
            if j ~= 1 then
                y = y + 70
            end

            if j > 2 then
                 enemyShips[i][j] = display.newImage("Game Images/whiteEnemy.png",x,y)
            else
                enemyShips[i][j] = display.newImage("Game Images/darkEnemy.png",x,y)
            end
        end
        y = 50
    end 
end

function enemyShips:addPhysic()
    for i=1,4 do
        for j=1,4 do
            physics.addBody(enemyShips[i][j],"dinamyc")
            enemyShips[i][j].gravityScale = 0
        end
    end
end

function moveRight()
    for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].x = enemyShips[i][j].x + 10
                checkEdges(enemyShips[i][j].x)
            end
        end
    end 
end   

function moveLeft()
    for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].x = enemyShips[i][j].x - 10
                checkEdges(enemyShips[i][j].x)
            end
        end
    end   
end   

function moveDown()
   for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].y = enemyShips[i][j].y + 10
            end
        end
    end
end

function enemyShips:moveShips()
    if rightMovement then
        rightMovement = false
    else
        moveDown()
        rightMovement = true
    end
end

function checkEdges(x)
    if x > 300 then
        timer.cancel(timerMoveEnemys)
        timerMoveEnemysDown = timer.performWithDelay(800,moveDown,0)
        timerMoveEnemys = timer.performWithDelay(800,moveLeft,0)
        enemyShips:moveShips()
        timer.cancel(timerMoveEnemysDown)
    elseif x < 20 then
        timer.cancel(timerMoveEnemys)
        timerMoveEnemysDown = timer.performWithDelay(800,moveDown,0)
        timerMoveEnemys = timer.performWithDelay(800,moveRight,0)
        enemyShips:moveShips()
        timer.cancel(timerMoveEnemysDown)
    end
end

local function createBullet(ship)
    bullet = display.newRect(ship.x,ship.y +25 , 5, 15)
    physics.addBody(bullet,"dynamic")
    bullet.gravityScale = 0
    bullet.isBullet = true
    bullet:addEventListener("collision",shotCollision)
    return bullet
end

function pickShipToShoot()
    if enemyShips.shipsAlive ~= 0 then
        shipIndex = math.random(4)
        x = 4
            for i=1,4 do
                if enemyShips[shipIndex][x].y == nil then
                    x = x - 1
                else
                    bullet = createBullet(enemyShips[shipIndex][x])
                    break
                end
            end
    end
end

function enemyShips:enemyShoot()
    pickShipToShoot()

    if bullet ~= nil and x ~= 0 then
        local function moveShot()
            bullet.y = bullet.y + 5
            checkShotEdges(bullet)
        end
        timerEnemyShot = timer.performWithDelay(40,moveShot,-1)
    else
        enemyShips:enemyShoot()
    end
end

function checkShotEdges(bullet)
    if bullet.y > 535 then
        display.remove(bullet)
        timer.cancel(timerEnemyShot)
        enemyShips:enemyShoot()
    end
end

function shotCollision()
    display.remove(bullet)
    timer.cancel(timerEnemyShot)
    enemyShips:enemyShoot()
end

function enemyShips:onStart()
    enemyShips:setShips()
    enemyShips:addPhysic()
    timerMoveEnemys = timer.performWithDelay(800,moveRight,0)
    enemyShips:moveShips()
    enemyShips:enemyShoot()
end

return enemyShips