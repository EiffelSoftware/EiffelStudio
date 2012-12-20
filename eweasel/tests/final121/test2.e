class TEST2
inherit
	TEST1
		redefine
			put
		end

feature

	put (s: CHARACTER; i: INTEGER)
		do
			io.put_integer (i)
			io.put_new_line
		end

end
