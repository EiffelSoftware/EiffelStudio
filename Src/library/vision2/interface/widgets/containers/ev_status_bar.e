indexing 
	description: "EiffelVision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR

inherit
	EV_PRIMITIVE
		export
			{NONE} set_minimum_height, set_minimum_width, set_minimum_size
			{NONE} set_height, set_width, set_size
			{NONE} set_x, set_y, set_x_y
		redefine
			implementation,
			parent,
			parent_needed
		end

	EV_ITEM_HOLDER
		redefine
			implementation,
			item_type
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create a status bar with `par' as parent and only
			-- one part.
		do
			!EV_STATUS_BAR_IMP! implementation.make (par)
			implementation.set_interface (Current)
		end

feature -- Access

	parent: EV_UNTITLED_WINDOW is
			-- The parent of the Current widget
			-- Can be Void
		do
			Result ?= {EV_PRIMITIVE} Precursor
		end

feature -- Assertion

	parent_needed: BOOLEAN is
			-- Is a parent needed by the widget
		do
			Result := True
		end

feature -- Implementation

	implementation: EV_STATUS_BAR_I
			-- Platform dependent access.

feature {NONE} -- Implementation

	item_type: EV_STATUS_BAR_ITEM is
			-- Gives a type.
		do
		end

end -- class EV_STATUS_BAR

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
