# frozen_string_literal: true

class CarouselBlueprint < Blueprinter::Base
    identifier :id

    view :dashboard do
        fields :title, :description, :thumbnail, :tags
    end

    view :carousel_edit do
        fields :title
        association :slides, blueprint: SlideBlueprint
    end
end
