class CreateCarousels < ActiveRecord::Migration[7.1]
  def change
    create_table :carousels do |t|
      t.string :title
      t.string :description
      t.string :thumbnail
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
