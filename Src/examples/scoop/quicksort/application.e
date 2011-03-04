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

			-- Sort the data.
			sort (l_data, l_quicksorter)

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

	sort (a_data: separate DATA; a_quicksorter: separate QUICKSORTER)
			-- Sort 'a_data' with 'a_quicksorter'.
		local
			l_result_data_items: separate ARRAY [INTEGER_32]
		do
			create l_result_data_items.make (data_items_lower (a_data.items), data_items_upper (a_data.items))
			a_quicksorter.sort (a_data, l_result_data_items)
		end

	data_items_lower (a_data_items: separate ARRAY[INTEGER]): separate INTEGER
			--
		do
			Result := a_data_items.lower
		end

	data_items_upper (a_data_items: separate ARRAY[INTEGER]): separate INTEGER
			--
		do
			Result := a_data_items.upper
		end

end -- class APPLICATION	
