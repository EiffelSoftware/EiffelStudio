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

	set_proportion (p:INTEGER) is
			-- Set the split proportion from 0 to 100.
		require
			valid_proportion: p>=0 and then p<=100
		do
			proportion := p
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
