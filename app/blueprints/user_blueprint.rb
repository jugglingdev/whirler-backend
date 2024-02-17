# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
    identifier :id

    view :profile_edit do
        fields :first_name, :last_name, :username, :email
    end

    view :dashboard do
        fields :username
        association :carousels, blueprint: CarouselBlueprint
    end
end
