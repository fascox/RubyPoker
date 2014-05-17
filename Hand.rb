require_relative 'Card'
require_relative 'RankEngine'

class Hand

  attr_accessor :hand, :rank_score, :rank_desc

  def initialize(fmt_card_str)


    @rules = RankEngine.instance

    @hand = []

    cards_on_hand = fmt_card_str.split

    cards_on_hand.each do |o|
      # @hand << Card.new(o[1],o[0]) # <-- don't like but works for now
      @hand << Card.new(o)
    end

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


  def score_hand

    rankings = [
                :poker,
                :flush,
                :tris,
                :pair,
                :high_card
               ]

    rankings.each do |rank_check|

        @rank_score, @rank_desc = @rules.send rank_check, self

        break if @rank_score > 0
    end

    @rank_score
  end




end



