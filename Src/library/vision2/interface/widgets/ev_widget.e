indexing 
	description:
		"Eiffel Vision widget interface. %N%
		%Nearly everything in Eiffel Vision is a widget. Widgets are user %N%
		%interface components. eg: button, scrollbar, label. See EV_ANY for %N%
		%notes on the bridge pattern used by Vision."
	status: "See notice at end of class"
	keywords: "widget, component, control"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET

inherit

	EV_PICK_AND_DROPABLE
		redefine
			create_action_sequences,
			implementation
		end

feature -- Access

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		do
			Result := implementation.parent
		ensure
			bridge_ok: Result = implementation.parent
		end

	is_parent_recursive (a_widget: EV_WIDGET): BOOLEAN is
			-- Is `a_widget' `parent' or recursivly `parent' of `parent'.
		do
			Result := a_widget = parent or else
				(parent /= Void and then parent.is_parent_recursive (a_widget))
		end

	pointer_position: EV_COORDINATES is
			-- Position of the screen pointer relative to `Current'.
		do
			Result := implementation.pointer_position
		ensure
			bridge_ok: Result = implementation.pointer_position
		end 

	pointer_style: EV_CURSOR is
			-- Cursor displayed when pointer is over this widget.
		do
			Result := implementation.pointer_style
		ensure
			bridge_ok: Result = implementation.pointer_style
		end

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		do
			Result := implementation.foreground_color
		ensure
			bridge_ok: Result = implementation.foreground_color
		end

	background_color: EV_COLOR is
			-- Color displayed behind foreground features.
		do
			Result := implementation.background_color
		ensure
			bridge_ok: Result = implementation.background_color
		end

	tooltip: STRING is
			-- Text displayed when user moves mouse over widget.
		do
			Result := implementation.tooltip
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.tooltip)
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events.
		do
			Result := implementation.is_sensitive
		ensure
			bridge_ok: Result = implementation.is_sensitive
		end
			
	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := implementation.is_show_requested
		ensure
			bridge_ok: Result = implementation.is_show_requested
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
		do
			Result := implementation.is_displayed
		ensure
			bridge_ok: Result = implementation.is_displayed
		end

	--| FIXME is_managed   (I know it's not a function but who cares)
	managed: BOOLEAN
			-- Is the geometry of current widget managed by its 
			-- container? This is the case always unless 
			-- parent.manager = False (Always true except 
			-- when the container is EV_FIXED). This is 
			-- set in the procedure set_default

	is_horizontally_resizable: BOOLEAN is
			-- Should `width' change when widget is resized?
		do
			--FIXME Result := implementation.is_horizontally_resizable
		ensure
			--FIXME Result_assigned: Result = implementation.is_horizontally_resizable
		end

	is_vertically_resizable: BOOLEAN is
			-- Should `height' change when widget is resized?
		do
			--FIXME Result := implementation.is_vertically_resizable
		ensure	
			--FIXME Result_assigned: Result = implementation.is_vertically_resizable	
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := implementation.has_focus
		ensure
			bridge_ok: Result = implementation.has_focus
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
		do
			implementation.hide
		ensure
			not_is_show_requested: not is_show_requested
		end

	show is
			-- Request that `Current' be displayed when its parent is.
			-- `True' by default.
		do
			implementation.show
		ensure
			is_show_requested: is_show_requested
		end

	set_focus is
			-- Grab keyboard focus.
		require
			is_displayed: is_displayed
		do
			implementation.set_focus
		ensure
			has_focus: has_focus
		end

	enable_capture is
			-- Grab all user input events (mouse and keyboard).
		require
			is_displayed: is_displayed
		do
			implementation.enable_capture
		ensure
			--has_capture: has_capture
			--| FIXME IEK Implement has_capture
		end

	disable_capture is
			-- Disable grab of all user input events.
		do
			implementation.disable_capture
		ensure
			--has_no_capture: not has_capture
		end

	enable_sensitive is
			-- Enable sensitivity to user input events.
		do
			implementation.enable_sensitive
		ensure
			is_sensitive: is_sensitive
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		do
			implementation.disable_sensitive
		ensure
			not_is_sensitive: not is_sensitive
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			implementation.set_default_colors
		ensure
			--| Descendants of EV_WIDGET_I may redefine this to use
			--| different colors so there is no postcondition.
		end

feature -- Element change

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		require
			a_cursor_not_void: a_cursor /= Void
		do
			implementation.set_pointer_style (a_cursor)
		ensure
			pointer_style_assigned: pointer_style.is_equal (a_cursor)
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `background_color'.
		require
			a_color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_assigned: background_color.is_equal (a_color)
		end

	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'
		require
			a_color_not_void: a_color /= Void
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_assigned: foreground_color.is_equal (a_color)
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set `minimum_width' to `a_minimum_width' in pixels.
		require
			a_minimum_width_positive: a_minimum_width > 0
		do
			implementation.set_minimum_width (a_minimum_width)
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set `minimum_height' to `a_minimum_height' in pixels.
		require
			a_minimum_height_positive: a_minimum_height > 0
		do
			implementation.set_minimum_height (a_minimum_height)
		ensure
			minimum_height_assigned: minimum_height = a_minimum_height
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set `minimum_height' to `a_minimum_height'
			-- and `minimum_width' to `a_minimum_width' in pixels.
		require
			a_minimum_width_positive: a_minimum_width > 0
			a_minimum_height_positive: a_minimum_height > 0
		do
			implementation.set_minimum_size (a_minimum_width, a_minimum_height)
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
			minimum_height_assigned: minimum_height = a_minimum_height
		end

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			implementation.set_tooltip (a_text)
		ensure
			assigned: tooltip.is_equal (a_text)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
		do
			implementation.remove_tooltip
		ensure
			void: tooltip = Void
		end

feature -- Measurement 
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position',
			-- measured in pixels.
		do
			Result := implementation.x_position
		ensure
			bridge_ok: Result = implementation.x_position
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position',
			-- measurement in pixels.
		do
			Result := implementation.y_position
		ensure
			bridge_ok: Result = implementation.y_position
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		do
			Result := implementation.screen_x
		ensure
			bridge_ok: Result = implementation.screen_x
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		do
			Result := implementation.screen_y
		ensure
			bridge_ok: Result = implementation.screen_y
		end

	width: INTEGER is
			-- Horizontal size in pixels.
			-- Same as `minimum_width' when not displayed.
		do
			Result := implementation.width
		ensure
			bridge_ok: Result = implementation.width
			not_less_than_minimum_width: Result >= minimum_width
			--| FIXME Does not hold for EV_PIXMAP
			--|minimum_width_when_not_displayed:
			--|	not is_displayed implies Result = minimum_width
		end

	height: INTEGER is
			-- Vertical size in pixels.
			-- Same as `minimum_height' when not displayed.
		do
			Result := implementation.height
		ensure
			bridge_ok: Result = implementation.height
			not_less_than_minimum_height: Result >= minimum_height
			--| FIXME Does not hold for EV_PIXMAP
			--|minimum_height_when_not_displayed: not is_displayed
			--|	implies Result = minimum_height
		end 

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		do
			Result := implementation.minimum_width
		ensure
			bridge_ok: Result = implementation.minimum_width
			positive_or_zero: Result >= 0
		end 

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		do
			Result := implementation.minimum_height
		ensure
			bridge_ok: Result = implementation.minimum_height
			positive_or_zero: Result >= 0
		end 

feature -- User input events

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is released.

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer enters widget.

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer leaves widget.

	key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
			-- String representation of key is passed to actions.

	key_release_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed wehn a keyboard key is released.

	proximity_out_actions: EV_PROXIMITY_ACTION_SEQUENCE
			-- Actions to be performed when pointing device goes
			-- out of range. (Applicable to extended input devices
			-- such as graphics tablets.)

	proximity_in_actions: EV_PROXIMITY_ACTION_SEQUENCE
			-- Actions to be performed when pointing device comes
			-- into range. (Applicable to extended input devices
			-- such as graphics tablets.)

	focus_in_actions: EV_FOCUS_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is gained.

	focus_out_actions: EV_FOCUS_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is lost.

	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when size changes.

feature {EV_WIDGET, EV_WIDGET_I} -- Implementation

	create_action_sequences is
			-- Create empty action sequences, not yet connected to events.
		do
			{EV_PICK_AND_DROPABLE} Precursor
			create pointer_motion_actions
			create pointer_button_press_actions
			create pointer_button_release_actions
			create pointer_double_press_actions
			create pointer_enter_actions
			create pointer_leave_actions
			create proximity_in_actions
			create proximity_out_actions
			create focus_in_actions
			create focus_out_actions
			create key_press_actions
			create key_press_string_actions
			create key_release_actions
			create resize_actions
		end

feature {EV_WIDGET, EV_ANY_I}--EV_WIDGET, EV_PICK_AND_DROPABLE_I} -- Implementation

	implementation: EV_WIDGET_I
			-- Responsible for interaction with the underlying
			-- native graphics toolkit.
			-- (See bridge pattern notes in EV_ANY)

