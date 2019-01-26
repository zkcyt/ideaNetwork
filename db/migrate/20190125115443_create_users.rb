class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :nickname
      t.text :profile
      t.integer :post_id
      t.integer :like_id

      t.timestamps
    end
  end
end
