class TEST1

create
	make

feature {NONE} -- Initialize

	make (a: ARRAY [like x]) 
		require
			a_not_void: a /= Void
		do
			io.put_string (a.generating_type)
			io.put_new_line
		end

	x: LIST [like y]

	y: INTEGER

end
