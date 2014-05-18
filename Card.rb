class Card

  attr_accessor :suit, :val, :face_value

  # SUITS_SET = 'CDHS'
  SUITS_SET =  '♣♦♥♠'
  VALS_SET  = 'a23456789TJQKA'

  SUITS = { 'S' => 0, 'D' =>1, 'C' => 2, 'H' => 3 }

  VALS = { 'A' => 13, '2' =>1, '3' => 2, '4' =>3, '5' => 4, '6' => 5,  '7' => 6, '8' => 7, '9' => 8, 'T' => 9, 'J' => 10, 'Q' => 11, 'K' =>12 }


  def initialize(code)

      v, s = code.scan(/./)
      builder v, s

  end

  def builder(val, suit)

      @suit = SUITS[suit]
      @val = VALS[val]

      @face_value = @val # (@suit * 13) + @val

  end

  def self.weight(face)

    VALS[face]
  end

  def to_face

    VALS_SET[@val].chr
  end


  def to_suit

    SUITS_SET[@suit].chr
  end

  def to_s
    VALS_SET[@val].chr + SUITS_SET[@suit].chr # + " (#{@face_value})"
  end


  # Retrun a complete deck
  # ----------------------
  def self.deck

    deck = []

      SUITS.each_key do |s|
        VALS.each_key do |v|

          next if v == 'a'
          deck << Card.new( v + s)

        end
      end

    deck
  end

end
