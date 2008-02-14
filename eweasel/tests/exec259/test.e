
class TEST
create
	make
feature

	make is
		local
			test2: TEST2 [TEST1 [DOUBLE]]
			s: SPECIAL [TEST1 [TEST1 [DOUBLE]]]
			t: HASH_TABLE [TEST1 [TEST1 [DOUBLE]], STRING]
			x: TEST1 [TEST1 [DOUBLE]]
		do
			create test2.make

			create s.make (5)

			check s.all_default (0, 4) end
			create t.make (5)
			t.put (x, "Weasel")
			print (t.item ("Weasel").generating_type)
			io.new_line
		end

end
