indexing
	description:
		"The demo that goes with the range demo"
	date: "$Date$"
	revision: "$Revision$"

class
	RANGE_WINDOW

inherit
	EV_TABLE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in 'par'.
			-- We create the table first without parent as it
			-- is faster.
		do
			{EV_TABLE} Precursor (Void)


			create t1.make(Current)
			set_child_position(t1,0,0,1,1)
			--create s1.make(Current)
			--set_child_position(s1,1,0,2,4)
			
			--create r1.make(Current)
			--set_child_position(r1,0,0,1,1)

			set_parent(par)
		end

feature -- Access

	r1: EV_VERTICAL_RANGE
	r2: EV_HORIZONTAL_RANGE
	s1: EV_HORIZONTAL_SEPARATOR
	s2: EV_VERTICAL_SEPARATOR
	t1: EV_LABEL
	

end -- class RANGE_WINDOW
