class CreateJoinTableCarouselTag < ActiveRecord::Migration[7.1]
  def change
    create_join_table :carousels, :tags do |t|
      # t.index [:carousel_id, :tag_id]
      # t.index [:tag_id, :carousel_id]
    end
  end
end
