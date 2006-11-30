class TEST inherit

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			create l.make (2)
			Io.put_string ("Empty list%N")
			Io.put_string ("extend (2): ")
			l.extend (2)
			output_list
			Io.put_string ("l.start%N")
			l.start
			Io.put_string ("put_left (1): ")
			l.put_left (1)
			output_list
			Io.put_string ("l.forth%N")
			l.forth
			Io.put_string ("put_left (6): ")
			l.put_left (6)
			output_list
			Io.put_string ("l.back%N")
			l.back
			Io.put_string ("put_left (3): ")
			l.put_left (3)
			output_list
			Io.put_string ("put_left (5): ")
			l.put_left (5)
			output_list
			Io.put_string ("l.back%N")
			l.back
			Io.put_string ("put_left (4): ")
			l.put_left (4)
			output_list
		end

feature {NONE} -- Implementation

	l: ARRAYED_LIST [INTEGER]
			
	output_list is
			-- Output list.
		local
			old_idx: INTEGER
		do
			old_idx := l.index
			from
				l.start
			until
				l.after
			loop
				Io.put_integer (l.item)
				if not l.islast then Io.put_string (", ") end
				l.forth
			end
			l.go_i_th (old_idx)
			Io.put_string (" (idx: " + l.index.out + ")%N")
		end

end -- class TEST
