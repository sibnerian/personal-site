class BoundingBox
    constructor: (@x, @y, @width, @height) ->
        return undefined

    contains: (x, y) ->
        (@x + @width >= x >= @x) and (@y + @height >= y >= @y)


@BoundingBox = BoundingBox
