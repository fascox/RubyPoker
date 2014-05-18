require_relative 'Card'
require_relative 'PokerEngine'

class Hand

  attr_accessor :hand, :rank_score, :rank_desc

  def initialize

    @rules_engine = PokerEngine.instance
    @hand = []

  end

  def build_from_string(string_hand)

    @hand = []
    cards_on_hand = string_hand.split
    cards_on_hand.each { |o| @hand << Card.new(o) }

  end

  def build_from_set(cards)

    @hand = cards

  end

  def << (card)

    @hand << card

  end

  def validate

    @hand.size == 5

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

    evaluate
  end

  def evaluate

    # guard
    unless validate

      @rank_score = -1
      @rank_desc  = 'invalid hand'
      return
    end


    @rules_engine.rankings.each_key do |rank|

        info = @rules_engine.send rank, self

        @rank_score = info.score
        @rank_desc  = "#{info.desc} with #{info.card}"

        break if @rank_score > 0
    end

    @rank_score
  end

end



