class InvaderGroup
    constructor: (@ctx, @canvas, cols, rows, @minX, @minY)->
        @size = cols*rows
        @rowSize = cols
        @data = []
        offset = 8
        for i in [0...@size]
            x = @minX + (i % @rowSize) * (INVADER_WIDTH + offset) + offset
            y = @minY + Math.floor(i / @rowSize) * (INVADER_HEIGHT + offset) + offset
            @data[i] = new Invader(@ctx, @canvas, x, y)
        @maxX = @data[@size-1].topLeftX + INVADER_WIDTH
        @maxY = @data[@size-1].topLeftY + INVADER_HEIGHT

    draw: ->
        for invader in @data
            invader?.draw()

    clear: -> 
        for invader in @data
            invader?.clear()

    shift: (dx, dy)->
        @minX += dx
        @maxX += dx
        @minY += dy
        @maxY += dy
        for invader in @data
            invader?.shift(dx, dy)

    move: ->
        if @maxX + @velX  > @canvas.width or @minX + @velX < 0
            @shift(0, INVADER_HEIGHT)
            @setVelocity(-@velX, @velY)
        else if @maxY + @velY > @canvas.height
            @loseGame()
        else 
            @minX += @velX
            @maxX += @velX
            @minY += @velY
            @maxY += @velY
            for invader in @data
                invader?.move()

    setVelocity: (vx, vy)->
        @velX = vx
        @velY = vy
        for invader in @data
            invader?.setVelocity(vx, vy)

    loseGame: ->
        alert("YOU LOSE GG")

# Export InvaderGroup
@InvaderGroup = InvaderGroup