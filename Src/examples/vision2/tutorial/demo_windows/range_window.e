indexing
	description:
		"The demo that goes with the range demo"
	date: "$Date$"
	revision: "$Revision$"

class
	RANGE_WINDOW

inherit
	DEMO_WINDOW

	EV_HORIZONTAL_RANGE
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
			{EV_HORIZONTAL_RANGE} Precursor (par)
		end

feature -- Access

	r1: EV_VERTICAL_RANGE
	r2: EV_HORIZONTAL_RANGE
	s1: EV_HORIZONTAL_SEPARATOR
	s2: EV_VERTICAL_SEPARATOR
	t1: EV_LABEL

end -- class RANGE_WINDOW
