# frozen_string_literal: true

class CarouselBlueprint < Blueprinter::Base
    identifier :id

    fields :title, :description

    # view :carousel_edit do
    #     association :slides, blueprint: SlideBlueprint
    # end
end
