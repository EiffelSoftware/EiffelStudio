class TEST1
inherit
	TEST4 [CHARACTER, INTEGER]

	TEST6 [CHARACTER]
		undefine
			item, put
		end
		

feature

	item alias "[]" (i: INTEGER): CHARACTER assign put
		do
		end

	put (s: CHARACTER; i: INTEGER)
		do
			io.put_integer (i)
			io.put_new_line
		end

end
