physics = require("physics")

game = {player = require("Player"),
		EnemyShips = require("EnemyShips")
		}

function game:startGame()
	physics:start()
	game.player:onStartFunctions()
	game.EnemyShips:onStart()
end

return game
