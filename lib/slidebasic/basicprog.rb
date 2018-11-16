module Slidebasic
  # A basic program
  class BasicProg
    SCREEN_WIDTH = 40
    SCREEN_HEIGHT = 24

    TEXT_ENCODING = 'IBM437'.freeze

    def initialize
      @lines = []
      @line_counter = 10
      @slide_counter = 1
      @row_counter = 0

      add_init_block
    end

    def begin_slide(title: nil)
      @line_counter = slide_start(slide_counter)
      @row_counter = 0
      add_line('CLS')
      if title
        add_text(0, title)
        add_text(1, '=' * title.size)
        @row_counter = 3
      end
    end

    def end_slide(is_final: false)
      add_line("GOSUB #{waitkey}")
      add_move_backwards
      add_move_forwards(is_final)
      add_line("GOTO #{slide_start(slide_counter)}")

      inc_slide_counter(1)
    end

    def define_cover(title, subtitle: nil)
      @row_counter = add_text(10, title, align: :center) + 1
      add_text(row_counter, subtitle, align: :center) unless subtitle.nil?
    end

    def define_section(text)
      @row_counter = add_text(row_counter + 1, text) + 1
    end

    def define_item(text)
      @row_counter = add_text(row_counter, "- #{text}", margin: 2)
    end

    def print_lines(file)
      @lines.each do |line|
        file.print "#{line}\r\n"
      end
    end

    private

    attr_reader :line_counter
    attr_reader :row_counter
    attr_reader :slide_counter

    attr_reader :waitkey
    attr_reader :exit

    def add_init_block
      add_line("CLS:KEY OFF:SCREEN 0:WIDTH #{SCREEN_WIDTH}")
      add_line("GOTO #{slide_start(1)}")
      @waitkey = add_line('REM SUBROUTINE: read a movement key')
      add_line('A$=INKEY$')
      add_line('IF A$="" GOTO ' + waitkey.to_s)
      add_line('IF A$=CHR$(27) THEN CLS:END')
      add_line('IF A$=CHR$(29) THEN MOV=-1:RETURN')
      add_line('IF A$=CHR$(28) THEN MOV=1:RETURN')
      add_line('MOV=0:RETURN')
      @exit = add_line('REM SUBROUTINE: terminate the program')
      add_line('CLS:LOCATE 0,0:PRINT "Thanks for using Slidebasic!"')
      add_line('PRINT "http://github.com/apoloval/slidebasic"')
      add_line('KEY ON:END')
    end

    def add_move_backwards
      if slide_counter == 1
        add_line("IF MOV=-1 THEN GOTO #{exit}")
      else
        add_line("IF MOV=-1 THEN GOTO #{slide_start(slide_counter - 1)}")
      end
    end

    def add_move_forwards(is_final)
      if is_final
        add_line("IF MOV=1 THEN #{exit}")
      else
        add_line("IF MOV=1 THEN GOTO #{slide_start(slide_counter + 1)}")
      end
    end

    def add_text(row, text, align: :left, margin: 0)
      split_by_len(text, margin).each do |text_line|
        col = calculate_col(text_line, align)
        add_line("LOCATE #{col},#{row}:PRINT \"#{text_line}\"")
        row += 1
      end
      row
    end

    def split_by_len(text, margin)
      tokens = text.split(/\s/)
      lines = []
      buff = ''
      tokens.each do |t|
        if buff.empty?
          buff = t
        elsif SCREEN_WIDTH < (buff + t).size + 1
          lines <<= buff
          buff = (' ' * margin) + t
        else
          buff <<= ' ' + t
        end
      end
      unless buff.empty?
        lines <<= buff
      end
      lines
    end

    def calculate_col(text, align)
      case align
      when :right
        SCREEN_WIDTH - text.size
      when :center
        (SCREEN_WIDTH - text.size) / 2
      else
        0
      end
    end

    def add_line(inst)
      counter = line_counter
      append_line(line_counter, inst)
      inc_line_counter(10)
      counter
    end

    def slide_start(slide_num)
      return 10 if slide_num.zero?
      slide_num * 500
    end

    def append_line(line, inst)
      @lines <<= "#{line} #{inst.encode(TEXT_ENCODING)}"
    end

    def inc_line_counter(amount)
      @line_counter += amount
    end

    def inc_slide_counter(amount)
      @slide_counter += amount
    end
  end
end
