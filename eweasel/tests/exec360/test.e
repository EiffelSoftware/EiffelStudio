class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t: TEST1
			l_table: HASH_TABLE [CHARACTER, TEST1]
		do
			create l_table.make (100)
			create t
			l_table.force ('A', t)
		end

end
