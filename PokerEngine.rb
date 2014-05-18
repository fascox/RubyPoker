require_relative 'RakeInfo'
require 'singleton'


class PokerEngine
  include Singleton

  attr_accessor :rankings

  def initialize

    @rankings = {
          :royal    => { :weight => 9000, :desc => 'Royal Flush'},
          :straflus => { :weight => 8000, :desc => 'Straight Flush'},
          :poker    => { :weight => 7000, :desc => 'Four of a kind'},
          :full     => { :weight => 6000, :desc => 'Full House'},
          :flush    => { :weight => 5000, :desc => 'Flush'},
          :straight => { :weight => 4000, :desc => 'Straight'},
          :tris     => { :weight => 3000, :desc => 'Three of a kind'},
          :twopair  => { :weight => 2000, :desc => 'Two Pair'},
          :pair     => { :weight => 1000, :desc => 'One Pair'},
          :highcard => { :weight => 0,    :desc => 'High Card'},
     }

  end


  # RANKS NOT IMPLEMENTED YET GOES HERE
  #
  def method_missing(m, *args, &block)

    info = Rakeinfo.new
    info.desc = ' not implemented yet.'

    info
  end


  # HIGH CARD
  # ----------------
  def highcard(hand)

    info = Rakeinfo.new

    info.card  = hand.hand.sort_by { |c| c.face_value }.last
    info.score = @rankings[:highcard][:weight] + info.card.face_value
    info.desc  = @rankings[:highcard][:desc]

    info

  end


# PAIR
# ----------------
  def pair(hand)

    info = Rakeinfo.new

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 2}.first

    unless pattern.nil?

      info.card  = pattern.squeeze
      info.score = @rankings[:pair][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:pair][:desc]
    end

    info

  end

# TWO PAIR
# ----------------
  def twopair(hand)

    info = Rakeinfo.new

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first)

    if !pattern.empty? and pattern.count == 2

      info.card  = pattern.first.squeeze
      info.score = @rankings[:twopair][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:twopair][:desc]
    end

    info
  end

# THREE OF A KIND
# ----------------
  def tris(hand)

    info = Rakeinfo.new

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 3}.first

    unless pattern.nil?

      info.card  = pattern.squeeze
      info.score = @rankings[:tris][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:tris][:desc]
    end

    info
  end

 # POKER
 # ----------------
  def poker(hand)

    info = Rakeinfo.new

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 4}.first

    unless pattern.nil?

      info.card  = pattern.squeeze
      info.score = @rankings[:poker][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:poker][:desc]
    end

    info
  end

  # FLUSH
  # ----------------
  def flush(hand)

    info = Rakeinfo.new

    if hand.to_suits.scan(/./).uniq.length == 1

      info.card  = hand.to_suits.squeeze
      info.score = @rankings[:flush][:weight]
      info.desc  = @rankings[:flush][:desc]
    end

    info

  end

  # STRAIGHT
  # ----------------
  def straight(hand)

    info = Rakeinfo.new

    pattern = hand.to_faces.scan(/./).sort.reverse

    if (pattern.max.to_i - pattern.min.to_i == 4) && pattern.uniq.length == 5

      info.card  = pattern.max
      info.score = @rankings[:straight][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:straight][:desc]

    end

    info
  end


  # FULL HOUSE
  # ----------------
  def full(hand)

    info = Rakeinfo.new

    tris = tris(hand)
    pair = pair(hand)

    if (tris.score > 0 && pair.score > 0 )

      info.card  = tris.card
      info.score = @rankings[:full][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:full][:desc]

    end

    info
  end

  # STRAIGHT FLUSH
  # ----------------
  def straflus(hand)

    info = Rakeinfo.new

    straight = straight(hand)
    flush   = flush(hand)

    if (straight.score > 0 && flush.score > 0 )

      info.card  = straight.card
      info.score = @rankings[:straflus][:weight] + Card::weight(info.card)
      info.desc  = @rankings[:straflus][:desc]

    end

    info
  end

  # TODO
  # Royal need straight with symbol implementation :(
end