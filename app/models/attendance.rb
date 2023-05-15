class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def welcome_send
    AttendanceMailer.welcome_attendance_email(self).deliver_now
  end
end
