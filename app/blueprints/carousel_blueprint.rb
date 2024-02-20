# frozen_string_literal: true

class CarouselBlueprint < Blueprinter::Base
    identifier :id

    view :dashboard do
        fields :title, :description, :thumbnail, :tags, :user_id
    end

    view :carousel_edit do
        fields :title
        association :slides, blueprint: SlideBlueprint, view: :carousel_edit
    end
end
