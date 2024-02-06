class CreateSlides < ActiveRecord::Migration[7.1]
  def change
    create_table :slides do |t|
      t.string :title
      t.references :carousel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
