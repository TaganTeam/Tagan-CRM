$(document).ready ->

  $("#inventories-list tr").on "click", (e) ->
    show_url = $(@).attr('href')
    e.preventDefault()
    $.ajax show_url,
      type: 'GET'
      dataType: "json"
      success: (r) ->
        $('#edit_id').val(r.id)
        $('#inventory_type_id').val(r.type.id)
        unless r.user == null
          $('#inventory_user_id').val(r.user.id)
        $('#edit_part').val(r.inventory_id)
        $('#receipt_id').val(r.receipt_date)
        $('#edit_img').val('r.avatar')
        $('#edit_inventories').modal 'show'
      error: (e) ->
        console.log(e)
    return
   

  this.addInventories = ->
    $('#inventoriesmodal').modal 'show'
    return

  this.addType = ->
    $('#typemodal').modal 'show'
    return

  $('#createType').on 'click', (e) ->
    e.preventDefault()
    $.ajax '/managment/types',
      type: 'POST'
      data: $('#types_v').serialize()
      success: () ->
        $('#typemodal').modal 'hide'
        optionname = $('#inventory_type_id').find('option').last()
        value = +optionname.val()

        ww ='<option value="' + (value + 1) + '">'+ $('#types_v').val()+ '</option>'
        optionname.after(ww)
        return
      error: (e) ->
        console.log(e)
    return
    
  file = []
  prepareUpload =(e) ->
    file = e.target.files

  $('input[type=file]').change (event) ->
    prepareUpload(event)

  $('#createInventories').on 'click', (e) ->
    e.preventDefault()
    ggg = $('#inv_form').serialize()
    if file == []
      data = (ggg + '&inventory%5Bavatar%5D=/public/uploads/unknown.png')
    else
      data = (ggg + '&inventory%5Bavatar%5D=' + '/public/uploads/' + file[0].name)
    $.ajax '/managment/inventories',
      type: 'POST'
      dataType: "json"
      data: data
      success: () ->
        $('#inventoriesmodal').modal 'hide'
      error: (e) ->
        console.log(e)
        return

  $('#updateInventories').on 'click', (e) ->
    e.preventDefault()
    id = $('#edit_id').val()
    data = $('.edit_form').serialize()
    $.ajax '/managment/inventories/' + id,
      type: 'PUT'
      dataType: "json"
      data: data
      success: () ->
        $('#edit_inventories').modal 'hide'
      error: (e) ->
        console.log(e)
        return

  $('#lineLink td').on 'click', (e) ->
    e.preventDefault()
    delete_url = $(@).attr('href')
    $.ajax delete_url,
      type: 'DELETE'
      dataType: "json"
      data: {"_method":"delete"}
      success: (r) ->
        console.log(r)
      error: (e) ->
        console.log(e)
        return

  return