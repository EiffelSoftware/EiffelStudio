indexing
	description: "Objects that test EV_TABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_MANY_CHILDREN_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button: EV_BUTTON
			x, y: INTEGER
		do
				-- Create `label' using `make_with_text'.
			create table
			table.set_minimum_size (300, 300)
			table.resize (8, 8)
			from
				y := 1
			until
				y >= 8
			loop
				from
					x := 1
				until
					x >= 8
				loop
					table.put_at_position (create {EV_BUTTON}.make_with_text (x.out + "," + y.out), x, y, 1, 1)
					x := x + 1
				end
				y := y + 1
			end
			widget := table
		end
		
feature {NONE} -- Implementation

	table: EV_TABLE

end -- class TABLE_MANY_CHILDREN_TEST
