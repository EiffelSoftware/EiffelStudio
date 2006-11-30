class TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			sa: STORABLE_A55
			a: ANY
			l_file: RAW_FILE
		do
			create sa
			create l_file.make ("toto")
			l_file.open_write
			l_file.independent_store (sa)
			l_file.close

			create l_file.make ("toto")
			l_file.open_read
			a := l_file.retrieved
			l_file.close
		end

end
