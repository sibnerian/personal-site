Meteor.startup ->
    Session.set "showBackButton", false

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
            div.append(canvas)
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
