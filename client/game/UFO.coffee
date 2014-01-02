UFO_SPRITE = new CroppedImage(spritesheet, 31, 338, 192, 84)


class UFO extends Ship
    constructor: (@ctx, @canvas, @topLeftX, @topLeftY)->
        @pointValue = 50 * Math.ceil(Math.random() * 3)
        super(@ctx, @canvas, UFO_SPRITE, @topLeftX, @topLeftY, 55, 24)
    move:->
        @shift(@velX, @velY)
    draw:->
        if @exploded
            @ctx.textAlign = 'center'
            @ctx.font = '12px "Press Start 2P"'
            @ctx.fillStyle = 'rgb(255, 255, 255)'
            @ctx.fillText "#{@pointValue}", @topLeftX + @width/2, @topLeftY+@height, 200
        else
            super()

@UFO = UFO
