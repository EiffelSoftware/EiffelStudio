class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			fill_set
			output_set ("Before moving")
			move
			output_set ("After moving")
		end

feature {NONE} -- Constants

	Items: INTEGER is 5

feature {NONE} -- Implementation

	set: ARRAYED_SET [INTEGER]

	fill_set is
			-- Fill up set.
		local
			i: INTEGER
		do
			create set.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				set.extend (i)
				i := i + 1
			end
		end

	move is
			-- Do the moving.
		do
			set.go_i_th (3)
			set.move_item (5)
		end

	output_set (label: STRING) is
			-- Output set with `label'.
		require
			label_not_empty: label /= Void and then not label.is_empty
		do
			Io.put_string (label + ": ")
			from
				set.start
			until
				set.after
			loop
				Io.put_integer (set.item)
				if not set.islast then Io.put_string (", ") end
				set.forth
			end
			Io.put_new_line
		end	

end -- class TEST
