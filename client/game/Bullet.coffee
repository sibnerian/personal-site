@BULLET_WIDTH = 11
@BULLET_HEIGHT = 17

class Bullet extends GameObject
    constructor: (@ctx, @canvas, sprite, @topLeftX, @topLeftY, vx, vy)->
        super(@ctx, @canvas, sprite, @topLeftX, @topLeftY, BULLET_WIDTH, BULLET_HEIGHT)
        @setVelocity(vx, vy)
    move: -> 
        @setPosition(@topLeftX + @velX, @topLeftY + @velY)

# Export Bullet
@Bullet = Bullet