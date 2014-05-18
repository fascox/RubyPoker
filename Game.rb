require_relative 'Card'
require_relative 'Hand'


def play_hand(param1 = '8C 7C AC 8C 8C', param2 = '8H 7C 8D 8C 8C')

  p1_hand = Hand.new
  p2_hand = Hand.new

  p1_hand.build_from_string param1
  p2_hand.build_from_string param2

  results p1_hand, p2_hand
end

def play_shuffle

  # shuffle new deck cards
  new_deck = Card::deck.shuffle

  p1_hand = Hand.new
  p2_hand = Hand.new

  #
  5.times do

    p1_hand << new_deck.pop
    p2_hand << new_deck.pop

  end

  results p1_hand, p2_hand
end

def results(p1_hand, p2_hand)

  # evaluate score
  p1_score = p1_hand.rank_score
  p2_score = p2_hand.rank_score

  # display results
  puts "Player One cards -> #{p1_hand} -> #{p1_hand.rank_desc}"
  puts "Player Two cards -> #{p2_hand} -> #{p2_hand.rank_desc}"


  puts "\n"
  puts 'Results:'
  puts '-' * 8

  # check winner or split
  case
    when p1_score > p2_score
      puts "Player One wins with #{p1_hand.rank_desc}"
    when p1_score < p2_score
      puts "Player Two wins with #{p2_hand.rank_desc}"
    else
      puts "Split."
  end

end

def play_test

    hands_test = [
        'KD 5C 8H 4S KH',
        'AC AC AH 3C 2C',
        'AC AC AH AC 2C',
        '8C 8C AH 8C 8C',
        '8C 7C AC 8C 8C',
        '6C 7C 8C 9H 2C',
        '5S 2C 3H 4H QH',
        '5S 5C 3H 4H 4H',
        '5S 5C QH QH 4H',
        '2C 3C 4C 5S 6S',
        '6C 6C QC QH QC',
        '8C 9C 6C 5C 7C'

    ]

    puts 'Testing...'
    puts '-' * 15
    hands_test.each do |h|

      hand = Hand.new
      hand.build_from_string h
      puts "#{hand.to_faces} / #{hand.to_suits} -> score: #{hand.rank_score.to_s.rjust(5,'0')}, #{hand.rank_desc}"
    end

end

def play_help

  puts 'options:'
  puts 'hand  <str1> <str2> - play hands with two formatted string.'
  puts 'shuffle             - play random hands'
  puts 'test                - rankings tests'
  puts 'help                - this help (default)'
end


if ARGV.size < 1

  action = 'help'
else
  action = ARGV[0]
end


begin

  puts
  puts 'Poker Simulator - by fascox'
  puts '-' * 27

  if action == 'hand'
    self.send "play_#{action}".to_sym, ARGV[1], ARGV[2]
  else
    self.send "play_#{action}".to_sym
  end

 rescue

  play_help
end
