class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.float :lower
      t.float :upper
      t.float :error
      t.float :estimate

      t.timestamps
    end
  end
end
