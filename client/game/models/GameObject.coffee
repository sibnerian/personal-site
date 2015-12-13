class GameObject
    constructor: (@ctx, @canvas, @image, @topLeftX, @topLeftY, @width, @height) ->
        @velX = 0
        @velY = 0

    setPosition: (x, y) ->
        @topLeftX = x
        @topLeftY = y

    setVelocity: (vx, vy) ->
        @velX = vx
        @velY = vy

    move: ->
        newX = Math.max(0, Math.min(@canvas.width - @width, @topLeftX + @velX))
        newY = Math.max(0, Math.min(@canvas.height - @height, @topLeftY + @velY))
        @setPosition(newX, newY)

    shift: (dx, dy) ->
        @topLeftX += dx
        @topLeftY += dy

    draw: ->
        @image.draw(@ctx, @topLeftX, @topLeftY, @width, @height)

    clear: ->
        @ctx.clearRect(@topLeftX - 2, @topLeftY - 2, @width + 4, @height + 4)

    boundingBox: ->
        return new BoundingBox(@topLeftX, @topLeftY, @width, @height)

    bbIntersects: (other) ->
        if not other?
            return false
        bb = @boundingBox()
        bb.contains(other.topLeftX, other.topLeftY) or
        bb.contains(other.topLeftX, other.topLeftY + other.height) or
        bb.contains(other.topleftX + other.width, other.topLeftY) or
        bb.contains(other.topLeftX + other.width, other.topLeftY + other.height)


    intersects: (other) ->
        return @bbIntersects(other) or other.bbIntersects(@)

    isOnScreen: ->
        @topLeftX + @width >= 0 and
        @topLeftX <= @canvas.width and
        @topLeftY + @height >= 0 and
        @topLeftY <= @canvas.height


#Export
@GameObject = GameObject
