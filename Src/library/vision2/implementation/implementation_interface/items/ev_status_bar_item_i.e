indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STATUS_BAR_ITEM_I

inherit
	EV_ITEM_I

feature -- Access

	parent: EV_STATUS_BAR is
			-- Parent of the current item.
		require
			exists: not destroyed
		deferred
		end

feature -- Measurement

	width: INTEGER is
			-- The width of the item in the status bar.
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item reach the right of the status
			-- bar.
		require
			exists: not destroyed
			valid_value: value >= 0 or value = -1
		deferred
		ensure
			width_set: width = value
		end

feature -- Element change

	set_parent (par: EV_STATUS_BAR) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		deferred
		ensure
			parent_set: parent = par
		end

end -- class EV_STATUS_BAR_ITEM_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
