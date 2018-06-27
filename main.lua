require "Game"


local retangulo = display.newRect(160,100, 20,20)

function minhaFuncaoColisao(event)
    display.remove(retangulo)
end
physics.start()
retangulo:addEventListener( "collision", minhaFuncaoColisao )


physics.start()
physics.addBody(retangulo)