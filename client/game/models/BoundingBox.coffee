class BoundingBox
    constructor: (@x, @y, @width, @height)->
        return

    contains: (x, y)->
       (@x + @width >= x >= @x) and (@y + @height >= y >= @y)


@BoundingBox = BoundingBox