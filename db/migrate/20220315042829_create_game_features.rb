class CreateGameFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :game_features do |t|
      t.references :game, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
