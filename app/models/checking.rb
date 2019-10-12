class Checking < ApplicationRecord
  TYPES = %w{ in out }
  
  belongs_to :user

  after_initialize :set_defaults

  validates :check_type, :happend_at, presence: true
  validates :check_type, inclusion: { in: TYPES }

  def set_defaults
    self.happend_at ||= Time.zone.now
  end
end