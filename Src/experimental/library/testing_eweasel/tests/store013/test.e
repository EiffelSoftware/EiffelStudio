class TEST
inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make is
		local
			sa: STORABLE_A55
			l_file: RAW_FILE
		do
			create sa
				-- Uncomment the paragraph below when creating a new storable file
--			create l_file.make ("data_62")
--			l_file.open_write
--			l_file.independent_store (sa)
--			l_file.close

			test (sa, argument (1))
		end

	test (sa: STORABLE_A55; s: STRING) is
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		local
			a: ANY
			l_file: RAW_FILE
		do
			create l_file.make (s)
			l_file.open_read
			a := l_file.retrieved
			l_file.close
			
			io.put_boolean (deep_equal (a, sa))
			io.put_new_line
		end

end
