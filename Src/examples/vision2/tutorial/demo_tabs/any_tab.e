indexing
	description: "Tab used in the action window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANY_TAB

inherit
	EV_TABLE
		redefine
			make
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		do
			{EV_TABLE} Precursor (par)
			set_row_spacing (10)
			set_column_spacing (5)		
		end

feature -- Access

	name: STRING is
			-- Title of the current tab. 
		deferred
		end

	current_widget: EV_ANY
			-- Current widget we are working on.

feature -- Element change

	set_current_widget (wid: like current_widget) is
			-- Make `wid' the new widget.
		do
			current_widget ?= wid
		end

end -- class ANY_TAB

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

