
$(document).ready(function(){
  updateMailTo();
  $("#personalemail").keyup(updateMailTo);
});

function updateMailTo() {
  link='mailto:termsuite@univ-nantes.fr?subject=Subscription request: '
        + $("#personalemail").val()
        + '&body='
        + $("#subscribe").data("body");
  $("#subscribe").attr("href", encodeURI(link));
}
