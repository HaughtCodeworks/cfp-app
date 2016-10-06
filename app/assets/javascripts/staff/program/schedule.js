$(function() {
  $('.schedule-grid').gridstack({
    handle: '.column-header.room',
    width: $('.schedule-grid .column').length,
    height: 1,
    cellHeight: 60*12+50,
    verticalMargin: 10,
    animate: true
  });

  $('.time-slots').gridstack({
    handle: '.time-slot-content',
    acceptWidgets: '.time-slots',
    oneColumnMode: 'time-slots',
    width: 1,
    cellHeight: 1,
    verticalMargin: 0,
    resizable: { containment: 'parent' },
    animate: true,

  });

  // $(document).on('click', '.schedule-grid .time-slot', onTimeSlotClick);

  function onTimeSlotClick(ev) {
    $.ajax({
      url: $(this).data("time-slot-edit-path")
    });
  }
});