note
	description: "The data to work on."
	author: "Benjamin Morandi"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA

inherit
	ARRAY [INTEGER]

create
	make_with_random_items,
	make_from_other_data,
	make_filled

feature -- Initialization


	make_with_random_items (a_seed: INTEGER; a_size: INTEGER)
			-- Make the data with `a_size' items.
			-- Initialize random sequence with `a_seed'.
		local
			l_random_generator: RANDOM
			l_random_number: REAL
		do
			make_filled (0, 1, a_size)
			create l_random_generator.set_seed (a_seed)

			across
				(lower |..| upper) as ic
			from
				l_random_generator.start
			loop
				l_random_number := l_random_generator.real_item
				put ((l_random_number * 1000).floor, ic.item)
				l_random_generator.forth
			end
		end

	make_from_other_data (a_data: separate DATA; a_left: INTEGER; a_right: INTEGER)
			-- Initialize based on items in `a_data' between `a_left' and `a_right'.
		do
			make_filled (0, 1, a_right - a_left + 1)
			across (a_left |..| a_right) as ic loop put (a_data [ic.item], ic.item - a_left + 1) end
		end

feature -- Basic operations

	print_on_console
			-- Print items on console.
		do
			across (lower |..| upper) as ic loop print (item (ic.item).out + " ") end
			print ("%N")
		end

end -- class DATA	
