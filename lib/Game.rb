require_relative 'Card'
require_relative 'Hand'


class Game

	def play_hand(param1 = '8C 7C AC 8C 8C', param2 = '8H 7C 8D 8C 8C')

		p1_hand = Hand.new
		p2_hand = Hand.new

		p1_hand.build_from_string param1
		p2_hand.build_from_string param2

		results p1_hand, p2_hand
	end

	def play_shuffle

		# shuffle new deck cards
		new_deck = Card::deck_seven.shuffle

		p1_hand = Hand.new
		p2_hand = Hand.new

		#
		5.times do

			p1_hand << new_deck.pop
			p2_hand << new_deck.pop

		end

		results p1_hand, p2_hand
	end


	def play_holdem

		# shuffle new deck cards
		new_deck = Card::deck.shuffle

		p1_hand = Hand.new
		p2_hand = Hand.new

		5.times do

			deal = new_deck.pop
			p1_hand << deal
			p2_hand << deal
		end

		2.times do

			p1_hand << new_deck.pop
			p2_hand << new_deck.pop

		end

		results p1_hand, p2_hand
	end

	def results(p1_hand, p2_hand)

		# evaluate score
		p1_score = p1_hand.rank_score
		p2_score = p2_hand.rank_score

		# display results
		puts "Player One cards -> #{p1_hand} -> #{p1_hand.rank_desc}"
		puts "Player Two cards -> #{p2_hand} -> #{p2_hand.rank_desc}"


		puts "\n"
		puts 'Results:'
		puts '-' * 8

		# check winner or split
		case
			when p1_score > p2_score
				puts "Player One wins with #{p1_hand.rank_desc}"
			when p1_score < p2_score
				puts "Player Two wins with #{p2_hand.rank_desc}"
			else
				puts 'Split.'
		end

	end

	def play_test

		hands_test = [

				'KD 5C 8Z 4S KH',
				'6C 7C 8C 9H 2C',
				'5S 2C 3H 4H QH',
				'KD 5C 8H 4S KH',
				'5S 5C 3H 4H 4H',
				'5S 5C QH QH 4H',
				'AC AC AH 3C 2C',
				'2C 3C 4C 5S 6S',
				'JD KC TH QS 9H',
				'JD KC TH QS AH',
				'8C 7C AC 8C 8C',
				'6C 6C QC QH QC',
				'8C 8C AH 8C 8C',
				'AC AC AH AC 2C',
				'8C 9C 6C 5C 7C',
				'JD KD TD QD AD'
		]

		puts 'Testing...'
		puts '-' * 15
		hands_test.each do |h|

			hand = Hand.new
			hand.build_from_string h
			puts "#{hand.to_faces} / #{hand.to_suits} -> score: #{hand.rank_score.to_s.rjust(5, '0')}, #{hand.rank_desc}"
		end

	end


	def play_stats(t)

		t ||= 5000

		t = t.to_i

		puts "Running stats on #{t} times...\n\tplease wait"
		stat = Hash.new(0)

		t.times do

			# shuffle new deck cards
			new_deck = Card::deck_seven.shuffle

			p1_hand = Hand.new

			5.times do

				p1_hand << new_deck.pop
			end

			p1_hand.evaluate
			stat[p1_hand.rank] += 1

		end

		results = stat.sort_by { |k, v| v }.reverse

		puts "\nCalculated statistics:\n"
		results.each { |k, v| print "\t#{k.ljust 15}\t#{v.to_s.rjust 4} (#{(v * 100) / t }%)\n" }
		puts "done."
	end

	def play_help

		puts 'options:'
		puts 'hand  <str1> <str2> - play hands with two formatted string.'
		puts 'shuffle             - play random hands'
		puts 'holdem              - play holdem with 7 cards'
		puts 'test                - rankings tests'
		puts 'help                - this help (default)'
	end

end
