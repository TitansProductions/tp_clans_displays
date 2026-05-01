
function ResetAll() {
  $("#announcement").hide();
}

document.addEventListener('DOMContentLoaded', function() { 
  $("#main").fadeOut(); 
  ResetAll();

}, false);

function CloseNUI() {
  $("#main").fadeOut();
  ResetAll();
	$.post('http://tp_clans_displays/close', JSON.stringify({}));
}

$(function() {

	window.addEventListener('message', function(event) {
		
    var item = event.data;

		if (item.type == "enable") {
			document.body.style.display = item.enable ? "block" : "none";

    } else if (item.action == 'sendAnnouncement') {
      
      $("#announcement-title").text(item.title);
      $("#announcement-title-description").text(item.title_description);

      let title_rgba = item.title_rgba != null ? item.title_rgba : "rgba(247, 247, 247, 0.911)";
      let title_description_rgba = item.title_description_rgba != null ? item.title_description_rgba :  "rgba(171, 170, 170, 0.91)";

      $("#announcement-title").css('color', title_rgba);
      $("#announcement-title-description").css('color', title_description_rgba);

      $("#announcement").show();
      $("#main").fadeIn(1000);

    } else if (item.action == "updateTitle") {

      $("#announcement-title").text(item.title);

    } else if (item.action == "updateDescription") {

      $("#announcement-title-description").text(item.title_description);

    } else if (item.action == "close") {
      CloseNUI();
    }

  });

});
