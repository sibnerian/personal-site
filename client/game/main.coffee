class Game
    constructor: (@canvas, @keydown, @keyup) ->
        @ctx = @canvas.getContext('2d')
        @bullet_freq = 0.02

    start: ->
        @reset()

    clearCanvas: ->
        @ctx.clearRect(0, 0, @canvas.width, @canvas.height)

    reset: ->
        @clearCanvas()
        @ticks = 0
        @lives = 3
        @score = 0
        @nextLevel()
        @player = new Player(@ctx, @canvas, @canvas.width/2, @canvas.height-50)
        @keys_down = new Set (val)-> val #values will be numbers, and can be own hash function
        self = @
        @keydown (e)->
            switch e.which
                when 32 
                    e.preventDefault()
                    self.player.willFire = true
                when 37
                    self.player.setVelocity(-10, 0)
                when 39
                    self.player.setVelocity(10, 0)
                when 80 # 'p'
                    if self.paused then self.resume() else self.pause()
                when 13 # ENTER
                    self.reset() if not self.started
            self.keys_down.add e.which
        @keyup (e)->
            self.keys_down.remove e.which
        @started = true
        @paused = false
        self = @
        @interval = Meteor.setInterval ->
            self.tick()
            self.ticks++
        , 20

    nextLevel: ->
        if @levels_cleared? then @levels_cleared++ else @levels_cleared = 0
        invaderCoord = Math.min(150, 25 + @levels_cleared * 25)
        @invaders = new InvaderGroup(@ctx, @canvas, 8, 4, invaderCoord, invaderCoord, @bullet_freq)
        @invaders.setVelocity(10 + 2*@levels_cleared, 0)
        @bullets?.clear()
        @player_bullets?.clear()
        @bullets = new BulletGroup(@ctx, @canvas)
        @player_bullets = new BulletGroup(@ctx, @canvas)




    tick: ->
        return if @paused
        @drawHud()
        @invaders.clear()
        @bullets.clear()
        @player.clear()
        @player_bullets.clear()
        if @ticks % 15 is 0
            @invaders.move()
            @bullets.addAll @invaders.getBullets()
        @bullets.move()
        @player.move()
        @player_bullets.move()
        @bullets.draw()
        @invaders.draw()
        @player.draw()
        @player_bullets.draw()

        #get rid of exploded invaders
        @invaders.updateExploded(10)

        # invader destruction logic
        for bullet in @player_bullets.toArray()
            if @invaders.intersects(bullet)
                invader = @invaders.invaderAtCoords(bullet.topLeftX + bullet.width/2, bullet.topLeftY)
                if invader? and not invader.exploded
                    @player_bullets.remove(bullet)
                    invader.explode()
                    @score += 10
        # player destruction logic
        for bullet in @bullets.toArray()
            if @player.intersects(bullet)
                @bullets.removeAll()
                @lives--
                @player.explode()
        # player movement logic
        switch
            when @keys_down.contains(37) and not @keys_down.contains(39)
                @player.setVelocity(-10, 0)
            when @keys_down.contains(39) and not @keys_down.contains(37)
                @player.setVelocity(10, 0)
            else
                @player.setVelocity(0, 0)
        # player shooting logic
        if @ticks % 10 is 0
            @player_bullets.add @player.getBullet() if @player.willFire and @player_bullets.size() is 0
            @player.willFire = false if not @keys_down.contains(32)
        @nextLevel() if @invaders.size() is 0
        @loseGame() if @lives < 0 or @invaders.reached_bottom

    drawHud: ->
        @drawScore()
        @drawLives()

    drawScore: ->
        @ctx.clearRect(@canvas.width - 58, 0, 58, 22)
        @ctx.textAlign = 'right'
        @ctx.font = '16px "Press Start 2P"'
        @ctx.fillStyle = 'rgb(200, 0, 0)'
        @ctx.fillText "#{@score}", @canvas.width - 5, 20, 48

    drawLives: ->
        @ctx.clearRect(@canvas.width-80, @canvas.height-50, 80, 50)
        @ctx.textAlign = 'right'
        @ctx.font = '16px "Press Start 2P"'
        @ctx.fillStyle = 'rgb(200, 0, 0)'
        @ctx.fillText "Lives:#{@lives}", @canvas.width-5, @canvas.height-5, 80

    pause: ->
        @paused = true
        @ctx.textAlign = 'center'
        @ctx.font = '20px "Press Start 2P"'
        @ctx.fillStyle = 'rgb(255, 255, 255)'
        @ctx.fillText "Paused", @canvas.width/2, @canvas.height/2, 200

    resume: ->
        @paused = false
        @clearCanvas()
        @invaders.draw()
        @bullets.draw()
        @player.draw()
        @player_bullets.draw()
        @drawHud()

    loseGame: ->
        Meteor.clearInterval(@interval)
        @clearCanvas()
        @started = false
        @ctx.textAlign = 'center'
        @ctx.font = '32px "Press Start 2P"'
        @ctx.fillStyle = 'rgb(255, 255, 255)'
        @ctx.fillText "Game Over", @canvas.width/2, @canvas.height/2-40, 250
        @ctx.font = '20px "Press Start 2P"'
        @ctx.fillText "Final Score: #{@score}", @canvas.width/2, @canvas.height/2-5, 200
        @ctx.font = '24px "Press Start 2P"'
        @ctx.fillText "Press enter to play again.", @canvas.width/2, @canvas.height/2+25, 300






@Game = Game