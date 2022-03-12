class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :condition
      t.integer :price
      t.integer :stock
      t.boolean :display, default: true
      t.text :discription
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
