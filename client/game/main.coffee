#newGame must be exposed to other files, use @ to make it global
@newGame = (canvas)->
    ctx = canvas.getContext('2d')
    #invader = new GameObject(ctx, canvas, cropped, 10, 10, 40, 40, canvas.width, canvas.height)
    invader = new Invader(ctx, canvas, 20, 20)
    invader.draw()