note
	description	: "Objects that describe the behaviour of a cook"
	author		: "Robin Stoll"
	date		: "13.05.2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	COOK

create
	make

feature

		make (a_pot: separate POT)
				-- Initialization.
			require
				a_pot /= void
			do
				pot := a_pot
			end

feature

		do_cooking
				-- Wrapper call to control pot.
			do
				io.put_string ("cook: do_cooking %N")
				cook (pot)
			end

		cook (a_pot: separate POT)
				-- Fill the pot.
			require
				a_pot.is_empty
			do
				io.put_string ("Filling the pot...%N")
				a_pot.fill
			ensure
				a_pot.is_full
			end

feature {NONE} -- Implementation

	pot: separate POT

end
