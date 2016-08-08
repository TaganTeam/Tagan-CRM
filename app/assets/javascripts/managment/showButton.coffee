$(document).ready ->
  $('.inventory tr').on 'mouseover', (e)->
    index = this.rowIndex
    $('#lineLink tr').eq(index).removeClass('visible-button')

  $('.inventory tr').on 'mouseleave', (e)->
    index = this.rowIndex
    setTimeout (->
      $('#lineLink tr').eq(index).addClass('visible-button')
      return
    ), 1500

  $('#lineLink tr').on 'mouseover', (e)->
    $(@).addClass('visible-buttonn')

  $('#lineLink tr').on 'mouseleave', (e)->
    setTimeout (->
      $('#lineLink tr').removeClass('visible-buttonn')
      return
    ), 500
