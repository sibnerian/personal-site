$(document).ready ()->
    console.log("fopber")
    canvas = $('<canvas>')
    $('.invader').click () ->
        $('.bizcard').removeClass('flipInX').addClass('hinge')
