class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres do |t|
      t.text :name
      t.text :memo
      t.integer :post_id

      t.timestamps
    end
  end
end
