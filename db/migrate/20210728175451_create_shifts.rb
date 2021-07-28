class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.integer :day
      t.string :start_at
      t.string :end_at
      t.numeric :duration
      t.string :role
      t.string :color
      t.timestamps
      t.integer :employee_id
    end
  end
end
