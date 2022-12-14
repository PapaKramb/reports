var options = {
  valueNames: [ 'report.project_id-1', 'report.what_is_done' ]
};

var reportList = new List('reports', options);
$('.search-name').on('keyup', function() {
  var searchString = $(this).val();
  reportList.search(searchString, ['report.project_id-1']);
});
