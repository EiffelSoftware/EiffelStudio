indexing

	description:
		"Control window with two children separated%
		%by an horizontal split"
	date: "$Date$"
	revision: "$Revision$"

deferred class 

	SPLIT_WINDOW_I

inherit
	
	FORM_I

feature -- Access

	first_child: SPLIT_WINDOW_CHILD
			-- Child above the top most split if not `is_vertical'
			-- Child next the left most split otherwise

	second_child: SPLIT_WINDOW_CHILD
			-- Child below the bottom most split if not `is_vertical'
			-- Child next the right most split otherwise

	split_position: INTEGER
			-- Position of the top split relative to Current

	split_size: INTEGER
			-- Size of the split window.
			--| Depending on the value of `is_vertical', it can be the
			--| height or the width

	proportion: INTEGER

	is_vertical: BOOLEAN
			-- Is the split made vertically?

feature -- Sizing policy

	child_has_resized is
			-- Respond to resizing from children.
		deferred
		end

feature -- Element change

	set_first_child (a_window: SPLIT_WINDOW_CHILD) is
			-- set `first_child' to `a_window'.
		require
			a_window_not_void: a_window /= Void
		deferred
		ensure
			first_child_set: first_child = a_window
		end

	set_second_child (a_window: SPLIT_WINDOW_CHILD) is
			-- set `second_child' to `a_window'.
		require
			a_window_not_void: a_window /= Void
		deferred
		ensure
			second_child_set: second_child = a_window
		end

	add_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as currently lowest child.
		require
			a_window_not_void: a_window /= Void
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

	remove_second_child is
			-- Remove `second_child' from the display.
		deferred
		end

feature {SPLIT_WINDOW_CHILD} -- Element change

	remove_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Remove `a_child' from the display.
		deferred
		end

feature -- {NONE} -- Implementation

	resize_first_child is
			-- Resize the top child to the correct dimensions.
		require
			exists: exists
		deferred
		end

	resize_second_child is
			-- Resize the bottom child to the correct dimensions.
		require
			exists: exists
		deferred
		end

	exists: BOOLEAN is
			-- Does the window exist?
		deferred
		end

	button_down: BOOLEAN
			-- Is the mouse button down moving the split?

	is_splitting: BOOLEAN
			-- Is `button_down' and `on_top_split' True?

	split_visible: BOOLEAN
			-- Is the split visible?

end -- class SPLIT_WINDOW_I
