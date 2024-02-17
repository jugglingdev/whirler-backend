# frozen_string_literal: true

class QuillContentBlueprint < Blueprinter::Base
    identifier :id

    fields :width, :height, :x, :y, :delta
end
