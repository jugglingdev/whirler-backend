class AddDefaultToSlides < ActiveRecord::Migration[7.1]
  def change
    change_column_default :slides, :title, from: nil, to: ''
  end
end
