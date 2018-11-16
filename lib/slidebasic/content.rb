module Slidebasic
  class Content
    def initialize(content)
      @content = content
    end

    def process(basic)
      process_item(basic) if item?
      process_section(basic) if section?
    end

    private

    def process_item(basic)
      basic.define_item(item)
    end

    def process_section(basic)
      basic.define_section(section)
      sub_content.each do |content|
        content.process(basic)
      end
    end

    def item
      @content['item']
    end

    def item?
      !item.nil?
    end

    def section
      @content['section']
    end

    def section?
      !section.nil?
    end

    def sub_content
      sc = @content['content'] || []
      sc.map { |c| Content.new(c) }
    end

    def content
      cc = @slide['content'] || []
      cc.map { |c| Content.new(c) }
    end
  end
end
