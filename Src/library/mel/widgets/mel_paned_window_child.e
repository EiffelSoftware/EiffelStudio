indexing

	description:
			"Child of a paned window";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PANED_WINDOW_CHILD

inherit

	MEL_PANED_WINDOW_CHILD_RESOURCES
		export
			{NONE} all
		end;

	MEL_OBJECT

feature -- Status report

	skip_adjustment: BOOLEAN is
			-- Skip the resizing of Current widget in paned window?
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			Result := get_xt_boolean (screen_object, XmNskipAdjust)
		end;

	allow_pane_to_resize: BOOLEAN is
			-- Is Current widget allowed to resize in the paned window?
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			Result := get_xt_boolean (screen_object, XmNallowResize)
		end;

	pane_minimum: INTEGER is
			-- Minimal dimensions for resizing of `a_widget'
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			Result := get_xt_dimension (screen_object, XmNpaneMinimum)
		ensure
			pane_minimum_large_enough: Result >= 0
		end;

	pane_maximum: INTEGER is
			-- Maximal dimensions for resizing of `a_widget'
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			Result := get_xt_dimension (screen_object, XmNpaneMAximum)
		ensure
			pane_maximum_large_enough: Result >= 0
		end;

	pane_position_index: INTEGER is
			-- Position of widget in its parent (paned window) list of children
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			Result := get_xt_short (screen_object, XmNpanePositionIndex)
		ensure
			position_large_enough: Result >=0;
			position_small_enough: Result < parent.children_count
		end;

feature -- Status setting

	allow_pane_resize is
			-- Set `allow_pane_to_resize' to True.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			set_xt_boolean (screen_object, XmNallowResize, True)
		ensure
			allowed_to_resize: allow_pane_to_resize 
		end;

	forbid_pane_resize is
			-- Set `allow_pane_to_resize' to False.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			set_xt_boolean (screen_object, XmNallowResize, False)
		ensure
			forbidden_to_resize: not allow_pane_to_resize 
		end;

	set_pane_minimum (a_dimension: INTEGER) is
			-- Set `pane_minimum' to `a_dimension'.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window;
			a_dimension_large_enough: a_dimension >= 0;
			a_dimension_smaller_than_maximum: a_dimension <= pane_maximum
		do
			set_xt_dimension (screen_object, XmNpaneMinimum, a_dimension)
		ensure
			pane_minimum_set: pane_minimum = a_dimension
		end;

	set_pane_maximum (a_dimension: INTEGER) is
			-- Set `pane_maximum' to `a_dimension'.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window;
			a_dimension_large_enough: a_dimension >= 0;
			a_dimension_greater_than_minimum: a_dimension >= pane_minimum
		do
			set_xt_dimension (screen_object, XmNpaneMaximum, a_dimension)
		ensure
			pane_maximum_set: pane_maximum = a_dimension
		end;

	set_pane_position_index (a_position: INTEGER) is
			-- Set `pane_position_index' to `a_position'.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position < parent.children_count
		do
			set_xt_short (screen_object, XmNpanePositionIndex, a_position)
		ensure
			position_index_set: pane_position_index = a_position;
		end;

	set_at_last_position (a_widget: MEL_RECT_OBJ) is
			-- Set the position in the RowColumn's list of Paned window
			-- to the last position.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window;
		do
			set_xt_short (screen_object, XmNpanePositionIndex, XmPANE_LAST_POSITION)
		ensure
			is_at_the_end: pane_position_index = parent.children_count
		end;

	enable_skip_adjustment is
			-- Set `skip_adjustment' to True.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			set_xt_boolean (screen_object, XmNskipAdjust, True)
		ensure
			skip_adjustment_enabled: skip_adjustment 
		end;

	disable_skip_adjustment is
			-- Set `skip_adjustment' to False.
		require
			exists: not is_destroyed;
			parent_is_paned_window: parent.is_paned_window
		do
			set_xt_boolean (screen_object, XmNskipAdjust, False)
		ensure
			skip_adjustment_disabled: not skip_adjustment 
		end;

end -- class MEL_PANED_WINDOW


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

