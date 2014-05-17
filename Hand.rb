require_relative 'Card'
require_relative 'RankEngine'

class Hand

  attr_accessor :hand, :rank_score, :rank_desc

  def initialize

    @rules_engine = RankEngine.instance
    @hand = []

  end

  def build_from_string(string_hand)

    cards_on_hand = string_hand.split
    cards_on_hand.each do |o|
      # @hand << Card.new(o[1],o[0]) # <-- don't like but works for now
      @hand << Card.new(o)
    end

  end

  def build_from_set(cards)

    @hand = cards

  end

  def << (card)

    @hand << card

  end

  def validate

    puts "invalid hand" if @hand.size != 5

  end

  def to_s
    @hand.join(' ')
  end

  def to_suits
      @hand.map {|x| x.to_suit }.join
  end

  def to_faces

    @hand.map {|x| x.to_face }.join
  end

  def rank_score

    @rules_engine.rankings.each_key do |rank|

        @rank_score, @rank_desc = @rules_engine.send rank, self

        break if @rank_score > 0
    end

    #@rank_score, @rank_desc = high_card if @rank_score == 0
    @rank_score
  end


  # HIGH CARD
  # ----------------
  def high_card

    high_card = to_faces.scan(/./).sort.reverse.first

    return Card::weight(high_card) , "High card #{high_card}"

  end
end



