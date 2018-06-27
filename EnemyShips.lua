local physics = require("physics")

enemyShips = {
    fisrtColumn = {
                    ship1 = display.newImage("Game Images/darkEnemy.png",40,10),
                    ship2 = display.newImage("Game Images/darkEnemy.png",40,80),
                    ship3 = display.newImage("Game Images/whiteEnemy.png",40,150),
                    ship4 = display.newImage("Game Images/whiteEnemy.png",40,220)
                    },
    secondColumn = {
                    ship5 = display.newImage("Game Images/darkEnemy.png",110,10),
                    ship6 = display.newImage("Game Images/darkEnemy.png",110,80),
                    ship7 = display.newImage("Game Images/whiteEnemy.png",110,150),
                    ship8 = display.newImage("Game Images/whiteEnemy.png",110,220)
                    },
    thirdColumn = {
                    ship9 = display.newImage("Game Images/darkEnemy.png",180,10),
                    ship10 = display.newImage("Game Images/darkEnemy.png",180,80),
                    ship11 = display.newImage("Game Images/whiteEnemy.png",180,150),
                    ship12 = display.newImage("Game Images/whiteEnemy.png",180,220)
                    },
    fourthColumn = {
                    ship13 = display.newImage("Game Images/darkEnemy.png",250,10),
                    ship14 = display.newImage("Game Images/darkEnemy.png",250,80),
                    ship15 = display.newImage("Game Images/whiteEnemy.png",250,150),
                    ship16 = display.newImage("Game Images/whiteEnemy.png",250,220)
                    }
            }

function enemyShips:shoot()
    for i=1,4 do
        for j=1,4 do
        end
    end
end

return enemyShips