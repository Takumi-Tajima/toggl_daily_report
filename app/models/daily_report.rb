class DailyReport < ApplicationRecord
  validates :report_date, presence: true, uniqueness: true
  validates :content, presence: true

  scope :default_order, -> { order(:report_date, :created_at) }
end
