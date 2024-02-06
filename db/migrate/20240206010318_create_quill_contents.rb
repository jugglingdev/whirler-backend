class CreateQuillContents < ActiveRecord::Migration[7.1]
  def change
    create_table :quill_contents do |t|
      t.float :width
      t.float :height
      t.float :x
      t.float :y
      t.string :delta
      t.references :slide, null: false, foreign_key: true

      t.timestamps
    end
  end
end
