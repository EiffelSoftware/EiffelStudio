indexing
	description:
		"EiffelVision tool-bar separator, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		select
			parent_imp
		end

	EV_SEPARATOR_ITEM_IMP
		rename
			parent_imp as old_parent_imp
		end

create
	make

feature -- Initialization

	make is
			-- create the widget
		do
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
		end

feature -- Element change

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		do
		end

end -- class EV_TOOL_BAR_SEPARATOR_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
