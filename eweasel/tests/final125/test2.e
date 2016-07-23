class
	TEST2 [H]

inherit
	TEST1 [STRING, H]
		redefine
			f
		end

create
	make

feature

	f (a, b: STRING; c: H)
		do
			if (a /= data) or (b /= data) then
				io.put_string ("Not OK!")
				io.put_new_line
			end
		end


end
