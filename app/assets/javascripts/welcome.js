$(document).ready(function(){
  $('#geo-politician').on('click',function(event){
    event.preventDefault();

    var x = $('#response');
    var zipcode;

    function getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
      } else { 
        x.append("Geolocation is not supported by this browser.");
      }
    }

    function showPosition(position) {
      $.get("http://maps.googleapis.com/maps/api/geocode/json?latlng="+position.coords.latitude+","+position.coords.longitude+"&sensor=true", function(data){

        zipcode = data["results"][0]["address_components"][8]["long_name"];
        
      }).done(function(){
        x.append("Latitude: " + position.coords.latitude + 
        "<br>Longitude: " + position.coords.longitude+"<br>"+zipcode)
        $.post("/findyourreps",{zipcode: zipcode})
      })
    };

    getLocation();
  })
})


