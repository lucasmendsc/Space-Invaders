physics = require("physics")

game = {player = require("Player"),
		EnemyShips = require("EnemyShips")
		}
function showLifes()
	display.newText("Lifes : " .. game.player.lifes,40,0)
end
function game:startGame()
	physics:start(true)
	game.player:onStartFunctions()
	game.EnemyShips:onStart()
	showLifes()
end

return game
