indexing
	description:
		"A separator for the tool-bars."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR

inherit
	EV_SEPARATOR_ITEM
		redefine
			make_with_index,
			implementation,
			parent
		end

create
	make,
	make_with_index

feature {NONE} -- Initialization

	make (par: like parent) is
			-- Create the widget with `par' as parent.
		do
			create {EV_TOOL_BAR_SEPARATOR_IMP} implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_index (par: like parent; pos: INTEGER) is
			-- Create a row at the given `value' index in the list.
		do
			create {EV_TOOL_BAR_SEPARATOR_IMP} implementation.make
			{EV_SEPARATOR_ITEM} Precursor (par, pos)
		end

feature -- Access

	parent: EV_TOOL_BAR is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_SEPARATOR_ITEM} Precursor
		end

feature -- Implementation

	implementation: EV_TOOL_BAR_SEPARATOR_I
			-- Platform dependent access

end -- class EV_TOOL_BAR_SEPARATOR

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
