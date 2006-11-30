class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			create l.make_from_array (<<1, 2, 3, 4, 5>>)
			Io.put_string ("Before: ")
			output_list
			l.go_i_th (5)
			l.remove
			Io.put_string ("After removing 5: ")
			output_list
			create l.make_from_array (<<1, 2, 3, 4, 5>>)
			Io.put_string ("Before: ")
			output_list
			l.go_i_th (3)
			l.remove
			Io.put_string ("After removing 3: ")
			output_list
			create l.make_from_array (<<1, 2, 1, 2, 3, 2, 1, 4, 1>>)
			Io.put_string ("Before: ")
			output_list
			l.prune_all (1)
			Io.put_string ("After pruning all 1's: ")
			output_list
		end

feature {NONE} -- Implementation

	l: ARRAYED_LIST [INTEGER]
			
	output_list is
			-- Output list.
		do
			from
				l.start
			until
				l.after
			loop
				Io.put_integer (l.item)
				if not l.islast then Io.put_string (", ") end
				l.forth
			end
			Io.put_new_line
		end

end -- class TEST
