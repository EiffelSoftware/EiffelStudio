class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
		do
			create l_file.make ("output.data")

				-- Basic store
			l_file.open_write
			l_file.basic_store (a)
			l_file.close

			l_file.open_read
			if attached {A} l_file.retrieved as l_a then
				io.put_boolean (l_a.is_equal (a))
				io.put_new_line
				io.put_boolean (l_a.is_deep_equal (a))
				io.put_new_line
				io.put_boolean (deep_equal (l_a, a))
				io.put_new_line
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- General store
			l_file.open_write
			l_file.general_store (a)
			l_file.close

			l_file.open_read
			if attached {A} l_file.retrieved as l_a then
				io.put_boolean (l_a.is_equal (a))
				io.put_new_line
				io.put_boolean (l_a.is_deep_equal (a))
				io.put_new_line
				io.put_boolean (deep_equal (l_a, a))
				io.put_new_line
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- Independent store
			l_file.open_write
			l_file.independent_store (a)
			l_file.close

			l_file.open_read
			if attached {A} l_file.retrieved as l_a then
				io.put_boolean (l_a.is_equal (a))
				io.put_new_line
				io.put_boolean (l_a.is_deep_equal (a))
				io.put_new_line
				io.put_boolean (deep_equal (l_a, a))
				io.put_new_line
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

end
