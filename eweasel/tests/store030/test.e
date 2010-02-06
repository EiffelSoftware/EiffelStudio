class
	TEST

inherit
	ARGUMENTS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
			l_is_storing: BOOLEAN
		do
			if argument_count >= 1 and then argument (1).is_integer then
				l_is_storing := argument (1).to_integer = 1
			end

			create l_file.make ("output.data")
			create a.make

				-- Basic store
			if l_is_storing then
				l_file.open_write
				l_file.basic_store (a)
				l_file.close
			end

			l_file.open_read
			if not attached {A} l_file.retrieved then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- General store
			if l_is_storing then
				l_file.open_write
				l_file.general_store (a)
				l_file.close
			end

			l_file.open_read
			if not attached {A} l_file.retrieved then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- Independent store
			if l_is_storing then
				l_file.open_write
				l_file.independent_store (a)
				l_file.close
			end

			l_file.open_read
			if not attached {A} l_file.retrieved then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

end
