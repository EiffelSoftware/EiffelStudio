indexing

	description:
		"Control window with two children separated%
		%by an horizontal split"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SPLIT_WINDOW_I

