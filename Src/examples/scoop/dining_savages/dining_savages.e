indexing
	description	: "System's root class"
	author		: "Robin Stoll"
	date		: "2009/5/13"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	DINING_SAVAGES

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
			local
				i: INTEGER;
				a_savage: separate SAVAGE
			do
				create pot.make (number_of_servings_in_pot) -- make the pot according to its capacity
				create cook.make (pot) -- make the cooke to fill the specified pot

				from -- make all savages and launch them to eat
					i := 1
				until
					i > number_of_savages
				loop
					create a_savage.make (i, pot, cook, hunger_of_savage)
					launch_savage (a_savage)
					i := i + 1
				end
			end


feature {NONE} -- Implementation

	number_of_servings_in_pot: INTEGER is 20	 -- capacity of pot
	number_of_savages: INTEGER is 50
	hunger_of_savage: INTEGER is 50 -- how many times each savage gets a serving

	cook: separate COOK -- the cooke who fills the pot
	pot: separate POT -- the POT from which savages eat

	launch_savage(a_savage: separate SAVAGE) is
			-- launch a_savage in a controlled manner
			do
				io.put_string ("launch savage%N")
				a_savage.live
			end

end -- class APPLICATION
