$(function() {
  // $('.schedule-grid').gridstack({
  //   handle: '.column-header.room',
  //   width: $('.schedule-grid .column').length,
  //   height: 1,
  //   cellHeight: 60*12,
  //   verticalMargin: 10,
  //   animate: true
  // });

  $('.time-slots').gridstack({
    handle: '.time-slot-content',
    acceptWidgets: '.time-slot',
    // oneColumnModeClass: 'time-slots',
    width: 1,
    height: 150,
    cellHeight: 5,
    verticalMargin: 0,
    resizable: { containment: 'parent', handles: 's, n' },
    animate: true,
    float: true
  });

  // $(document).on('click', '.schedule-grid .time-slot', onTimeSlotClick);

  function onTimeSlotClick(ev) {
    $.ajax({
      url: $(this).data("time-slot-edit-path")
    });
  }
});