class InvaderGroup extends GameObject
    constructor: (ctx, canvas, cols, rows, topLeftX, topLeftY, @BULLET_FREQ)->
        @_size = cols*rows
        @rowSize = cols
        @data = []
        @offset = 8
        for i in [0...@_size]
            x = topLeftX + (i % @rowSize) * (INVADER_WIDTH + @offset)
            y = topLeftY + Math.floor(i / @rowSize) * (INVADER_HEIGHT + @offset)
            invaderType = switch
                when i < 2*@rowSize then "squid"
                when i < 4*@rowSize then "crab"
                else "jelly"
            @data[i] = new Invader(ctx, canvas, x, y, invaderType)
            console.log (INVADER_WIDTH - @data[i].width)/2
            @data[i].shift((INVADER_WIDTH - @data[i].width)/2, 0)
            
        maxX = @data[@_size-1].topLeftX + INVADER_WIDTH
        maxY = @data[@_size-1].topLeftY + INVADER_HEIGHT
        super(ctx, canvas, null, topLeftX, topLeftY, maxX - topLeftX, maxY - topLeftY)
        @originalTopLeftX = topLeftX
        @originalTopLeftY = topLeftY

    updateWidthHeight: ->
        return if @data.length is 0
        @topLeftX = @topLeftY = maxX = maxY = undefined
        for inv in @data
            continue if not inv?
            @topLeftX = Math.floor(inv.topLeftX) if (not @topLeftX?) or inv.topLeftX < @topLeftX
            @topLeftY = Math.floor(inv.topLeftY) if (not @topLeftY?) or inv.topLeftY < @topLeftY
            maxX = Math.ceil(inv.topLeftX) + inv.width if (not maxX?) or inv.topLeftX + inv.width > maxX
            maxY = Math.ceil(inv.topLeftY + inv.height) if (not maxY?) or inv.topLeftY + inv.height > maxY
        @width = maxX - @topLeftX
        @height = maxY - @topLeftY

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
            @reached_bottom = true
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
        if @data[xIndex + yIndex * @rowSize]?
            @data[xIndex + yIndex * @rowSize].clear() # clear removed invader off the screen
            delete @data[xIndex + yIndex * @rowSize]
            @_size--
            @updateWidthHeight()

    intersects: (other)->
        if not (other? and super other)
            return false
        @invaderAtCoords(other.topLeftX, other.topLeftY)?.intersects(other) or
        @invaderAtCoords(other.topLeftX, other.topLeftY + other.height)?.intersects(other) or
        @invaderAtCoords(other.topLeftX + other.width, other.topLeftY)?.intersects(other) or
        @invaderAtCoords(other.topLeftX + other.width, other.topLeftY + other.height)?.intersects(other)

    updateExploded: (num)->
        for invader in @data
            if invader?.exploded
                if invader.ticks_since_explode > num
                    @removeInvaderAtCoords(invader.topLeftX, invader.topLeftY) 
                else
                    invader.ticks_since_explode++

    getBullets: ->
        freq = @BULLET_FREQ or 0.1
        _.map @data, (invader)->
            if Math.random() < freq then invader?.getBullet() else undefined

    size: ->
        @_size

# Export InvaderGroup
@InvaderGroup = InvaderGroup