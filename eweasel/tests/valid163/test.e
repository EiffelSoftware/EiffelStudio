class TEST
create
	make

feature

	make is
		local
			a: ARRAY [ARRAY [DOUBLE]]
			b: ARRAY [ARRAY [ARRAY [DOUBLE]]]
			t: TUPLE [ARRAY [INTEGER]]
			t2: TUPLE [INTEGER, ARRAY [ARRAY [DOUBLE]]]
		do
			a := << << 1, 2>> >>
			b := << << << 1, 2 >> >> >>
			t := [<< >>]
			t2 := [1, << << 1, 2 >> >>]
		end
			
end
