class Game
    constructor: (@canvas, @keydown, @keyup) ->
        @ctx = @canvas.getContext('2d')

    start: ->
        @reset()
        self = @
        @interval = Meteor.setInterval ->
            self.tick()
            self.ticks++
        , 20
        @started = true
        @paused = false

    reset: ->
        @ticks = 0
        @lives = 3
        @score = 0
        @invaders = new InvaderGroup(@ctx, @canvas, 8, 4, 10 , 10)
        @invaders.setVelocity(10, 0)
        @bullets = new BulletGroup(@ctx, @canvas)
        @bullets.addAll @invaders.getBullets()
        player = new Player(@ctx, @canvas, @canvas.width/2, @canvas.height-30)
        @player = player
        @playerBullets = new BulletGroup(@ctx, @canvas)
        @playerBullets.add player.getBullet()
        keysDown = new Set (val)-> val #values will be numbers, and can be own hash function
        @keysDown = keysDown
        @keydown (e)->
            switch e.which
                when 32 
                    e.preventDefault()
                when 37
                    player.setVelocity(-10, 0)
                when 39
                    player.setVelocity(10, 0)
            keysDown.add e.which
        @keyup (e)->
            keysDown.remove e.which

    tick: ->
        @invaders.clear()
        @bullets.clear()
        @player.clear()
        @playerBullets.clear()
        @invaders.move() if @ticks % 15 is 0
        @bullets.move()
        @player.move()
        @playerBullets.move()
        @bullets.draw()
        @invaders.draw()
        @player.draw()
        @playerBullets.draw()
        # invader destruction logic
        for bullet in @playerBullets.toArray()
            if @invaders.intersects(bullet) and @invaders.invaderAtCoords(bullet.topLeftX + bullet.width/2, bullet.topLeftY)?
                @playerBullets.remove(bullet)
                @invaders.removeInvaderAtCoords(bullet.topLeftX + bullet.width/2, bullet.topLeftY)
        # player movement logic
        switch
            when @keysDown.contains(37) and not @keysDown.contains(39)
                @player.setVelocity(-10, 0)
            when @keysDown.contains(39) and not @keysDown.contains(37)
                @player.setVelocity(10, 0)
            else
                @player.setVelocity(0, 0)
        # player shooting logic
        @playerBullets.add @player.getBullet() if @keysDown.contains(32) and @ticks % 5 is 0

@Game = Game