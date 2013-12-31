# Invaders are 40 x 40 and they share a common Image
@INVADER_WIDTH = 40
@INVADER_HEIGHT = 40
SPRITE1_1 = new CroppedImage(spritesheet, 40, 30, 65, 65)
SPRITE1_2 = new CroppedImage(spritesheet, 142, 30, 65, 65)
EXPLODE_SPRITE = new CroppedImage(spritesheet, 243, 0, 65, 65)
BULLET_SPRITE = new CroppedImage(spritesheet, 7, 460, 22, 35)

class Invader extends Ship
    constructor: (@ctx, @canvas, @topLeftX, @topLeftY)->
        super(@ctx, @canvas, SPRITE1_2, @topLeftX, @topLeftY, INVADER_WIDTH, INVADER_HEIGHT)
    getBullet: -> 
        return new Bullet(@ctx, @canvas, BULLET_SPRITE, @topLeftX + INVADER_WIDTH/2, @topLeftY+INVADER_HEIGHT, 0, 5)
    explode: -> 
        @image = EXPLODE_SPRITE
        @exploded = true
        @ticks_since_explode = 0





# Export Invader
@Invader = Invader