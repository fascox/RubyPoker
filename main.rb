require_relative 'lib/Game'

if ARGV.size < 1

	action = 'help'
else
	action = ARGV[0]
end


begin

	puts
	puts 'Poker Simulator - by fascox'
	puts '-' * 27

	game = Game.new

	case action
		when 'hand'
			game.send "play_#{action}".to_sym, ARGV[1], ARGV[2]
		when 'stats'
			game.send "play_#{action}".to_sym, ARGV[1]
		else
			game.send "play_#{action}".to_sym
	end

rescue

	game.play_help
end

