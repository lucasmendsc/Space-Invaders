local physics = require("physics")

enemyShips = {{},{},{},{}} 
rightMovement = true
timerMoveEnemys = nil

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

local function moveRight()
    for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].x = enemyShips[i][j].x + 30
                checkEdges(enemyShips[i][j].x)
            end
        end
    end
    timerMoveEnemys = timer.performWithDelay(800,moveRight,0) 
end     

function moveLeft()
    for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].x = enemyShips[i][j].x - 30
                checkEdges(enemyShips[i][j].x)
            end
        end
    end
    timerMoveEnemys = timer.performWithDelay(800,moveLeft,0) 
end

function moveDown()
   for i=1,4 do
        for j=1,4 do
            if enemyShips[i][j].x ~= nil then
                enemyShips[i][j].y = enemyShips[i][j].y + 30
            end
        end
    end
    timerMoveEnemysDown = timer.performWithDelay(800,moveDown,0)
    timer.cancel(timerMoveEnemysDown)
end


function enemyShips:moveShips()
    if timerMoveEnemys ~= nil then
        if firstMovement then
            timer.cancel(timerMoveEnemys)
            moveDown()
            moveRight()
            rightMovement = false
        else
            timer.cancel(timerMoveEnemys)
            moveDown()
            moveLeft()
            rightMovement = true
        end
    else
        moveRight()
        rightMovement = false
    end
end

function checkEdges(x)
    if x > 310 then
        enemyShips:moveShips()
    elseif x < 5 then
        enemyShips:moveShips()
    end
end

function enemyShips:onStart()
    enemyShips:setShips()
    enemyShips:shipColisionListiners()
    enemyShips:addPhysic()
    --enemyShips:moveShips()
end

return enemyShips