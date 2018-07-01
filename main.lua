game = require "Game"
physics = require "physics"
shot = display.newRect(player.playerShip.x,player.playerShip.y -70 , 5, 25)
    physics.addBody(shot,"dynamic")
    shot.gravityScale = 5
    shot.isBullet = true
physics.start(true)
physics.addBody(shot)
function e()
	display.remove(shot)
end

shot:addEventListener("collision",e)

game:startGame()