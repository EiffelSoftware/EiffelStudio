indexing 
	description:
		"Base class for all widgets.%N%
		%Facilities for geometry management and user input."
	status: "See notice at end of class"
	keywords: "widget, component, control"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET

inherit

	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_SENSITIVE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_COLORIZABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_POSITIONED
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_CONTAINABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_WIDGET_ACTION_SEQUENCES
		redefine
			implementation
		end

	EV_HELP_CONTEXTABLE
		redefine
			implementation,
			is_in_default_state
		end

feature -- Access

	parent: EV_CONTAINER is
			-- Contains `Current'.
		do
			Result := implementation.parent
		ensure then
			bridge_ok: Result = implementation.parent
		end

	is_parent_recursive (a_widget: EV_WIDGET): BOOLEAN is
			-- Is `a_widget' `parent', or recursivly, `parent' of `parent'.
		require
			not_destroyed: not is_destroyed
		do
			Result := a_widget = parent or else
				(parent /= Void and then parent.is_parent_recursive (a_widget))
		end

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `Current'.
		require
			not_destroyed: not is_destroyed
			is_show_requested: is_show_requested
		do
			Result := implementation.pointer_position
			-- Because the pointer position may have changed between assigning
			-- `Result' and calling the post conditions, there is no
			-- post condition on this feature.
		end 

	pointer_style: EV_CURSOR is
			-- Cursor displayed when pointer is over this widget.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pointer_style
			if Result = Void then
				Result := Default_pixmaps.Standard_cursor
			end
		end

	actual_drop_target_agent: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_ABSTRACT_PICK_AND_DROPABLE] is
			-- Overrides default drop target on a certain position.
			-- If `Void', `Current' will use the default drop target.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.actual_drop_target_agent
		ensure
			bridge_ok: Result = implementation.actual_drop_target_agent
		end

feature -- Status report

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_show_requested
		ensure
			bridge_ok: Result = implementation.is_show_requested
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_displayed
		ensure
			bridge_ok: Result = implementation.is_displayed
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_focus
		ensure
			bridge_ok: Result = implementation.has_focus
		end

	has_capture: BOOLEAN is
			-- Does widget have capture?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_capture
		ensure
			bridge_ok: Result = implementation.has_capture
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
			-- Make `is_show_requested' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide
		ensure
			not_is_show_requested: not is_show_requested
		end

	show is
			-- Request that `Current' be displayed when its parent is.
			-- `True' by default.
			-- Make `is_show_requested' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show
		ensure
			is_show_requested: is_show_requested
		end

	set_focus is
			-- Grab keyboard focus.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
			is_sensitive: is_sensitive
		do
			implementation.set_focus
		ensure
			has_focus: has_focus
		end

	enable_capture is
			-- Grab all user input events (mouse and keyboard).
			-- `disable_capture' must be called to resume normal input handling.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			implementation.enable_capture
		ensure
			has_capture: has_capture
		end

	disable_capture is
			-- Disable grab of all user input events.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_capture
		ensure
			not_has_capture: not has_capture
		end

	center_pointer is
			-- Position screen pointer over center of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			(create {EV_SCREEN}).set_pointer_position (
				(screen_x + (width/2)).truncated_to_integer,
				(screen_y + (height/2)).truncated_to_integer
			)
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent) is
			-- Assign `an_agent' to `actual_drop_target_agent'.
		require
			not_destroyed: not is_destroyed
			an_agent_not_void: an_agent /= Void
		do
			implementation.set_actual_drop_target_agent (an_agent)
		ensure
			assigned: actual_drop_target_agent = an_agent
		end

feature -- Element change

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		require
			not_destroyed: not is_destroyed
			a_cursor_not_void: a_cursor /= Void
		do
			implementation.set_pointer_style (a_cursor)
		ensure
			pointer_style_assigned: pointer_style.is_equal (a_cursor)
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimim_width', resize.
			-- This setting takes effect next time application is idle.
			-- From now, `minimum_width' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_width_positive: a_minimum_width > 0
		do
			implementation.set_minimum_width (a_minimum_width)
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set `a_minimum_height' in pixels to `minimum_height'.
			-- If `height' is less than `a_minimim_height', resize.
			-- This setting takes effect next time application is idle.
			-- From now, `minimum_height' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_height_positive: a_minimum_height > 0
		do
			implementation.set_minimum_height (a_minimum_height)
		ensure
			minimum_height_assigned: minimum_height = a_minimum_height
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Assign `a_minimum_height' to `minimum_height'
			-- and `a_minimum_width' to `minimum_width' in pixels.
			-- If `width' or `height' is less than minimum size, resize.
			-- This setting takes effect next time application is idle.
			-- From now, minimum size is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_width_positive: a_minimum_width > 0
			a_minimum_height_positive: a_minimum_height > 0
		do
			implementation.set_minimum_size (a_minimum_width, a_minimum_height)
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
			minimum_height_assigned: minimum_height = a_minimum_height
		end

feature -- Measurement 
	
	screen_x: INTEGER is
			-- Horizontal offset relative to left of screen in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.screen_x
		ensure
			bridge_ok: Result = implementation.screen_x
		end

	screen_y: INTEGER is
			-- Vertical offset relative to top of screen in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.screen_y
		ensure
			bridge_ok: Result = implementation.screen_y
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PICK_AND_DROPABLE} and Precursor {EV_SENSITIVE} and
				Precursor {EV_COLORIZABLE} and Precursor {EV_POSITIONED} and
				Precursor {EV_CONTAINABLE} and Precursor {EV_HELP_CONTEXTABLE}
		end
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_WIDGET_I
			-- Responsible for interaction with native graphics toolkit.
			-- See `{EV_ANY}.implementation'.

feature {NONE} -- Implementation

	Default_pixmaps: EV_STOCK_PIXMAPS is
			-- Default pixmaps and cursors.
		once
			create Result
		end

invariant
	pointer_position_not_void: is_usable and is_show_requested implies
		pointer_position /= Void

	--| VB size can be less than minimum size, if parent is smaller.

	is_displayed_implies_show_requested:
		is_usable and then is_displayed implies is_show_requested
	parent_contains_current:
		is_usable and then parent /= Void implies parent.has (Current)

end -- class EV_WIDGET

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
