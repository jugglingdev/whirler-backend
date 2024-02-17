# frozen_string_literal: true

class CarouselBlueprint < Blueprinter::Base
    identifier :id

    view :dashboard do
        fields :title, :description, :thumbnail
    end

    view :carousel_edit do
        association :slides, blueprint: SlideBlueprint, view: :carousel_edit
    end
end
