class Card

  attr_accessor :suit, :val, :face_value

  # SUITS_SET = 'CDHS'
  SUITS_SET =  '♣♦♥♠'
  VALS_SET  = 'a23456789TJQKA'

  SUITS = { 'C' => 0, 'D' =>1, 'S' => 2, 'H' => 3 }

  VALS = {  '2' =>1, '3' => 2, '4' =>3, '5' => 4, '6' => 5,  '7' => 6, '8' => 7, '9' => 8, 'T' => 9, 'J' => 10, 'Q' => 11, 'K' =>12, 'A' => 13 }


  def initialize(code)

      v, s = code.scan(/./)

      builder v, s
  end

  def builder(val, suit)

      @suit = SUITS[suit]
      @val = VALS[val]

      @face_value = @val # (@suit * 13) + @val

      # GUARD
      raise StandardError if @suit.nil? || @val.nil?

  end

  def self.weight(face)

    VALS[face]
  end

  def self.face(val)

	  VALS.key(val)
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

          deck << Card.new( v + s)

        end
      end

    deck
  end

  # Retrun a restricted deck (7 to A)
  # --------------------------------
  def self.deck_seven

    deck = []

    SUITS.each_key do |s|
      VALS.each do |k, v|

        next if v < 6
        deck << Card.new( k + s)

      end
    end

    deck
  end

end
