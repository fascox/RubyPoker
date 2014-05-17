require_relative 'Card'
require_relative 'Hand'

=begin
hands_test = [
    'KD 5C 8H 4S KH',
    'AC AC AH 3C 2C',
    'AC AC AH AC 2C',
    '8C 8C AH 8C 8C',
    '8C 7C AC 8C 8C',
    '5S 2C 3H 4H QH',
    '5S 5C 3H 4H 4H',
    '5S 5C QH QH 4H',
    '2C 3C 4C 5S 6S',
    '6C 7C 8C 9H TC'

]

puts 'Testing...'
puts '-' * 15
hands_test.each do |h|

  hand = Hand.new h
  puts "#{hand.to_faces} / #{hand.to_suits} -> #{hand.score_hand}, #{hand.rank_desc}"
end
=end


# shuffle new deck cards
new_deck = Card::deck.shuffle

p1_hand = Hand.new
p2_hand = Hand.new

5.times do

  p1_hand << new_deck.pop
  p2_hand << new_deck.pop

end


# # evaluate hands
# p1_hand.evaluate
# p2_hand.evaluate



# evaluate score
p1_score = p1_hand.rank_score
p2_score = p2_hand.rank_score

puts 'Playing poker...'
puts '-' * 15
puts "Player One cards -> #{p1_hand} -> #{p1_hand.rank_desc}"
puts "Player Two cards -> #{p2_hand} -> #{p2_hand.rank_desc}"


puts "\n"
puts 'Results:'
puts '-' * 10


# check if two players have nothing in hand
if (p1_hand.rank_score + p2_hand.rank_score) < 1000


  p1_score = p1_hand.high_card
  p2_score = p2_hand.high_card

  # if same high card end game with a split
  # (could be improved and consider next high card omn hand)
  if p1_hand.rank_score == p2_hand.rank_score
    puts "Split."
    exit
  end
end

# check winner or split
if p1_score > p2_score
  puts "Player One wins with #{p1_hand.rank_desc}"
elsif p1_score < p2_score
  puts "Player Two wins with #{p2_hand.rank_desc}"
else
  puts "Split."
end









