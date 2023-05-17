class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :attendees, class_name: "User", through: :attendances

  belongs_to :administrator, class_name: "User"

  validates :start_date,
  presence: true
  validates :duration,
  presence: true,
  numericality: {greater_than: 0}
  validate :start_date_cannot_be_in_past
  validate :duration_must_be_multiple_of_five
  validates :title,
  presence: true,
  length: { minimum: 5, maximum: 140}
  validates :description,
  presence: true,
  length: { minimum: 20, maximum: 1000}
  validates :price,
  presence: true,
  numericality: {in: 1..1000}
  validates :location,
  presence: true





  def start_date_cannot_be_in_past
    if start_date.present? && start_date < DateTime.now
    errors.add(:start_date, "ne peut être dans le passé")
    end
  end

  def duration_must_be_multiple_of_five
    if duration.present? && duration % 5 != 0
      errors.add(:duration, "doit être un multiple de 5")
    end
  end

  def end_date
    (start_date + duration * 60)
  end

end
