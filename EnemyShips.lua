local physics = require("physics")

enemyShips = {{},{},{},{}} 
                   
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

enemyShips:setShips()

function enemyShips:addPhysic()
    for i=1,4 do
        for j=1,4 do
            physics.addBody(enemyShips[i][j],"dinamyc")
        end
    end

end

enemyShips:addPhysic()

function enemyShips:moveShips()
    local function moveLeft()
        for i=1,4 do
            for j=1,4 do
                enemyShips[i][j].x = enemyShips[i][j].x + 5
            end
        end
    end

        timerMoveEnemysLeft = timer.performWithDelay(800,moveLeft,0)
end
enemyShips:moveShips()

return enemyShips