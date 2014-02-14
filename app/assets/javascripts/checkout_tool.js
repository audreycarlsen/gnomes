$(function() {
  $(".checkin-checkout").on( "click", ".checkout_button, .checkin_button", function() {

    var button = $(this);
    var form   = $(this).parents('form');

    if( button.is(".checkout_button") ){
      $.ajax({
        url: $(this).parents('form').attr("action"),
        type: 'PATCH',
        dataType: 'json',

        success: function(data, textStatus, xhr) {
          button.remove();
          var checkin_button = "<input class='checkin_button ui mini blue button' type='submit' value='Check In'></input>";
          form.append(checkin_button);
          form.attr("action", "/tools/" + data.id + "/return");
        },

        error: function(xhr, textStatus, errorThrown) {
          alert("Something has gone horribly wrong.");
        }
      });
    }
    else {
      $.ajax({
        url: $(this).parents('form').attr("action"),
        type: 'PATCH',
        dataType: 'json',

        success: function(data, textStatus, xhr) {
          button.remove();
          var checkout_button = "<input class='checkout_button ui mini blue button' type='submit' value='Check Out'></input>";
          form.append(checkout_button);
          form.attr("action", "/tools/" + data.id + "/reserve");
        },

        error: function(xhr, textStatus, errorThrown) {
          alert("Something has gone horribly wrong.");
        }
      });
    }

    return false;
  });
});

