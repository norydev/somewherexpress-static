var openTab = function() {
  var activeTab = $('[href="' + location.hash + '"]');
  activeTab && activeTab.tab('show');
}

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  openTab();
});

