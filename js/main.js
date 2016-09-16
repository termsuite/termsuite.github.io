
$(document).ready(function(){
  $("#personalemail").change(function() {
    link='mailto:termsuite@univ-nantes.fr?subject=subscribe '
          + $("#personalemail").val()
          + '&body='
          + $("#subscribe").data("body");
      alert(encodeURI(link));
    $("#subscribe").attr("href", encodeURI(link));
  });
});
