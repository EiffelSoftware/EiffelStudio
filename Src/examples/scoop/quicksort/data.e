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
			-- Make the data with 'a_size' items.
			-- The random generator gets initialized with 'a_seed'.
		local
			i: INTEGER
			l_random_generator: RANDOM
			l_random_number: REAL
		do
			make_filled (0, 1, a_size)
			create l_random_generator.set_seed (a_seed)
			l_random_generator.start

			from
				i := lower
			until
				i > upper
			loop
				l_random_number := l_random_generator.real_item
				put ((l_random_number * 100).floor, i)
				l_random_generator.forth
				i := i + 1
			end
		end

	make_from_other_data (a_data: separate DATA; a_left: INTEGER; a_right: INTEGER)
			-- Make the data based on the items in 'a_data' between 'a_left' and 'a_right'.
		local
			i: INTEGER
		do
			make_filled (0, 1, a_right - a_left + 1)
			from
				i := a_left
			until
				i > a_right
			loop
				put (a_data [i], i - a_left + 1)
				i := i + 1
			end
		end

feature -- Basic operations

	print_on_console
			-- Print the items on the console.
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				io.put_integer (item (i))
				io.put_string (" ")
				i := i + 1
			end
			io.put_new_line
		end

end -- class DATA	
