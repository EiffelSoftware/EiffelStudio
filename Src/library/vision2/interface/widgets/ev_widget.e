note
	description:
		"Base class for all widgets.%N%
		%Facilities for geometry management and user input."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EV_DOCKABLE_SOURCE
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

	EV_WIDGET_ACTION_SEQUENCES

	EV_HELP_CONTEXTABLE
		redefine
			implementation,
			is_in_default_state
		end

feature -- Basic operations

	refresh_now
			-- Force an immediate redraw of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.refresh_now
		end

feature -- Access

	parent: detachable EV_CONTAINER
			-- Contains `Current'.
		do
			Result := implementation.parent
		ensure then
			bridge_ok: Result = implementation.parent
		end

	pointer_position: EV_COORDINATE
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

	pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when pointer is over this widget.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.internal_pointer_style
		end

	actual_drop_target_agent: detachable FUNCTION [INTEGER, INTEGER, detachable EV_ABSTRACT_PICK_AND_DROPABLE]
			-- Overrides default drop target on a certain position.
			-- If `Void', `Current' will use the default drop target.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.actual_drop_target_agent
		ensure
			bridge_ok: Result = implementation.actual_drop_target_agent
		end

	real_target: detachable EV_DOCKABLE_TARGET
			-- `Result' is target used during a dockable transport if
			-- mouse pointer is above `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.real_target
		ensure
			bridge_ok: Result = implementation.real_target
		end

	default_key_processing_handler: detachable PREDICATE [EV_KEY]
			-- Agent used to determine whether the default key processing should occur for Current.
			-- If agent returns True then default key processing continues as normal, False prevents
			-- default key processing from occurring.
		assign
			set_default_key_processing_handler
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.default_key_processing_handler
		ensure
			bridge_ok: Result = implementation.default_key_processing_handler
		end

feature {EV_BUILDER} -- Access

	minimum_width_set_by_user: BOOLEAN
		-- Has `set_minimum_width' been called by the user?

	minimum_height_set_by_user: BOOLEAN
		-- Has `set_minimum_height' been called by the user?

feature -- Status report

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_show_requested
		ensure
			bridge_ok: Result = implementation.is_show_requested
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_displayed
		ensure
			bridge_ok: Result = implementation.is_displayed
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_focus
		ensure
			bridge_ok: Result = implementation.has_focus
		end

	has_capture: BOOLEAN
			-- Does widget have capture?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_capture
		ensure
			bridge_ok: Result = implementation.has_capture
		end

