indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM

inherit
	EV_SIMPLE_ITEM
		redefine
			implementation,
			make_with_index,
			make_with_all,
			parent
		end

create
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make (par: like parent) is
			-- Create the widget with `par' as parent.
		do
			!EV_STATUS_BAR_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: like parent; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_STATUS_BAR_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

	make_with_index (par: like parent; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		do
			create {EV_STATUS_BAR_ITEM_IMP} implementation.make
			{EV_SIMPLE_ITEM} Precursor (par, value)
		end

	make_with_all (par: like parent; txt: STRING; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		do
			create {EV_STATUS_BAR_ITEM_IMP} implementation.make_with_text (txt)
			{EV_SIMPLE_ITEM} Precursor (par, txt, value)
		end

feature -- Access

	parent: EV_STATUS_BAR is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

feature -- Measurement

	width: INTEGER is
			-- The width of the item in the status bar.
		require
			exists: not destroyed
		do
			Result := implementation.width
		end

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item reach the right of the status
			-- bar.
		require
			exists: not destroyed
			valid_value: value >= -1
			maximise_ok: value = -1 implies (parent.count = index)
		do
			implementation.set_width (value)
		ensure
			width_set: (width = value) or (value = -1)
		end

feature {NONE} -- Implementation

	implementation: EV_STATUS_BAR_ITEM_I
			-- platform dependent access.

end -- class EV_STATUS_BAR_ITEM

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
