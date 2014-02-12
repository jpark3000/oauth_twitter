
function getIt(data) {    
  $.get('/status/' + data, function(data) {
    console.log(data)
    if (data == 'true') {  
      $('#tweets').html('SUCCESS')
    } else {
      setTimeout(function() {
          getIt(data);
        }, 500);
    };
  }); 
};



$(document).ready(function() { 

    $('#tweet-form').submit(function(event) {
      event.preventDefault();
      var tweet_data = $("#tweet-form").serialize();

      $('#tweet-form input').prop('disabled', true);
      $('#tweet-form submit').prop('disabled', true);
      $('#tweets').html('<img src="ajax-loader.gif">');

      $.post('/tweet', tweet_data, function(data) {
        $('#tweet-form input').prop('disabled', false);
        $('#tweet-form submit').prop('disabled', false);
        $('#tweet_input').val("");

        getIt(data);

      });

    });
});