jQuery ->

  $('.apps').masonry
    itemSelector : '.app'
    columnWidth : 160

  $('li.app').click ->
    window.location = $(this).data('url')
