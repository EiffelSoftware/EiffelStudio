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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

