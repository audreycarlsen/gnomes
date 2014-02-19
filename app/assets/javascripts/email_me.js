$(function() {
  $(".checkout-return").on( "click", ".checkout_button, .return_button", function() {

    $.ajax({
      url: $(this).parents('form').attr("action"),
      type: 'PATCH',
      dataType: 'json',
      headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    })
    .done(function(data){
      button.remove();

      form.attr("action", "/tools/" + data.id + getFormUrl( button) );

      form.append(getOppositeButton( button ));
    })
    .fail(function(){
      alert("Something has gone horribly wrong.");
    });
    return false;
  });
});
