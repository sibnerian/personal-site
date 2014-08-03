class BulletGroup
    constructor: (@ctx, @canvas) ->
        @data = new Set()

    add: (bullet) ->
        @data.add bullet if bullet?

    addAll: (bullets) ->
        @add bullet for bullet in bullets

    draw: ->
        @data.each (bullet) -> bullet.draw()

    clear: ->
        @data.each (bullet) -> bullet.clear()

    shift: (dx, dy) ->
        @data.each (bullet) -> bullet.shift(dx, dy)

    move: ->
        data = @data
        @data.each (bullet) -> bullet?.move()
        for bullet in @toArray()
            @data.remove(bullet) if not bullet.isOnScreen()

    size: ->
        @data.size()

    remove: (bullet) ->
        bullet.clear()
        @data.remove bullet

    removeAll: ->
        for bullet in @toArray()
            @remove bullet

    toArray: ->
        @data.toArray()

# Export BulletGroup
@BulletGroup = BulletGroup
