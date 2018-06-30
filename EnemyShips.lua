local physics = require("physics")

enemyShips = {{},{},{},{}} 
rightMovement = true
timerMoveEnemys = nil
timerMoveEnemysDown = nil

function enemyShips:setShips()
    x = 40
    y = 10
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
        y = 10
    end 
end

function enemyShips:shipColisionListiners()

    local function ship1ColisionListiner()
        display.remove(enemyShips[1][1])
    end

    local function ship2ColisionListiner()
        display.remove(enemyShips[1][2])
    end

    local function ship3ColisionListiner()
        display.remove(enemyShips[1][3])
    end

    local function ship4ColisionListiner()
        display.remove(enemyShips[1][4])
    end

    local function ship5ColisionListiner()
        display.remove(enemyShips[2][1])
    end

    local function ship6ColisionListiner()
        display.remove(enemyShips[2][2])
    end

    local function ship7ColisionListiner()
        display.remove(enemyShips[2][3])
    end


    local function ship8ColisionListiner()
        display.remove(enemyShips[2][4])
    end

    local function ship9ColisionListiner()
        display.remove(enemyShips[3][1])
    end

    local function ship10ColisionListiner()
        display.remove(enemyShips[3][2])
    end

    local function ship11ColisionListiner()
        display.remove(enemyShips[3][3])
    end

    local function ship12ColisionListiner()
        display.remove(enemyShips[3][4])
    end

    local function ship13ColisionListiner()
        display.remove(enemyShips[4][1])
    end

    local function ship14ColisionListiner()
        display.remove(enemyShips[4][2])
    end

     local function ship15ColisionListiner()
        display.remove(enemyShips[4][3])
    end

     local function ship16ColisionListiner()
        display.remove(enemyShips[4][4])
    end

    enemyShips[1][1]:addEventListener( "collision", ship1ColisionListiner )
    enemyShips[1][2]:addEventListener( "collision", ship2ColisionListiner )
    enemyShips[1][3]:addEventListener( "collision", ship3ColisionListiner )
    enemyShips[1][4]:addEventListener( "collision", ship4ColisionListiner )
    enemyShips[2][1]:addEventListener( "collision", ship5ColisionListiner )
    enemyShips[2][2]:addEventListener( "collision", ship6ColisionListiner )
    enemyShips[2][3]:addEventListener( "collision", ship7ColisionListiner )
    enemyShips[2][4]:addEventListener( "collision", ship8ColisionListiner )
    enemyShips[3][1]:addEventListener( "collision", ship9ColisionListiner )
    enemyShips[3][2]:addEventListener( "collision", ship10ColisionListiner )
    enemyShips[3][3]:addEventListener( "collision", ship11ColisionListiner )
    enemyShips[3][4]:addEventListener( "collision", ship12ColisionListiner )
    enemyShips[4][1]:addEventListener( "collision", ship13ColisionListiner )
    enemyShips[4][2]:addEventListener( "collision", ship14ColisionListiner )
    enemyShips[4][3]:addEventListener( "collision", ship15ColisionListiner )
    enemyShips[4][4]:addEventListener( "collision", ship16ColisionListiner )
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
                enemyShips[i][j].x = enemyShips[i][j].x + 15
                checkEdges(enemyShips[i][j].x)
            end
        end
    end
    
end   

function moveLeft()
    for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].x = enemyShips[i][j].x - 15
                checkEdges(enemyShips[i][j].x)
            end
        end
    end
     
end   

function moveDown()
   for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].y = enemyShips[i][j].y + 15
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
    shot = display.newRect(ship.x,ship.y +20 , 5, 15)
    physics.addBody(shot,"dynamic")
    shot.gravityScale = 5
    shot.isBullet = true
    return shot
end

function onShotColision()
    display.remove(shot)
end

function enemyShips:shoot()
    for i = 1, 4 do
        shot = createBullet(enemyShips[i][table.maxn(enemyShips[i])])
    end
end

function enemyShips:onStart()
    enemyShips:setShips()
    enemyShips:shipColisionListiners()
    enemyShips:addPhysic()
    timerMoveEnemys = timer.performWithDelay(800,moveRight,0)
    enemyShips:moveShips()
    --enemyShips:shoot()
end

return enemyShips