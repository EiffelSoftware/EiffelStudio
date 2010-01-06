deferred class TEST1 [G]

feature

	make is
		require
			a: (create {ARRAY [INTEGER]}.make_from_array (<<1, 3>>)).generating_type.out.is_equal ("ARRAY [INTEGER_32]")
			b: (create {ARRAY [G]}.make_from_array (<< >>)).generating_type.out.is_equal ("ARRAY [STRING_8]")
			c: (create {ARRAY [like Current]}.make_from_array (<< >>)).generating_type.out.is_equal ("ARRAY [TEST2]")
		do
		end

end
