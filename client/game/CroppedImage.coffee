class CroppedImage
    constructor: (@image, @sx, @sy, @swidth, @sheight)->

    draw: (ctx, dx, dy, dwidth, dheight)->
        ctx.drawImage(@image, @sx, @sy, @swidth, @sheight, dx, dy, dwidth, dheight)


# Export the class
@CroppedImage = CroppedImage
