require_relative 'Hand'


hands = [
    "KD 5C 8H 4S KH",
    "AC AC AH 3C 2C",
    "AC AC AH AC 2C",
    "8C 8C AH 8C 8C",
    "8C 7C AC 8C 8C"
]

# TODO create random hands


puts "Analisys..."
puts "-" * 15
hands.each do |h|

    hand = Hand.new h
    puts "#{hand.to_faces} / #{hand.to_suits} -> #{hand.score_hand}, #{hand.rank_desc}"
end



