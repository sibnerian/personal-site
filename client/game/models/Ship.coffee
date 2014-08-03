class Ship extends GameObject
    explode: ->
        @exploded = true
        @ticks_since_explode = 0

@Ship = Ship
