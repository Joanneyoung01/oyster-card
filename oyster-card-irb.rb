require './lib/Oystercard.rb'

card = Oystercard.new

card.top_up(15)

card.balance

card.touch_in("Balham")

card.entry_station

card.touch_out("Clapham")

card.exit_station

card.history