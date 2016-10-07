class Staff::TimeSlotDecorator < Draper::Decorator
  decorates :time_slot
  delegate_all

  def start_time
    object.start_time.try(:to_s, :time)
  end

  def end_time
    object.end_time.try(:to_s, :time)
  end

  def time_slot_id
    object.id
  end

  def row_data(buttons: false)
    row = [object.conference_day, start_time, end_time, linked_title,
           object.presenter, object.room_name, object.track_name]

    row << action_links if buttons
    row
  end

  def row
    {id: object.id, values: row_data(buttons: true)}
  end

  def action_links
    [
      h.link_to('Edit',
                h.edit_event_staff_time_slot_path(object.event, object),
                class: 'btn btn-primary btn-xs',
                remote: true,
                data: {toggle: 'modal', target: "#time-slot-edit-dialog"}),

      h.link_to('Remove',
                h.event_staff_time_slot_path(object.event, object),
                method: :delete,
                data: {confirm: "Are you sure you want to remove this time slot?"},
                remote: true,
                class: 'btn btn-danger btn-xs')
    ].join("\n").html_safe
  end

  def unscheduled_program_sessions
    program_sessions = object.event.program_sessions.unscheduled

    if object.program_session
      program_sessions.unshift(object.program_session)
    end

    program_sessions.map do |ps|
      [ps.title, ps.id, { selected: ps == object.program_session, data: {
          'title' => ps.title,
          'track' => ps.track.try(:name),
          'speaker' => ps.speaker_names,
          'abstract' => ps.abstract,
          'confirmation-notes' => ps.proposal.try(:confirmation_notes) || ''
      }}]
    end
  end

  def linked_title
    if object.program_session.present?
      h.link_to(object.program_session.title,
                h.event_staff_program_session_path(object.event, object.program_session))
    else
      object.title
    end
  end

  def conference_wide_title
    object.title + ": " + room_name
  end

  def supplemental_fields_visibility_css
    object.program_session.present? ? 'hidden' : ''
  end

  def cell_data_attr
    {"time-slot-edit-path" => h.edit_event_staff_time_slot_path(object.event, object), toggle: 'modal', target: "#time-slot-edit-dialog"}
  end

  def item_data
    ts = object
    min = 60*8 # start at 8am
    starts = (ts.start_time.to_i - ts.start_time.beginning_of_day.to_i)/60 - min
    ends = (ts.end_time.to_i - ts.end_time.beginning_of_day.to_i)/60 - min
    {
        gs_x: 0,
        gs_y: starts/5,
        gs_width: 1,
        gs_height: (ends - starts)/5,
        edit_path:  h.edit_event_staff_time_slot_path(object.event, object),
        toggle: 'modal',
        target: '#time-slot-edit-dialog'
    }
  end

  private

  def speaker_names(session)
    session.speakers.map(&:name).join(', ') if session
  end
end
