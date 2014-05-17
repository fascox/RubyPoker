require 'singleton'


class RankEngine
  include Singleton

  def initialize

    @map = {
          :pair  => { :weight => 2000, :desc => "Pair of cards." },
          :tris  => { :weight => 3000, :desc => "Tris of cards." },
          :flush => { :weight => 7000, :desc => "Flush." },
          :poker => { :weight => 8000, :desc => "Poker!" }
     }

  end

  # HIGH CARD
  # ----------------
  def high_card(hand)

    #@ s = hand.sort_by { |c| c.face_value }.last

    # sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    sorted_faces= hand.to_faces.scan(/./).sort.reverse.first
    Card::weight(sorted_faces)
  end



# PAIR OF CARDS
# ----------------
  def pair(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 2}.first

    return 0 , '' if pattern.nil? # || pattern.size != 2
    return @map[:pair][:weight] + Card::weight(pattern.squeeze), @map[:pair][:desc]

  end

# TRIS OF CARDS
# ----------------
  def tris(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 3}.first

    return 0, '' if pattern.nil? # || pattern.size != 3
    return @map[:tris][:weight] + Card::weight(pattern.squeeze), @map[:tris][:desc]

  end

 # POKER
 # ----------------
  def poker(hand)

    sorted_faces = hand.to_faces.scan(/./).sort.reverse.join
    pattern = sorted_faces.scan(/((.)\2{1,})/).map(&:first).reject {|c| c.size != 4}.first

    return 0, '' if pattern.nil? # || pattern.size != 3
    return @map[:poker][:weight] + Card::weight(pattern.squeeze), @map[:poker][:desc]

  end

  # FLUSH
  # ----------------
  def flush(hand)
    return 0, '' if hand.to_suits.scan(/./).uniq.size > 1
    return @map[:flush][:weight],  @map[:flush][:desc]

  end

  # TODO more ranks evaluation

end