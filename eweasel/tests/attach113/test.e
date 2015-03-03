class
	TEST

create
	make

feature -- contructor
	make
		local
			f1, f2 : TEST1 [STRING]
		do
			create f1.make_empty
			f1.extend (s, i)

			f2 := <<[s, i]>>

			if f1 /~ f2 then
				io.put_string ("Not OK!%N")
			end	
		end

	s : STRING = "foo"
	i : INTEGER = 1

end
