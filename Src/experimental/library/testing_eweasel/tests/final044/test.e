class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			l_test2: TEST2
			l_test1: TEST1 [ANY]
			l_test1_s: TEST1 [STRING]
			a: INTEGER
			l_table: TABLE [STRING, STRING]
			s: STRING
		do
				-- Wrong dispatch on `item', it is calling statically the version of CHAIN.
			create {HASH_TABLE [STRING, STRING]} l_table.make (10)
			s := l_table.item ("")

				-- Code below show wrong dynamic dispatch when accessing `f'.
			create l_test2.make
			l_test1 := l_test2
			print (l_test2.f) print ("%N")

			create l_test1_s.make
			a := l_test1_s.f

			print (l_test1.f) print ("%N")
		end


end
