class AddBirthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vip, :boolean, default: false
    add_column :users, :birth, :date
  end
end
