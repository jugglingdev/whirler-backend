# frozen_string_literal: true

class SlideBlueprint < Blueprinter::Base
    identifier :id
  
    view :carousel_edit do
      fields :title
      association :quill_contents, blueprint: QuillContentBlueprint
    end
end
