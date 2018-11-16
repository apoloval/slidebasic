module Slidebasic
  class Slide
    def initialize(slide, is_final: false)
      @slide = slide
      @is_final = is_final
    end

    def process(basic)
      basic.begin_slide(title: title)
      content.each do |c|
        c.process(basic)
      end
      basic.end_slide(is_final: @is_final)
    end

    private

    def title
      @slide['title']
    end

    def content
      cc = @slide['content'] || []
      cc.map { |c| Content.new(c) }
    end
  end
end
