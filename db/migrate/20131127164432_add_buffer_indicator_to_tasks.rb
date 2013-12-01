class AddBufferIndicatorToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :buffer, :boolean
  end
end
