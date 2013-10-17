class BoundingBox
    constructor: (@x, @y, @width, @height)->
        return

    contains: (x, y)->
       (@x + @height >= x >= @x) and (@y + @height >= y >= @y)


@BoundingBox = BoundingBox