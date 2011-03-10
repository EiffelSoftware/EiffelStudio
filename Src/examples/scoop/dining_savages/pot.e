note
	description	: "Objects that describe the behaviour of the pot"
	author		: "Robin Stoll"
	date		: "13.05.2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	POT

create
	make

feature -- Initialization

	make (the_max_servings: INTEGER)
			-- Creation procedure.
		require
			the_max_servings >= 1
		do
			servings := 0
			max_servings := the_max_servings
		end

feature -- Access

	is_full: BOOLEAN
			-- Returns true if the pot is full
		do
			Result := servings = max_servings
		end

	is_empty: BOOLEAN
			-- Returns true if the pot is empty
		do
			Result := servings = 0
		end

feature {COOK} -- only cook should fill up pot

	fill
			-- Fills the pot
		require
			pot: is_empty
		do
			io.put_string ("fill: refilling%N")
			servings := max_servings
		ensure
			pot: is_full
		end

feature {SAVAGE} -- only savages can eat..hoho

	get_meal
			-- Savage gets meal
		require
			not is_empty
		do
			io.put_string ("get_meal: pot providing meal %N")
			servings := servings - 1
		ensure
			servings = old servings - 1
		end

feature {NONE} -- Implementation

	servings: INTEGER
	max_servings: INTEGER

invariant

	servings >= 0
	servings <= max_servings
	max_servings >= 1

end
