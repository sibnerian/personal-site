Meteor.startup ->
    Session.set "showBackButton", false
    Session.set "soundOn", false
    Deps.autorun ->
        muted = !(Session.get "soundOn")
        for sound in buzz.sounds
            if muted then sound.mute() else sound.unmute()

Template.backButton.helpers
    showBackButton: ->
        Session.get "showBackButton"

Template.backButton.events
    'click': ->
        document.location.reload()

$(document).ready ->
    $('.invader').click ->
        $('.bizcard').removeClass('flipInX').addClass('hinge')
        Meteor.setTimeout ->
            Session.set "showBackButton", true
            div = $("<div>").addClass("gameDiv animated fadeIn")
            canvas = $('<canvas>').addClass('game-canvas')
            soundButton = $("<span>").addClass("soundIcon soundOff").click ->
                buttonElement = $(this)
                if Session.get "soundOn"
                    buttonElement.removeClass('soundOn').addClass('soundOff')
                    Session.set 'soundOn', false
                else
                    buttonElement.removeClass('soundOff').addClass('soundOn')
                    Session.set 'soundOn', true
            div.append(soundButton).append(canvas)
            $('body').prepend(div)
            # HTML5 canvas needs width and height attributes, not just styles
            canvas.attr {width: canvas.width(), height: canvas.height()}
            keydown = (func) ->
                $(window).keydown (e) -> func(e)
            keyup = (func) ->
                $(window).keyup (e) -> func(e)
            game = new Game(canvas[0], keydown, keyup)
            game.start()
        , 1800
