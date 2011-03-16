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
			-- Creation procedure.
		local
			l_data_size: INTEGER
			l_seed: INTEGER
			l_data: separate DATA
			l_quicksorter: separate QUICKSORTER
			l_result_data: separate DATA
		do
			-- Read the data size from the console.
			io.put_string ("Specify data size (between 2 and 1000):%N")
			io.read_integer
			l_data_size := io.last_integer

			-- Read the seed from the console.
			io.put_string ("Specify random seed (integer):%N")
			io.read_integer
			l_seed := io.last_integer

			-- Create the data.
			create l_data.make_with_random_items (l_seed, l_data_size)
			create l_quicksorter

			-- Print the data.
			io.put_string ("Data before sorting%N")
			print_on_console (l_data)

			sort (l_quicksorter, l_data)

			-- Print the sorted data.
			io.put_string("Data after sorting%N")
			print_on_console (l_data)
		end

feature {NONE} -- Implementation

	print_on_console (a_data: separate DATA)
			-- Print 'a_data' to the console.
		do
			a_data.print_on_console
		end

	sort (a_quicksorter: separate QUICKSORTER; a_data: separate DATA)
			-- Sort 'a_data' with 'a_quicksorter'.
		do
			a_quicksorter.sort (a_data)
		end

	data_lower (a_data: separate DATA): INTEGER
			--
		do
			Result := a_data.lower
		end

	data_upper (a_data: separate DATA): INTEGER
			--
		do
			Result := a_data.upper
		end

end -- class APPLICATION	
