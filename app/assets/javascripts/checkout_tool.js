$(function() {
  $(".checkout_button").on( "click", function() {

    var checkout_button = $(this);
    var status          = $(this).parents('td');

    $.ajax({
      url: $(this).parents('form').attr("action"),
      type: 'PATCH',
      dataType: 'json',

      success: function(data, textStatus, xhr) {
        checkout_button.remove();
        var return_button = '<em>Checked out</em>';
        status.append(return_button);
      },

      error: function(xhr, textStatus, errorThrown) {
        alert("Something has gone horribly wrong.");
      }
    });
    return false;
  });
});
