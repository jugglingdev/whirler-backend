# frozen_string_literal: true

class CarouselBlueprint < Blueprinter::Base
    identifier :id

    fields :title, :description

    view :normal do
        association :user, blueprint: UserBlueprint
    end
end
