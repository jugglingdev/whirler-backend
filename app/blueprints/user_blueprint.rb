# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
    identifier :id

    view :signup do
        fields :username, :email, :password, :password_confirmation
    end
    
    view :login do
        fields :username, :password
    end

    view :profile_edit do
        fields :first_name, :last_name, :username, :email
    end

    view :change_password do
        fields :password, :password_confirmation
    end

    view :dashboard do
        association :carousels, blueprint: CarouselBlueprint, view: :dashboard
    end
end
