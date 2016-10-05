class AddNeedAcceptColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :need_accept, :boolean, default: false
  end
end
