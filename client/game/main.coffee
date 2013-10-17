#newGame must be exposed to other files, use @ to make it global
@newGame = (canvas)->
    ctx = canvas.getContext('2d')
    #invader = new Invader(ctx, canvas, 20, 20)
    invaders = new InvaderGroup(ctx, canvas, 8, 4, 10 , 10)
    invaders.setVelocity(10, 0)
    invaders.draw()
    inv = invaders.invaderAtCoords(400, 400)
    inv2 = new Invader(ctx, canvas, 390, 390)
    inv2.draw()
    console.log 2
    console.log inv?.intersects(inv2)
    console.log 2
    console.log inv2?.intersects(inv)
    ###ctx.fillStyle = '#8ED6FF'
    ctx.fillRect(180, 180, 5, 5)###