feature -- Obsolete
	
	make_with_parent (a_parent: EV_CONTAINER) is
			-- Create the widget with `par' as parent.
		obsolete
			"make as orphan, then add to container"
		do
			default_create
			if a_parent /= Void and then not a_parent.full then
				a_parent.extend (Current)
			end
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive to user actions?
			-- (If it is, events will not be dispatched
			-- to Current widget or any of its children)
		obsolete
			"Use: not is_sensitive"
		do
			Result := not is_sensitive
		end

	expandable: BOOLEAN is
			-- Does the widget expand its cell to take the
			-- size the parent would like to give to it.
		obsolete
			"Use is_child_expandable of EV_BOX instead"
		do
			Result := False
		end

--	set_expand (flag: BOOLEAN) is
--			-- Make `flag' the new expand option.
----		obsolete
--			"Use set_child_expandable of EV_BOX"
--		local
--			box: EV_BOX
--		do
--			box ?= parent
--			if box /= Void then
--				box.set_child_expandable (Current, flag)
--			end
--		end

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		obsolete
			"see new containers"
		do
			check
				not_used_anymore: False
			end
		end

	is_window: BOOLEAN is
			-- Is the current widget a window?
		obsolete
			"Use: a_window ?= `widget' (assignment attempt)"
		local
			a_window: EV_WINDOW
		do
			a_window ?= Current
			Result := a_window /= Void
		end

	shown: BOOLEAN is
			-- Is current widget visible in the parent?
		obsolete
			"Use: is_show_requested"
		do
			Result := is_show_requested
		end

	displayed: BOOLEAN is
			-- Is the current widget visible on the screen?
		obsolete
			"Use: is_displayed"
		do
			Result := is_displayed
		end

	horizontal_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- or the user want to resize the widget
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	vertical_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- or the user want to resize the widget
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode.
			-- This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.
		obsolete
			"Use: disable_sensitive or enable_sensitive"
		do
			if flag then
				disable_sensitive
			else
				enable_sensitive
			end
		end

	set_horizontal_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	x: INTEGER is
		obsolete
			"Use: x_position"
		do
			Result := x_position
		end

	y: INTEGER is
		obsolete
			"Use: y_position"
		do
			Result := y_position
		end

	set_x (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	set_y (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	set_x_y (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		obsolete
			"Not supported anymore."
		do
			check
				not_used_anymore: False
			end
		end

	is_insensitive: BOOLEAN is
			-- Is widget disabled?
			-- This means that no events are triggered.
		obsolete
			"use not is_sensitive"
		do
			Result := not is_sensitive
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
		obsolete
			"Useless."
		do
			check
				not_used_anymore: False
			end
		end

invariant
	pointer_position_not_void: is_useable implies pointer_position /= Void

	background_color_not_void: is_useable implies background_color /= void
	foreground_color_not_void: is_useable implies foreground_color /= void


	--| FIXME IEK The minimum dimension size should be greater than 0
	--| This does not hold for containers though
	minimum_width_not_negative: is_useable implies minimum_width >= 0
	minimum_height_not_negative: is_useable implies minimum_height >= 0

	--|FIXME These two assertions have been commented out due to problems with
	--|The windows implementation. The problem is due to the fact that until the widgets
	--| have been re-sized then the width, which is returned by wel will by 0. However,
	--| the minimum width of the widget will be greater than 0.
	--| This violates these pre-conditions and needs to be fixed.
	--|width_not_less_than_minimum_width: is_useable implies width >= minimum_width
	--|height_not_less_than_minimum_height:
	--|	is_useable implies height >= minimum_height

	is_displayed_implies_show_requested:
		is_useable and is_displayed implies is_show_requested
	parent_contains_current:
		is_useable and parent /= Void implies parent.has (Current)

	pointer_motion_actions_not_void: pointer_motion_actions /= Void
	pointer_button_press_actions_not_void:
		pointer_button_press_actions /= Void
	pointer_button_release_actions_not_void:
		pointer_button_release_actions /= Void
	pointer_double_press_actions_not_void:
		pointer_double_press_actions /= Void
	pointer_enter_actions_not_void: pointer_enter_actions /= Void
	pointer_leave_actions_not_void: pointer_leave_actions /= Void
	proximity_in_actions_not_void: proximity_in_actions /= Void
	proximity_out_actions_not_void: proximity_out_actions /= Void
	focus_in_actions_not_void: focus_in_actions /= Void
	focus_out_actions_not_void: focus_out_actions /= Void
	key_press_actions_not_void: key_press_actions /= Void
	key_release_actions_not_void: key_release_actions /= Void
	resize_actions_not_void: resize_actions /= Void

end -- class EV_WIDGET

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.66  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.64.2.1.2.55  2000/02/11 18:49:35  oconnor
--| removed make
--|
--| Revision 1.64.2.1.2.54  2000/02/11 01:30:01  king
--| Commented out make to make descendants compile
--|
--| Revision 1.64.2.1.2.53  2000/02/11 00:03:45  oconnor
--| Added make and implemented make_with_parent as obsolete.
--| To be removed after initial change over phase.
--|
--| Revision 1.64.2.1.2.52  2000/02/09 01:23:26  pichery
--| - added creation of key_press_string_actions (which has been added but not
--|   created)
--|
--| Revision 1.64.2.1.2.51  2000/02/08 09:26:09  oconnor
--| added is_parent_recursive
--|
--| Revision 1.64.2.1.2.50  2000/02/07 23:31:57  oconnor
--| added key string action sequence
--|
--| Revision 1.64.2.1.2.49  2000/02/07 19:02:26  oconnor
--| added resize_actions
--|
--| Revision 1.64.2.1.2.48  2000/02/06 21:17:11  brendel
--| Commented out postconditions that do not hold in EV_PIXMAP.
--|
--| Revision 1.64.2.1.2.47  2000/01/28 21:18:25  brendel
--| Added `tooltip', `set_tooltip', `remove_tooltip'.
--|
--| Revision 1.64.2.1.2.46  2000/01/28 20:00:11  oconnor
--| released
--|
--| Revision 1.64.2.1.2.45  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.64.2.1.2.44  2000/01/26 19:18:43  rogers
--| width_not_less_than_minimum_width and height_not_less_than_minimum_height have been commented out with a FIXME and a detailed description of why.
--|
--| Revision 1.64.2.1.2.43  2000/01/25 17:17:55  king
--| Added absolute screen coord features
--|
--| Revision 1.64.2.1.2.42  2000/01/25 00:08:02  oconnor
--| removed obsolete command manipulation features
--| use action sequences instead
--|
--| Revision 1.64.2.1.2.41  2000/01/21 19:34:18  king
--| Altered > 0 assertion naming covention to be positive from greater_than_zero
--|
--| Revision 1.64.2.1.2.40  2000/01/20 23:51:51  king
--| Changed minimum size assertions to be >= 1 instead of 0
--|
--| Revision 1.64.2.1.2.39  2000/01/19 08:08:40  oconnor
--| added precondition is_displayed to set_foucs
--|
--| Revision 1.64.2.1.2.38  2000/01/17 00:25:44  oconnor
--| comments and formattinginterface/widgets/ev_widget.e
--|
--| Revision 1.64.2.1.2.37  1999/12/17 20:51:29  rogers
--| is_vertically_resizeable and is_horizontally_resizeable no longer do
--| anything. The implementation is now exported to EV_WIDGET and EV_ANY_I.
--|
--| Revision 1.64.2.1.2.36  1999/12/16 09:21:58  oconnor
--| add is_useable to invariant
--|
--| Revision 1.64.2.1.2.35  1999/12/15 20:16:48  oconnor
--| removed set_expand
--|
--| Revision 1.64.2.1.2.34  1999/12/15 01:57:23  oconnor
--| export implementation to  EV_PICK_AND_DROPABLE_I
--|
--| Revision 1.64.2.1.2.33  1999/12/14 18:57:22  oconnor
--| rename POINT->COORDINATES for pointer_position
--|
--| Revision 1.64.2.1.2.32  1999/12/14 18:07:46  oconnor
--| implemented feature pointer_position
--|
--| Revision 1.64.2.1.2.31  1999/12/14 17:43:45  oconnor
--| added pointer_position
--|
--| Revision 1.64.2.1.2.30  1999/12/14 16:52:58  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.64.2.1.2.29  1999/12/10 00:06:13  brendel
--| Forgot to remove my bar on the top.
--|
--| Revision 1.64.2.1.2.28  1999/12/10 00:05:06  brendel
--| Changes minor spelling errors.
--| Made obsolete clause nicer.
--|
--| Revision 1.64.2.1.2.27  1999/12/07 17:46:10  oconnor
--| added comment to implementation attribute
--|
--| Revision 1.64.2.1.2.26  1999/12/07 17:39:22  oconnor
--| fixed comment for consistency
--|
--| Revision 1.64.2.1.2.25  1999/12/07 17:37:34  oconnor
--| removed accelerator action sequence
--|
--| Revision 1.64.2.1.2.24  1999/12/07 17:36:08  oconnor
--| replaced unworkable post condition with comment
--|
--| Revision 1.64.2.1.2.23  1999/12/07 17:26:26  oconnor
--| improved comments
--|
--| Revision 1.64.2.1.2.22  1999/12/07 04:10:02  oconnor
--| rename create pointer_double_click_actions ->
--| create pointer_double_press_actions
--|
--| Revision 1.64.2.1.2.21  1999/12/04 18:44:53  oconnor
--| added contracts: width|height = min width|height when not displayed
--|
--| Revision 1.64.2.1.2.20  1999/12/02 22:54:01  oconnor
--| removed obsolete part of set_sensitive comment
--|
--| Revision 1.64.2.1.2.19  1999/12/02 22:48:19  oconnor
--| removed postconditions that are part of invariant
--|
--| Revision 1.64.2.1.2.18  1999/12/02 22:23:27  brendel
--| Commented out features that are now in EV_WINDOW.
--|
--| Revision 1.64.2.1.2.17  1999/12/02 20:10:52  brendel
--| Added previously deleted features to Obsolete clause.
--|
--| Revision 1.64.2.1.2.16  1999/12/02 19:39:40  brendel
--| Moved `set_default_minimum_size' to Obsolete clause.
--| Changes small error in invariant.
--| Added postconsition tags to `set_default_colors'.
--|
--| Revision 1.64.2.1.2.15  1999/12/02 19:18:04  oconnor
--| Reworded comments.
--| Removed is_horizontally_resizable is_vertically_resizable et al,
--| all the box in a box in a box stuff has been removed, it breaks GTK's
--| default behaviour.
--| rename *insensitive -> *sensitive
--| Removed:
--| 	- geometry setting stuff that only applies to EV_FIXED.
--| 	- parent needed, irrelevant.
--| 	- expose_actions
--|
--| New invariants for:
--| 	bounds checking of geometry and
--| 	integrity check for is_show_requested/is_displayed
--|
--| Removed old review notes.
--|
--| Revision 1.64.2.1.2.14  1999/12/02 17:01:53  brendel
--| Replaced Result_assigned with bridge_ok.
--| Renamed features to comply with review report & fix-me's.
--| Declared the old ones as obsolete.
--|
--| Revision 1.64.2.1.2.13  1999/12/02 00:08:32  oconnor
--| removed old review notes and obsolete set_x|set_y features
--|
--| Revision 1.64.2.1.2.12  1999/12/01 21:47:30  brendel
--| Changed export status for `implementation'.
--|
--| Revision 1.64.2.1.2.11  1999/12/01 20:23:31  brendel
--| Changed `is_visible' to `is_show_requested'.
--|
--| Revision 1.64.2.1.2.10  1999/12/01 20:05:55  brendel
--| Changed most from review report.
--|
--| Revision 1.64.2.1.2.8  1999/12/01 18:45:16  brendel
--| Started to apply a great deal of review comments to class text.
--|
--| Revision 1.64.2.1.2.6  1999/12/01 17:03:50  brendel
--| First implementation of new events.
--|
--| Revision 1.64.2.1.2.5  1999/11/30 22:16:06  oconnor
--| implement parent in implementation layer
--|
--| Revision 1.64.2.1.2.4  1999/11/29 17:47:16  brendel
--| Added precursor calls for `create_action_sequences'.
--|
--| Revision 1.64.2.1.2.3  1999/11/24 22:48:07  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.64.2.1.2.2  1999/11/24 22:40:58  oconnor
--| added review notes
--|
--| Revision 1.64.2.1.2.1  1999/11/24 17:30:49  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.63.2.6  1999/11/23 02:10:19  oconnor
--| added experimental event action sequence for button press
--|
--| Revision 1.63.2.5  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.63.2.4  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.63.2.3  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
