class CreateDailyReports < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_reports do |t|
      t.date :report_date, null: false
      t.text :content, null: false

      t.timestamps
      t.index :report_date, unique: true
    end
  end
end
