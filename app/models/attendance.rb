class Attendance < ApplicationRecord
  after_create :welcome_attendance_send

  belongs_to :user
  belongs_to :event

  def welcome_attendance_send
    AttendanceMailer.welcome_attendance_email(self).deliver_now
  end
end
