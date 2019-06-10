import React, { Component, Fragment } from "react"
import PropTypes from "prop-types"

import ScheduleSlot from './ScheduleSlot'
import Preview from './Preview'

class ScheduleColumn extends Component {
  render() {
    const {
      height,
      room,
      startTime,
      ripTime,
      dayViewing,
      draggedSession,
      changeDragged,
      csrf,
      sessions,
      tracks,
      previewSlots,
      slots,
      handleMoveSessionResponse,
      showErrors,
    } = this.props

    const roomID = room.id

    const previews = previewSlots.filter(preview => {
      return parseInt(preview.room) === roomID && parseInt(preview.day) === dayViewing
    }).map((preview, index) => {
      return <Preview key={'preview' + index} preview={preview} startTime={startTime} />
    })

    const thisRoomThisDaySlots = slots.filter(slot => slot.room_id == roomID && slot.conference_day == dayViewing)

    let rowSlots = <Fragment />
    if (thisRoomThisDaySlots) {
      rowSlots = thisRoomThisDaySlots.map(slot => {
        return (
          <ScheduleSlot 
            draggedSession={draggedSession} 
            slot={slot} 
            ripTime={ripTime} 
            startTime={startTime} 
            key={slot.id}
            changeDragged={changeDragged}
            csrf={csrf}
            sessions={sessions}
            tracks={tracks}
            handleMoveSessionResponse={handleMoveSessionResponse}
            showErrors={showErrors}
          />
        )
      })
    }
    
    return (
      <Fragment>
        <div
          className="schedule_column"
          key={"column " + room.name}
          style={{ height }}
        >
          <div className="schedule_time_slots">
            {previews}
            {rowSlots}
          </div>
        </div>
      </Fragment>
    )
  }
}

ScheduleColumn.propTypes = {
  height: PropTypes.string,
  schedule: PropTypes.object,
  dayViewing: PropTypes.number,
  startTime: PropTypes.number,
  ripTime: PropTypes.func,
  room: PropTypes.object,
  changeDragged: PropTypes.func,
  draggedSession: PropTypes.object,
  sessions: PropTypes.array,
  tracks: PropTypes.array,
  previewSlots: PropTypes.array,
  handleMoveSessionResponse: PropTypes.func,
  showErrors: PropTypes.func,
}

ScheduleColumn.defaultProps = {sessions: []}

export default ScheduleColumn