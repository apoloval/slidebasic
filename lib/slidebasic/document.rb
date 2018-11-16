module Slidebasic
  class Document
    def initialize(doc)
      @doc = doc
    end

    def process(basic)
      basic.begin_slide
      basic.define_cover(title, subtitle: subtitle)
      basic.end_slide

      slides.each do |slide|
        slide.process(basic)
      end
    end

    private

    def title
      @doc['title']
    end

    def subtitle
      @doc['subtitle']
    end

    def slides
      ss = @doc['slides'] || []
      ss.each_with_index.map do |s, i|
        Slide.new(s, is_final: i == ss.size - 1)
      end
    end
  end
end
