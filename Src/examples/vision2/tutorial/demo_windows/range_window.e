indexing
	description:
		"The demo that goes with the range demo"
	date: "$Date$"
	revision: "$Revision$"

class
	RANGE_WINDOW

inherit
	EV_HORIZONTAL_RANGE
		redefine
			make
		end

	DEMO_WINDOW

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in 'par'.
			-- We create the table first without parent as it
			-- is faster.
		do
			{EV_HORIZONTAL_RANGE} Precursor (par)
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_gauge_tabs
			tab_list.extend(range_tab)
			create action_window.make(Current,tab_list)
		end

end -- class RANGE_WINDOW
