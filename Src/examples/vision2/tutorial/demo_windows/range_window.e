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
			{EV_HORIZONTAL_RANGE} Precursor (Void)

			set_gauge_tabs
			create range_tab.make(Void)
			tab_list.extend(range_tab)
			create action_window.make(Current,tab_list)
			make_with_range (par, 0, 100)
			set_parent(par)
		end



	range_tab: RANGE_TAB

end -- class RANGE_WINDOW
