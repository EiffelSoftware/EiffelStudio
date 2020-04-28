note

	description:

		"Cells containing three items"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_DS_TRIPPLE [G, H, I]

inherit

	DS_PAIR [G, H]
		rename
			make as make_pair
		export
			{NONE} make_pair
		end

create

	make

feature {NONE} -- Initialization

	make (v: G; w: H; x: I)
			-- Create a new cell containing `v', `w' and `x'.
		do
			first := v
			second := w
			third := x
		ensure
			first_set: first = v
			second_set: second = w
			third_set: third = x
		end

feature -- Access

	third: I
			-- Third item of cell

feature -- Element change

	put_third (x: I) 
			-- Insert `x' in cell.
		do
			third := x
		ensure
			inserted: third = x
		end

end
