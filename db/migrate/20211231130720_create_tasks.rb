class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :note
      t.datetime :created_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
