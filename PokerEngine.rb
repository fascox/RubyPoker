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
     }

  end

  def method_missing(m, *args, &block)
    return 0, 'not implemented yet.'
  end





# PAIR
# ----------------
  def pair(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 2}.first

    return 0 , '' if pattern.nil?
    card = pattern.squeeze
    return @rankings[:pair][:weight] + Card::weight(card), @rankings[:pair][:desc] + " of #{card}"

  end

# TWO PAIR
# ----------------
  def twopair(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first)

    return 0 , '' if pattern.empty? ||  pattern.count < 2

    card = pattern.first.squeeze
    return @rankings[:twopair][:weight] + Card::weight(card), @rankings[:twopair][:desc] + " of #{card}"

  end

# THREE OF A KIND
# ----------------
  def tris(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 3}.first

    return 0, '' if pattern.nil?
    card = pattern.squeeze
    return @rankings[:tris][:weight] + Card::weight(card), @rankings[:tris][:desc] + " of #{card}"

  end

 # POKER
 # ----------------
  def poker(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 4}.first

    return 0, '' if pattern.nil?
    card = pattern.squeeze
    return @rankings[:poker][:weight] + Card::weight(card), @rankings[:poker][:desc] + " of #{card}"

  end

  # FLUSH
  # ----------------
  def flush(hand)

    return 0, '' if hand.to_suits.scan(/./).uniq.length > 1
    card = hand.to_suits.squeeze
    return @rankings[:flush][:weight],  @rankings[:flush][:desc] + " of #{card}"

  end

  # STRAIGHT
  # ----------------
  def straight(hand)

    pattern = hand.to_faces.scan(/./).sort.reverse

    if (pattern.max.to_i - pattern.min.to_i == 4) && pattern.uniq.length == 5

      return @rankings[:straight][:weight], @rankings[:straight][:desc]

    end

    return 0, ''
  end

  # TODO more ranks evaluation

end