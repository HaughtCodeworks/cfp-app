$(function() {

  $('.time-slots').gridstack({
    handle: '.time-slot-content',
    acceptWidgets: '.time-slot',
    oneColumnModeClass: 'time-slots',
    width: 1,
    height: 150,
    cellHeight: 5,
    verticalMargin: 0,
    resizable: { containment: 'parent', handles: 's, n' },
    // animate: true,
    float: true,
    staticGrid: true
  });

  $(document).on('click', '.schedule-grid .time-slot', onTimeSlotClick);

  function onTimeSlotClick(ev) {
    $.ajax({
      url: $(this).data('editPath')
    });
  }
});