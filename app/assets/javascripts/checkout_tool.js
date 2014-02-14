$(function() {
  $(".checkout").on( "click", function() {

    var checkout = $(this);
    var status   = $(this).parents('td');

    $.ajax({
      url: $(this).parents('form').attr("action"),
      type: 'PATCH',
      dataType: 'json',

      success: function(data, textStatus, xhr) {
        checkout.remove();
        var checked_out = '<em>Checked out</em>';
        status.append(checked_out);
      },

      error: function(xhr, textStatus, errorThrown) {
        alert("Something has gone horribly wrong.");
      }
    });
    return false;
  });
});