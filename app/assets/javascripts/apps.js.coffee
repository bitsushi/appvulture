jQuery ->

  $('.apps').masonry
    itemSelector : '.app'
    columnWidth : 160

  $('li.app').click ->
    window.location = $(this).data('url')

  $('form#filters input').change (e) ->
    $(this).parents('form').submit()

  $('form#filters input[type=submit]').hide()

  $('label').click ->
    $(this).toggleClass('active')
