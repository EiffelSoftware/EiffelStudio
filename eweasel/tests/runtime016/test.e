class TEST

inherit
	MEMORY

create
	make

feature

	make
			-- Run test.
		local
			l_special: like reference_special
			mem: MEMORY
			i, j: INTEGER
			s: STRING
			tp1, tp2: POINTER
		do
			create reference_special.make_empty (10)
			create mem
			from
				i := 1
			until
				i = 10
			loop
				create l_special.make_filled ("S", 1)
				reference_special.copy_data (l_special, 0, 0, 1)
				mem.collect
				from
					j := 1
					create s.make (10)
					tp2 := $s
					tp1 := tp2
				until
					(tp2.to_integer_32 - tp1.to_integer_32) > 100
				loop
					s := "X"
					tp1 := tp2
					tp2 := $s
				end
				i := i + 1
				if reference_special.item (0).item (1) /= 'S' then
					io.put_string ("Not OK%N")
				end
			end
		end

	reference_special: SPECIAL [STRING]

end
