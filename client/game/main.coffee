#newGame must be exposed to other files, use @ to make it global
@newGame = (canvas)->
    ctx = canvas.getContext('2d')
    #invader = new Invader(ctx, canvas, 20, 20)
    invaders = new InvaderGroup(ctx, canvas, 8, 4, 10 , 10)
    invaders.setVelocity(10, 0)
    invaders.draw()
    inv = invaders.invaderAtCoords(200, 200)
    inv2 = new Invader(ctx, canvas, 200, 200)
    inv2.draw()
    console.log inv
    console.log inv?.intersects(inv2)
    console.log inv2
    console.log inv2?.intersects(inv)

    Meteor.setInterval -> 
        invaders.clear()
        invaders.move()
        invaders.draw()
    , 1000

    ###ctx.fillStyle = '#8ED6FF'
    ctx.fillRect(180, 180, 5, 5)###
