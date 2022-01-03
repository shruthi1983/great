class ChangeDataTypeDatetime < ActiveRecord::Migration[5.2]
  def change
  	change_column :tasks, :created_at, :date
  	change_column :tasks, :completed_at, :date
  end
end
