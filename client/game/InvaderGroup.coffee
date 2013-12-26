class InvaderGroup extends GameObject
    constructor: (ctx, canvas, cols, rows, topLeftX, topLeftY)->
        @size = cols*rows
        @rowSize = cols
        @data = []
        @offset = 8
        for i in [0...@size]
            x = topLeftX + (i % @rowSize) * (INVADER_WIDTH + @offset)
            y = topLeftY + Math.floor(i / @rowSize) * (INVADER_HEIGHT + @offset)
            @data[i] = new Invader(ctx, canvas, x, y)
        maxX = @data[@size-1].topLeftX + INVADER_WIDTH
        maxY = @data[@size-1].topLeftY + INVADER_HEIGHT
        super(ctx, canvas, null, topLeftX, topLeftY, maxX - topLeftX, maxY - topLeftY)

    draw: ->
        for invader in @data
            invader?.draw()

    shift: (dx, dy)->
        @topLeftX += dx
        @topLeftY += dy
        for invader in @data
            invader?.shift(dx, dy)

    move: ->
        maxX = @topLeftX + @width
        maxY = @topLeftY + @height
        if maxX + @velX  > @canvas.width or @topLeftX + @velX < 0
            @shift(0, INVADER_HEIGHT)
            @setVelocity(-@velX, @velY)
        else if maxY + @velY > @canvas.height
            @loseGame()
        else 
            @topLeftX += @velX
            @topLeftY += @velY
            for invader in @data
                invader?.move()

    setVelocity: (vx, vy)->
        for invader in @data
            invader?.setVelocity(vx, vy)
        super(vx, vy)

    invaderAtCoords: (x, y)->
        xIndex = Math.floor((x-@topLeftX)/(INVADER_WIDTH + @offset))
        yIndex = Math.floor((y - @topLeftY)/(INVADER_HEIGHT + @offset))
        return @data[xIndex + yIndex * @rowSize]

    intersects: (other)->
        if not (other? and super other)
            return false
        invaderAtCoords(other.topLeftX, other.topLeftY)?.intersects(other) or
        invaderAtCoords(other.topLeftX, other.topLeftY + other.height)?.intersects(other) or
        invaderAtCoords(other.topLeftX + other.width, other.topLeftY)?.intersects(other) or
        invaderAtCoords(other.topLeftX + other.width, other.topLeftY + other.height)?.intersects(other)

    loseGame: ->
        alert("YOU LOSE GG")

# Export InvaderGroup
@InvaderGroup = InvaderGroup