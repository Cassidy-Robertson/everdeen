$(document).on("page:change", function(){
   if($('body').is('#politicians.show')){
    var politician_id = $(".politician_id").attr('id')
    
    $.ajax({
    url: '/politicians/' + politician_id + '/times_articles',
    dataType: "script",
    type: "GET"
  });

    }

  if($('body').is('#politicians.findyourreps')){
    $('.search-button').on('click',function(event){
      var zipcode = $('#zipcode').val();
      window.location = "/findyourreps?zipcode="+zipcode;
    });

    $('.form-inline').keypress(function(event){
      if(event.which == 13){
        $('.search-button').click()
      }
    });
  }
})