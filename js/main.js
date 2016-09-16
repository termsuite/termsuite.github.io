
$(document).ready(function(){
  $("#personalemail").change(function() {
    link='mailto:termsuite@univ-nantes.fr?subject=Subscription request: '
          + $("#personalemail").val()
          + '&body='
          + $("#subscribe").data("body");
    $("#subscribe").attr("href", encodeURI(link));
  });
});
