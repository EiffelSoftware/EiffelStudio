--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision untitled window, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WINDOW_I

inherit
	EV_CELL_I
		redefine
			interface,
			set_default_colors
		end

feature {EV_WINDOW} -- Initialization

	set_default_colors is
			-- Initialize the colors of the widget
		local
			default_colors: EV_DEFAULT_COLORS
			color: EV_COLOR
		do
			create default_colors
			set_background_color (default_colors.Color_dialog)
			create color.make_with_rgb (0, 0, 0)
			set_foreground_color (color)
		end

feature  -- Access

	is_modal: BOOLEAN is
			-- Must the window be closed before application continues?
		deferred
		end

	maximum_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		require
		deferred
		ensure
			Result >= 0
		end	

	maximum_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		require
		deferred
		ensure
			Result >= 0
		end

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		require
		deferred
		end

	widget_group: EV_WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		require
		deferred
		end

	user_can_resize: BOOLEAN is
			-- Can the user resize?
		do
			--FIXME
			check
				not_implemented: false
			end
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		local
			ilist: EV_ITEM_LIST_I [EV_ITEM]
		do
			ilist ?= v.implementation
			if (status_bar /= Void) then
				Result := ilist = status_bar.implementation
			elseif (menu_bar /= Void and then Result = False) then
				Result := ilist = menu_bar.implementation
			end

			if Result = False then
				Result := item = v
			end	
		end
    
	menu_bar: EV_MENU_BAR is
			-- Horizontal bar at top of client area that contains menu's.
		deferred
		end

	status_bar: EV_STATUS_BAR is
			-- Horizontal bar at bottom of client area used for showing
			-- helpful messages to the user.
		deferred
		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		deferred
		end

feature -- Status setting

	enable_modal is
			-- Set `is_modal' to `True'.
		deferred
		ensure
			is_modal: is_modal
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		deferred
		ensure
			not_is_modal: not is_modal
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		deferred
		end

	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		deferred
		ensure
			x_position_assigned: x_position = a_x
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		deferred
		ensure
			y_position_assigned: y_position = a_y
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		deferred
		ensure
			x_position_assigned: x_position = a_x
			y_position_assigned: y_position = a_y
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		require
			a_width_positive_or_zero: a_width >= 0
		deferred
		ensure
			width_assigned: width = minimum_width or else width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		require
			a_height_positive_or_zero: a_height >= 0
		deferred
		ensure
			height_assigned: height = minimum_height or else height = a_height
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		deferred
		ensure
			width_assigned: width = minimum_width or else width = a_width
			height_assigned: height = minimum_height or else height = a_height
		end

	forbid_resize is
			-- Forbid the resize of the window.
		require
		deferred
		end

	allow_resize is
			-- Allow the resize of the window.
		require
		deferred
		end

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new `maximum_width'.
		require
			large_enough: value >= 0
		deferred
		ensure
			maximum_width_set: maximum_width = value
		end 

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new `maximum_height'.
		require
			large_enough: value >= 0
		deferred
		ensure
			maximum_height_set: maximum_height = value
		end

	set_maximum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
		require
--			valid_width: value >= minimum_width
--			valid_height: value >= minimum_height
		do
			set_maximum_width (mw)
			set_maximum_height (mh)
		end

	set_title (txt : STRING) is
			-- Make `text' the new title.
		require
			valid_title: txt /= Void
		deferred
		end

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		require
			widget_not_void: widget /= Void
		deferred
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		require
			no_menu_bar_assigned: menu_bar = Void
			a_menu_bar_not_void: a_menu_bar /= void
		deferred
		ensure
			assigned: menu_bar = a_menu_bar
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		deferred
		ensure
			void: menu_bar = Void
		end

	set_status_bar (a_bar: EV_STATUS_BAR) is
			-- Make `a_bar' the new status bar of the window.
		require
			no_status_bar_assigned: status_bar = Void
			a_bar_not_void: a_bar /= Void
		deferred
		end

	remove_status_bar is
			-- Set `status_bar' to `Void'.
		deferred
		ensure
			void: status_bar = Void
		end

feature -- Miscellaneous

	WINDOW_POSITION_NONE: INTEGER is 0
			-- Constant to use to have the window first displayed
			-- at .

	WINDOW_POSITION_CENTER: INTEGER is 1
			-- Constant to use to have the window first displayed
			-- at the center of the screen.


	WINDOW_POSITION_MOUSE: INTEGER is 2
			-- Constant to use to have the window first displayed
			-- at the mouse position.

feature {EV_ANY_I} -- Implementation

	interface: EV_WINDOW

end -- class EV_WINDOW_I

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.17  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.9.6.16  2000/02/04 22:11:25  king
--| Redefined has feature to accomodate for menu and status bar
--|
--| Revision 1.9.6.15  2000/02/04 21:31:07  king
--| Added status bar features
--|
--| Revision 1.9.6.14  2000/02/04 04:48:03  oconnor
--| released
--|
--| Revision 1.9.6.13  2000/02/03 22:55:37  brendel
--| Added *menu_bar features.
--|
--| Revision 1.9.6.12  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.11  2000/01/26 18:13:11  brendel
--| Removed modal-related features.
--|
--| Revision 1.9.6.10  2000/01/25 00:19:11  oconnor
--| removed old command stuff, use action sequences
--|
--| Revision 1.9.6.9  2000/01/17 01:35:56  oconnor
--| added unimplemented user_can_resize feature
--|
--| Revision 1.9.6.8  1999/12/17 18:22:35  rogers
--| Now inherits EV_CELL_I instead of EV_CONTAINER_I.
--|
--| Revision 1.9.6.7  1999/12/16 09:23:57  oconnor
--| added is_modal
--|
--| Revision 1.9.6.6  1999/12/07 19:08:57  brendel
--| Improved contracts on dimension setting routines.
--|
--| Revision 1.9.6.5  1999/12/07 18:30:30  brendel
--| Commented out postconditions on dimension setting routines.
--|
--| Revision 1.9.6.4  1999/12/03 02:34:56  brendel
--| Changed to new color creation procedure.
--|
--| Revision 1.9.6.3  1999/12/02 22:13:21  brendel
--| Added features set_size and set_position.
--|
--| Revision 1.9.6.2  1999/11/30 22:48:43  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.9.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.4  1999/11/04 23:10:42  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.9.2.3  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
