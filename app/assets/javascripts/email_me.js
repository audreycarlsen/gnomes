$(function() {
  $(".email-me").on( "click", function() {

    $(this).toggle();
    $("#email_form").toggle();

    return false;
  });
});

$(function() {
  $("#submit_button").on( "click", function() {

    $.ajax({
      url: $(this).parents('form').attr("action"),
      type: 'PATCH',
      dataType: 'json',
      data: {
        user: {
          email: $("#user_email").val()
        }
      },
      headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    })
    .done(function(data){
      $("#email_form").toggle();
      $("#email_form_congrats").toggle();
    })
    .fail(function(){
      $("#email_form_uhoh").toggle();
    });
    return false;
  });
});