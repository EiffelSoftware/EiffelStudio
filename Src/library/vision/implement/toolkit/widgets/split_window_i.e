indexing

	description:
		"Control window with two children separated%
		%by an horizontal split"
	date: "$Date$"
	revision: "$Revision$"

deferred class 

	SPLIT_WINDOW_I

inherit
	
	MANAGER_I

feature -- Access

	is_vertical: BOOLEAN
			-- Is the split made vertically?

	proportion: INTEGER
			-- Proportion for the first split_window_child.
			-- between 0 and 100

feature -- Element change

	update_split is
		deferred
		end

	set_proportion (p:INTEGER) is
			-- Set the split proportion from 0 to 100.
		require
			valid_proportion: p>=0 and then p<=100
		deferred
		end

	add_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as currently lowest child.
		require
			a_child_not_void: a_child /= Void
		deferred
		end

	remove_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Remove `a_child' from the display.
		deferred
		end

	add_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as managed.
		deferred
		end

	remove_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Remove `a_window' as managed.
		deferred
		end

end -- class SPLIT_WINDOW_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

