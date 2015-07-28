class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :duration
      t.money :budget
      t.text :description
      t.string :skill, array: true
      t.string :status
      t.integer :create_by

      t.timestamps null: false
    end
  end
end
