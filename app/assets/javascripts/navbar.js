$(document).ready(function() {
  $("#search").focus(function(){
    $(".search-form").css("background-color", "#f3f3f3")
  });
  $("#search").blur(function(){
    $(".search-form").css("background-color", "white")
  });
});
