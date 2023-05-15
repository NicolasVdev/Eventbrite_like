class Attendance < ApplicationRecord
  after_create :welcome_attendance_email

  belongs_to :user
  belongs_to :event

  def welcome_send
    AttendanceMailer.welcome_attendance_email(self).deliver_now
  end
end
