$(function() {
  $(".checkout-return").on( "click", ".checkout_button, .return_button", function() {

    var button = $(this);
    var form   = $(this).parents('form');

    var getOppositeButton = function( button ){
      var opposite_button;

      if( button.is(".checkout_button") ){
        opposite_button = "<input class='return_button ui mini red button' type='submit' value='Check In'></input>";
      } else {
        opposite_button = "<input class='checkout_button ui mini blue button' type='submit' value='Check Out'></input>";
      }
      return opposite_button;
    };

    var getFormUrl = function ( button ){
      var form_url;
      if( button.is(".checkout_button") ){
        form_url = "/return";
      } else {
        form_url = "/reserve";
      }
      return form_url;
    };

    $.ajax({
      url: $(this).parents('form').attr("action"),
      type: 'PATCH',
      dataType: 'json'
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

