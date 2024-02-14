# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
    identifier :id

    view :normal do
        fields :username, :email
    end

    view :carousels do
        association :carousels, blueprint: CarouselBlueprint
    end
end
