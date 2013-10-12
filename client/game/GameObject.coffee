class GameObject
    constructor: (@ctx, @canvas, @image, @topLeftX, @topLeftY, @width, @height) ->
        @velX = 0
        @velY = 0

    setPosition: (x, y)->
        @topLeftX = x
        @topLeftY = y

    setVelocity: (vx, vy)->
        @velX = vx
        @velY = vy

    move: ->
        newX = Math.max(0, Math.min(@canvas.width - @width, @topLeftX + @velX))
        newY = Math.max(0, Math.min(@canvas.height - @height, @topLeftY + @velY))
        setPosition(newX, newY)

    draw: ->
        @image.draw(@ctx, @topLeftX, @topLeftY, @width, @height)


#Export
@GameObject = GameObject




