class InvaderGroup extends GameObject
    constructor: (ctx, canvas, cols, rows, topLeftX, topLeftY, @BULLET_FREQ)->
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
        @originalTopLeftX = topLeftX
        @originalTopLeftY = topLeftY
        console.log {topLeftX: @topLeftX, topLeftY: @topLeftY, width: @width, height: @height}

    updateWidthHeight: ->
        return if @data.length is 0
        @topLeftX = @topLeftY = maxX = maxY = undefined
        for inv in @data
            continue if not inv?
            @topLeftX = inv.topLeftX if (not @topLeftX?) or inv.topLeftX < @topLeftX
            @topLeftY = inv.topLeftY if (not @topLeftY?) or inv.topLeftY < @topLeftY
            maxX = inv.topLeftX + inv.width if (not maxX?) or inv.topLeftX + inv.width > maxX
            maxY = inv.topLeftY + inv.height if (not maxY?) or inv.topLeftY + inv.height > maxY
        @width = maxX - @topLeftX
        @height = maxY - @topLeftY
        console.log {topLeftX: @topLeftX, topLeftY: @topLeftY, width: @width, height: @height}

    draw: ->
        for invader in @data
            invader?.draw()
            
    shift: (dx, dy)->
        super(dx, dy)
        @originalTopLeftX += dx
        @originalTopLeftY += dy
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
            super()
            @originalTopLeftX += @velX
            @originalTopLeftY += @velY
            for invader in @data
                invader?.move()

    setVelocity: (vx, vy)->
        for invader in @data
            invader?.setVelocity(vx, vy)
        super(vx, vy)

    invaderAtCoords: (x, y)->
        xIndex = Math.floor((x-@originalTopLeftX)/(INVADER_WIDTH + @offset))
        return undefined if xIndex >= @rowSize
        yIndex = Math.floor((y - @originalTopLeftY)/(INVADER_HEIGHT + @offset))
        return @data[xIndex + yIndex * @rowSize]

    removeInvaderAtCoords: (x, y)->
        xIndex = Math.floor((x-@originalTopLeftX)/(INVADER_WIDTH + @offset))
        yIndex = Math.floor((y - @originalTopLeftY)/(INVADER_HEIGHT + @offset))
        @data[xIndex + yIndex * @rowSize]?.clear() # clear removed invader off the screen
        delete @data[xIndex + yIndex * @rowSize]
        @updateWidthHeight()

    intersects: (other)->
        if not (other? and super other)
            return false
        @invaderAtCoords(other.topLeftX, other.topLeftY)?.intersects(other) or
        @invaderAtCoords(other.topLeftX, other.topLeftY + other.height)?.intersects(other) or
        @invaderAtCoords(other.topLeftX + other.width, other.topLeftY)?.intersects(other) or
        @invaderAtCoords(other.topLeftX + other.width, other.topLeftY + other.height)?.intersects(other)

    getBullets: ->
        freq = @BULLET_FREQ or 0.1212121
        _.map @data, (invader)->
            if Math.random() < freq then invader?.getBullet() else undefined

    loseGame: ->
        console.log "you lose GG"

# Export InvaderGroup
@InvaderGroup = InvaderGroup