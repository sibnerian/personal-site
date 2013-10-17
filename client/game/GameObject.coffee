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
        @setPosition(newX, newY)

    shift: (dx, dy)->
        oldVelX = @velX
        oldVelY = @velY
        @setVelocity(dx, dy)
        @move()
        @setVelocity(oldVelX, oldVelY)

    draw: ->
        @image.draw(@ctx, @topLeftX, @topLeftY, @width, @height)

    clear: ->
        @ctx.clearRect(@topLeftX, @topLeftY, @width, @height)

    intersects: (other)->
        if not other?
            return false
        bb = new BoundingBox(@topLeftX, @topLeftY, @width, @height)
        bb.contains(other.topLeftX, other.topLeftY) or 
        bb.contains(other.topLeftX, other.topLeftY + other.height) or
        bb.contains(other.topleftX + other.width, other.topLeftY) or
        bb.contains(other.topLeftX + other.width, other.topLeftY + other.height)


#Export
@GameObject = GameObject




