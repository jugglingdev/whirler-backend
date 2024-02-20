# frozen_string_literal: true

class CarouselBlueprint < Blueprinter::Base
    identifier :id

    view :dashboard do
        fields :title, :description, :thumbnail, :user_id
        association :tags, blueprint: TagBlueprint
    end

    view :carousel_edit do
        fields :title
        association :slides, blueprint: SlideBlueprint, view: :carousel_edit
    end
end
