class TEST inherit

	EXCEPTIONS
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			retried: BOOLEAN
			exception_allowed: BOOLEAN
		do
			create l1.make_from_array (<<1, 2, 3, 4, 5, 6, 7, 8, 9, 10>>)
			if not retried then
				Io.put_string ("Duplicate length: 3%N")
				exception_allowed := True
				Io.put_string ("Original list: ")
				output_list (l1)
				l1.go_i_th (1)
				l1.back
				Io.put_string ("Duplicated list (cursor at `before'): ")
				l2 := l1.duplicate (3)
				output_list (l2)
			end
			exception_allowed := False
			l1.go_i_th (4)
			Io.put_string ("Duplicated list (cursor at 4th item): ")
			l2 := l1.duplicate (3)
			output_list (l2)
			l1.go_i_th (9)
			Io.put_string ("Duplicated list (cursor at 9th item): ")
			l2 := l1.duplicate (3)
			output_list (l2)
			l1.finish
			Io.put_string ("Duplicated list (cursor at 10th item): ")
			l2 := l1.duplicate (3)
			output_list (l2)
			l1.finish
			l1.forth
			Io.put_string ("Duplicated list (cursor at `after'): Empty? ")
			l2 := l1.duplicate (3)
			Io.put_boolean (l2.is_empty)
			Io.put_new_line
		rescue
			if exception = Precondition and then exception_allowed then
				Io.put_string ("Precondition '" + tag_name + "' ... OK%N")
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation

	l1, l2: ARRAYED_LIST [INTEGER]
			
	output_list (l: like l1) is
			-- Output list `l'.
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
