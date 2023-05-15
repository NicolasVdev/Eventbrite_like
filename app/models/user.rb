class User < ApplicationRecord
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
  has_many :attendances
  has_many :events, through: :attendances
  has_many :events, foreign_key: "administrator_id", class_name: "Event"

  def administrator?
    events.count > 0
  end

end
