# Invaders fit in an area 42x28
@INVADER_WIDTH = 42
@INVADER_HEIGHT = 28

squidPixelWidth = 65
SPRITE_SQUID_1 = new CroppedImage(spritesheet, 40, 30, squidPixelWidth, 65)
SPRITE_SQUID_2 = new CroppedImage(spritesheet, 142, 30, squidPixelWidth, 65)

crabPixelWidth = 88
SPRITE_CRAB_1 = new CroppedImage(spritesheet, 27, 134, crabPixelWidth, 65)
SPRITE_CRAB_2 = new CroppedImage(spritesheet, 131, 134, crabPixelWidth, 65)

jellyPixelWidth = 98
SPRITE_JELLY_1 = new CroppedImage(spritesheet, 15, 241, jellyPixelWidth, 65)
SPRITE_JELLY_2 = new CroppedImage(spritesheet, 129, 241, jellyPixelWidth, 65)


EXPLODE_SPRITE = new CroppedImage(spritesheet, 243, 0, 65, 65)
BULLET_SPRITE = new CroppedImage(spritesheet, 7, 460, 22, 35)

class Invader extends Ship
    constructor: (@ctx, @canvas, @topLeftX, @topLeftY, @type)->
        switch @type
            when "squid"
                @image1 = SPRITE_SQUID_1
                @image2 = SPRITE_SQUID_2
                @pointValue = 40
                super(@ctx, @canvas, @image1, @topLeftX, @topLeftY, squidPixelWidth/jellyPixelWidth*INVADER_WIDTH, INVADER_HEIGHT)
            when "crab"
                @image1 = SPRITE_CRAB_1
                @image2 = SPRITE_CRAB_2
                @pointValue = 20
                super(@ctx, @canvas, @image1, @topLeftX, @topLeftY, crabPixelWidth/jellyPixelWidth*INVADER_WIDTH, INVADER_HEIGHT)
            when "jelly"
                @image1 = SPRITE_JELLY_1
                @image2 = SPRITE_JELLY_2
                @pointValue = 10
                super(@ctx, @canvas, @image1, @topLeftX, @topLeftY, INVADER_WIDTH, INVADER_HEIGHT)
        
    getBullet: -> 
        return new Bullet(@ctx, @canvas, BULLET_SPRITE, @topLeftX + @width/2, @topLeftY+@height, 0, 5)
    explode: -> 
        super()
        @image = EXPLODE_SPRITE
    swapSprite: ->
        @image = if @image is @image1 then @image2 else @image1
    move: ->
        super()
        @swapSprite() if not @exploded

# Export Invader
@Invader = Invader