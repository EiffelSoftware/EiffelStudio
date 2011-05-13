note
	description: "Main application which initializes and starts a quicksort on random data."
	author: "Marco Zietzling"
	reviewer: "Benjamin Morandi"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Set up and start quick sort.
		local
			l_data_size: INTEGER
			l_seed: INTEGER
			l_data: separate DATA
			l_quicksorter: separate QUICKSORTER
		do
				-- Read the data size from the console.
			io.put_string ("Specify data size (between 2 and " + max_data_size.out + "):%N")
			io.read_integer
			l_data_size := io.last_integer.min (max_data_size)

				-- Read the seed from the console.
			io.put_string ("Specify random seed (integer):%N")
			io.read_integer
			l_seed := io.last_integer

				-- Create the sorter and random data.
			create l_quicksorter
			create l_data.make_with_random_items (l_seed, l_data_size)

				-- Print the data.
			io.put_string ("Data before sorting%N")
			print_on_console (l_data)

			sort (l_quicksorter, l_data)

			-- Print the sorted data.
			io.put_string("Data after sorting%N")
			print_on_console (l_data)
		end

feature {NONE} -- Implementation

	max_data_size: INTEGER = 1000
		-- Maximum size for data.

	print_on_console (a_data: separate DATA)
			-- Print `a_data' to the console.
		do
			a_data.print_on_console
		end

	sort (a_quicksorter: separate QUICKSORTER; a_data: separate DATA)
			-- Sort `a_data' with `a_quicksorter'.
		do
			a_quicksorter.sort (a_data, 1)
		end

end -- class APPLICATION	
