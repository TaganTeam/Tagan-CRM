initMap = (lat, lng) ->
  map = new (google.maps.Map)($('#map')[0],
    center:
      lat: lat
      lng: lng
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoom: 9)

  marker = new (google.maps.Marker)(
    position:
      lat: lat
      lng: lng
    map: map)


  google.maps.event.addListenerOnce map, 'idle', ->
    $('#modal').modal('show')

    map.setCenter(new google.maps.LatLng(lat + 0.35, lng - 1.2))
  return
  return

@openMap = (lat, lng) ->
  $('#modal').on 'shown.bs.modal', ->
    google.maps.event.trigger map, 'resize'
    
  initMap(lat, lng)
