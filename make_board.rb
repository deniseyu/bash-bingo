# HOW TO USE
#
# run `ruby make_board.rb 3` where 3 is an example number of boards to be
# generated. right now there is no error handling if you put a nonsense number
# boards get saved in this directory, as board_1.txt, board_2.txt, etc

NUMBER_OF_BOARDS = ARGV[0]

def make_random_rows
  # todo: can this be opened just once and memoized
  # this is naughty for performance
  commands = File.open('commands.txt', 'r')
  randomized = commands.to_a.map(&:strip).shuffle

  row_1 = randomized[0..4]
  row_2 = randomized[5..9]
  row_3 = randomized[10..13].insert(2, "FREE")
  row_4 = randomized[14..18]
  row_5 = randomized[19..23]

  [row_1, row_2, row_3, row_4, row_5]
end

def make_board!(number)
  rows = make_random_rows

  # each row is 70 chars across, because that's the default
  # width that you can print without resizing margins or font size
  # i am lazy
  File.open("board_#{number}.txt", 'w') do |f|
    f << '=' * 67 + "\n"
    f << '||' + ' '*63 + '||' + "\n"
    f << '||' + ' '*26 + 'BASH BINGO' + ' '*27 + '||' + "\n"
    f << '||' + ' '*63 + '||' + "\n"
    f << '=' * 67 + "\n"

    rows.each_with_index do |row, i|
      row_entry = ""
      row.each do |cmd|
        cell = ("  " + cmd).ljust(11, ' ')
        row_entry += '||' + cell
      end
      f << '||           '*5 + '||' + "\n"
      f << row_entry + '||' + "\n"
      f << '||           '*5 + '||' + "\n"

      unless i == 4
        f << '||' + '='*63 + '||' + "\n"
      end
    end

    f << '=' * 67 + "\n"
  end
end

NUMBER_OF_BOARDS.to_i.times do |index|
  make_board!(index+1)
end

