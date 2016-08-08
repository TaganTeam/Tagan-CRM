$(document).ready ->
  files = []
  $('input[type=file]').change (event) ->
    $.each event.target.files, (index, file) ->
      reader = new FileReader

      reader.onload = (event) ->
        object = {}
        object.filename = file.name
        object.data = event.target.result
        files.push object
        return

      reader.readAsDataURL file
      return
    return
  $('#upload_button').on 'click', (form) ->
    $.each files, (index, file) ->
      $.ajax
        url: '/managment/inventories/upload'
        type: 'POST'
        data:
          filename: file.filename
          data: file.data
        success: (data, status, xhr) ->
      return
    files = []
    form.preventDefault()
    return