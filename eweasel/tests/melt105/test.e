class TEST

create
	make

feature

	make
			-- Creation procedure.
		local
			i: INTEGER
			p: POINTER
		do
			p := $Current
			i := ($Current).hash_code
			
			if i /= p.hash_code then
				io.put_string ("Not ok%N")
			end
		end

end
