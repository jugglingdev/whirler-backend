class ChangeDeltaToTextInQuillContents < ActiveRecord::Migration[7.1]
  def change
    change_column :quill_contents, :delta, :text
  end
end
