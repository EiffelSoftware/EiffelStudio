indexing
	description: "EiffelVision list, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_LIST_I
	
inherit
	
	EV_WIDGET_I


feature -- Status report

	count: INTEGER is
			-- Number of lines
		require
			exists: not destroyed
		deferred
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		deferred
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
			exist: not destroyed
		deferred
		end

feature -- Status setting

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
			exists: not destroyed
		deferred
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
			exists: not destroyed
		deferred
		end

feature {EV_LIST_ITEM} -- Implementation

	add_item (item: EV_LIST_ITEM) is
			-- Add `item' to the list
		deferred
		end

end -- class EV_LIST_I

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
