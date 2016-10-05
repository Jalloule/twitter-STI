class AddAcceptedToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :accepted, :boolean, default: true
  end
end
