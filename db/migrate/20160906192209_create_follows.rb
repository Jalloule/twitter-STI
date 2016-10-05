class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower
      t.references :followed

      t.timestamps null: false
    end
  end
end
