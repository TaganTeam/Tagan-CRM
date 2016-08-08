/**
 * Created by user on 03.08.16.
 */
$(document).ready(function() {
  
  newInvertory = function () {
    $('.modal').modal('show');
    destroy();
  };

  editInvertory = function () {
    $('.modal').modal('show');
  };

 function destroy() {
  document.getElementById('form').reset();
 }

 $('#create').on('click', function (e) {
  e.preventDefault();
   $.ajax('/managment/inventories', {
     type: 'POST',
     datatype: 'json',
     contenType: 'application/json',
     data: $('#form').serialize(),
     success: function (data) {
      var number_id =  $('tbody').find('tr').last();
      if (data.result == 'create')
      {
        var tr = $('<tr><td>'+(number_id.prevObject.length+1)+ '</td><td>'+$('#inventory_name').val()+'</td><td>'+$('#quantity_in_stock').val()+'</td></tr>');
        $('tbody').append(tr);
      }
      else
      {
        $('tbody').find('td:contains(' + $('#inventory_name').val() + ')');
      }
      $('.modal').modal('hide');
    }
  });
 });
});