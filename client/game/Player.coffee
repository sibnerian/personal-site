@PLAYER_WIDTH = 50
@PLAYER_HEIGHT = 20
#SPRITE = new CroppedImage(spritesheet, ?, ?, ?, ?)
BULLET_SPRITE = new CroppedImage(spritesheet, 7, 450, 22, 35)

class Player extends Ship
    constructor: (@ctx, @canvas, @topLeftX, @topLeftY)->
        super(@ctx, @canvas, BULLET_SPRITE, @topLeftX, @topLeftY, PLAYER_WIDTH, PLAYER_HEIGHT) #CHANGE ME
        @willFire = false
    getBullet: -> 
        bullet =  new Bullet(@ctx, @canvas, BULLET_SPRITE, @topLeftX + @width/2, @topLeftY+@height, 0, -10)
        bullet.shift(-bullet.width/2, -bullet.height)
        bullet
    draw: ->
        #Delete me when you do the spritesheet right
        @ctx.fillStyle = "rgb(200,0,0)"
        @ctx.fillRect @topLeftX, @topLeftY, @width, @height


# Export Player
@Player = Player