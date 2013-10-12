# Invaders are 40 x 40 and they share a common Image
@INVADER_WIDTH = 40
@INVADER_HEIGHT = 40
SPRITE1_1 = new CroppedImage(spritesheet, 40, 30, 65, 65)
SPRITE1_2 = new CroppedImage(spritesheet, 142, 30, 65, 65)

class Invader extends GameObject
    constructor: (@ctx, @canvas, @topLeftX, @topLeftY)->
        super(@ctx, @canvas, SPRITE1_1, @topLeftX, @topLeftY, INVADER_WIDTH, INVADER_HEIGHT)


# Export Invader
@Invader = Invader