feature -- Status setting

	hide
			-- Request that `Current' not be displayed even when its parent is.
			-- If successful, make `is_show_requested' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide
		end

	show
			-- Request that `Current' be displayed when its parent is.
			-- `True' by default.
			-- If successful, make `is_show_requested' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show
		end

	set_focus
			-- Grab keyboard focus if `is_displayed'.
		require
			not_destroyed: not is_destroyed
			is_sensitive: is_sensitive
		do
			if is_displayed then
				implementation.set_focus
			end
		end

	enable_capture
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

	disable_capture
			-- Disable grab of all user input events.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_capture
		ensure
			not_has_capture: not has_capture
		end

	center_pointer
			-- Position screen pointer over center of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			(create {EV_SCREEN}).set_pointer_position (
				screen_x + (width // 2),
				screen_y + (height // 2))
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent)
			-- Assign `an_agent' to `actual_drop_target_agent'.
		require
			not_destroyed: not is_destroyed
			an_agent_not_void: an_agent /= Void
		do
			implementation.set_actual_drop_target_agent (an_agent)
		ensure
			assigned: actual_drop_target_agent = an_agent
		end

	set_real_target (a_target: EV_DOCKABLE_TARGET)
			-- Assign `a_target' to `real_target'.
		require
			not_destroyed: not is_destroyed
			target_not_void: a_target /= Void
		do
			implementation.set_real_target (a_target)
		ensure
			assigned: real_target = a_target
		end

	remove_real_target
			-- Ensure `real_target' is `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_real_target
		ensure
			real_target_void: real_target = Void
		end

	set_default_key_processing_handler (a_handler: like default_key_processing_handler)
			-- Assign `default_key_processing_handler' to `a_handler'.
			--| No postcondition to allow descendants to preserve user defined handler alongside
			--| with their own internal handler.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_default_key_processing_handler (a_handler)
		end

	remove_default_key_processing_handler
			-- Ensure `default_key_processing_handler' is Void.
			--| No postcondition to allow descendants to preserve user defined handler alongside
			--| with their own internal handler.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_default_key_processing_handler
		end

feature -- Element change

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style'.
		require
			not_destroyed: not is_destroyed
			a_cursor_not_void: a_cursor /= Void
		do
			implementation.set_pointer_style (a_cursor)
		ensure
			pointer_style_assigned: attached pointer_style as l_pointer_style and then l_pointer_style.is_equal (a_cursor)
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
			-- From now, `minimum_width' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_width_positive: a_minimum_width >= 0
		do
			implementation.set_minimum_width (a_minimum_width)
			minimum_width_set_by_user := True
		ensure
			minimum_width_assigned: (a_minimum_width > 0 implies minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (minimum_width <= 1))
			minimum_width_set_by_user_set: minimum_width_set_by_user
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set `a_minimum_height' in pixels to `minimum_height'.
			-- If `height' is less than `a_minimum_height', resize.
			-- From now, `minimum_height' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_height_positive: a_minimum_height >= 0
		do
			implementation.set_minimum_height (a_minimum_height)
			minimum_height_set_by_user := True
		ensure
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
			minimum_height_set_by_user_set: minimum_height_set_by_user
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Assign `a_minimum_height' to `minimum_height'
			-- and `a_minimum_width' to `minimum_width' in pixels.
			-- If `width' or `height' is less than minimum size, resize.
			-- From now, minimum size is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_width_positive: a_minimum_width >= 0
			a_minimum_height_positive: a_minimum_height >= 0
		do
			implementation.set_minimum_size (a_minimum_width, a_minimum_height)
			minimum_height_set_by_user := True
			minimum_width_set_by_user := True
		ensure
			minimum_width_assigned: (a_minimum_width > 0 implies minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (minimum_width <= 1))
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
			minimum_height_set_by_user_set: minimum_height_set_by_user
			minimum_width_set_by_user_set: minimum_width_set_by_user
		end

feature {EV_BUILDER} -- Element change

	reset_minimum_size
			-- Reset `minimum_width_set_by_user' and `minimum_height_set_by_user'.
		do
			minimum_width_set_by_user := False
			minimum_height_set_by_user := False
			implementation.reset_minimum_size
		ensure
			minimum_width_set_by_user_reset: not minimum_width_set_by_user
			minimum_height_set_by_user_reset: not minimum_height_set_by_user
		end

	reset_minimum_width
			-- Reset `minimum_width_set_by_user'.
		do
			minimum_width_set_by_user := False
			implementation.reset_minimum_width
		ensure
			minimum_width_set_by_user_reset: not minimum_width_set_by_user
		end

	reset_minimum_height
			-- Reset `minimum_height_set_by_user'.
		do
			minimum_height_set_by_user := False
			implementation.reset_minimum_height
		ensure
			minimum_height_set_by_user_reset: not minimum_height_set_by_user
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PICK_AND_DROPABLE} and Precursor {EV_SENSITIVE} and
				Precursor {EV_COLORIZABLE} and
				Precursor {EV_HELP_CONTEXTABLE} and Precursor {EV_DOCKABLE_SOURCE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WIDGET_I
			-- Responsible for interaction with native graphics toolkit.
			-- See `{EV_ANY}.implementation'.

invariant
	is_displayed_implies_show_requested:
		is_usable and then is_displayed implies is_show_requested
	parent_contains_current:
		is_usable and then attached parent as l_parent implies l_parent.has (Current)

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WIDGET











