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
        // debugger;
        data["results"][0]["address_components"].forEach(function(add_comp){
          // debugger;
          if(add_comp["types"][0]==="postal_code"){
            zipcode = add_comp["long_name"];
          }
        });

        // zipcode = data["results"][0]["address_components"][8]["long_name"];
        
      }).done(function(){

        // $.get("/findyourreps",{zipcode: zipcode})
        window.location = "/findyourreps?zipcode="+zipcode
      })
    };

    getLocation();
    
  })
})


