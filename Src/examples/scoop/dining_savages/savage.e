note
	description	: "Objects that describes the behaviour of a savage"
	author		: "Robin Stoll"
	date		: "13.05.2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SAVAGE

inherit
	PROCESS

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_pot: separate POT; a_cook: separate COOK; a_hunger: INTEGER )
			-- Creation procedure.
		require
			an_id >= 0
			a_pot /= void
			a_cook /= void
			a_hunger >= 0
		do
			id := an_id
			pot := a_pot
			cook := a_cook
			hunger := a_hunger
		end

feature {NONE} -- Access

	step
			-- Perform a savage's tasks.
		do
			io.put_string ("step: filling pot%N")
			fill_pot (pot, cook)
			io.put_string ("step: getting serving%N")
			get_serving_from_pot (pot)
			io.put_string ("step: eating%N")
			eat
		end

	over: BOOLEAN
			-- Is execution over?
		do
			Result := hunger = 0
		end

feature {NONE} -- Implementation

	fill_pot (my_pot: separate POT; my_cook: separate COOK)
			-- Fills pot if it's empty.
		do
			io.put_string ("savage: fill_pot checking %N")
			if my_pot.is_empty then
				io.put_string ("savage: fill_pot filling%N")
				my_cook.cook (my_pot)
			end
		end

	get_serving_from_pot (my_pot: separate POT)
			-- Gets the meal from the pot
		require
			not my_pot.is_empty
		do
			io.put_string ("Savage-"+id.out+" is getting the meal...%N")
			my_pot.get_meal
		end

	eat
			-- Eat the meal.
		require
			hunger > 0
		do
			io.put_string ("Savage-"+id.out+" is eating...(hungry:" + hunger.out + ")%N")
			hunger := hunger - 1
		ensure
			hunger = old hunger - 1
		end

feature {NONE}

	id: INTEGER
	pot: separate POT
	cook: separate COOK

	hunger: INTEGER

invariant

	id > 0
	pot /= void
	cook /= void
	hunger >= 0

end
