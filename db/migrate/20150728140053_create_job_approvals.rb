class CreateJobApprovals < ActiveRecord::Migration
  def change
    create_table :job_approvals do |t|
      t.integer :user_id
      t.integer :job_id
      t.string :status

      t.timestamps null: false
    end
  end
end
