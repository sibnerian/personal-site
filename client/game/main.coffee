#newGame must be exposed to other files, use @ to make it global
@newGame = (canvas)->
    ctx = canvas.getContext('2d')
    #invader = new Invader(ctx, canvas, 20, 20)
    invaders = new InvaderGroup(ctx, canvas, 8, 4, 10 , 10)
    invaders.setVelocity(10, 0)
    invaders.draw()
    setInterval ->
        invaders.clear()
        invaders.move()
        invaders.draw()
    , 200