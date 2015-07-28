class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :job_requested, :text
    add_column :users, :job_posted, :text
  end
end
