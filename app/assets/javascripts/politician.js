$(document).on("page:change", function(){
   if($('body').is('#politicians.show')){
    var politician_id = $(".politician_id").attr('id')
    
    $.ajax({
    url: '/politicians/' + politician_id + '/times_articles',
    dataType: "script",
    type: "GET"
  });

    }
})