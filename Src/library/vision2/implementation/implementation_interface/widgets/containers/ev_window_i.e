indexing
	description: "Eiffel Vision window. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WINDOW_I

inherit
	EV_CELL_I
		redefine
			interface
		end
	
	EV_POSITIONABLE_I
		redefine
			interface
		end

	EV_WINDOW_ACTION_SEQUENCES_I

feature -- Access

	upper_bar: EV_VERTICAL_BOX 
			-- Room at top of `Current'. (Example use: toolbars.)
			-- Positioned below menu bar.

	lower_bar: EV_VERTICAL_BOX
			-- Room at bottom of `Current'. (Example use: statusbar.)

	is_modal: BOOLEAN is
			-- Must `Current' be closed before other windows can
			-- receive user events?
		deferred
		end

	maximum_width: INTEGER is
			-- Maximum width that `Current' can take.
		deferred
		end
	
	maximum_height: INTEGER is
			-- Maximum height that `Current' can take.
		deferred
		end

	internal_maximum_width: INTEGER is
			-- Maximum width that `Current' can take.
			--| Because the minimum width of `Current' can
			--| be determined by the width of it's child,
			--| regardless of the maximum_width assigned,
			--| if the maximum_width is less than the
			--| minimum_width, we return the minimum_width.
		do
			Result := maximum_width
			if Result < minimum_width then
				Result := minimum_width
			end
		end	

	internal_maximum_height: INTEGER is
			-- Maximum height that `Current' can take.
			--| Because the minimum height of `Current' can
			--| be determined by the height of it's child,
			--| regardless of the maximum_size assigned,
			--| if the maximum_height is less than the
			--| minimum_height, we return the minimum_height.
		do
			Result := maximum_height
			if Result < minimum_height then
				Result := minimum_height
			end
		end

	title: STRING is
			-- Application name to be displayed by the window manager.
		deferred
		end

	user_can_resize: BOOLEAN
			-- Can the user resize?

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			if v /= Void then
				Result := item = v or else 
					interface.lower_bar = v or else
					interface.upper_bar = v
			end
		end
    
	menu_bar: EV_MENU_BAR is
			-- Horizontal bar at top of client area that contains menu's.
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

	disable_user_resize is
			-- Forbid the resize of the window.
		do
			user_can_resize := False
			forbid_resize
		end

	enable_user_resize is
			-- Allow the resize of the window.
		do
			user_can_resize := True
			allow_resize
		end

	forbid_resize is
			-- Forbid the resize of the window.
		deferred
		end

	allow_resize is
			-- Allow the resize of the window.
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
			valid_width: mw >= minimum_width
			valid_height: mh >= minimum_height
		do
			set_maximum_width (mw)
			set_maximum_height (mh)
		end

	set_title (txt : STRING) is
			-- Make `txt' the new title.
		require
			valid_title: txt /= Void
		deferred
		end

	remove_title is
			-- Make `title' `Void'.
		do
			set_title ("")
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

	lock_update is
			-- Lock updates for this window on certain platforms until
			-- `unlock_update' is called.
		do
			(create {EV_ENVIRONMENT}).application.implementation.set_locked_window (interface)
		end

	unlock_update is
			-- Unlock updates for this window on certain platforms.
		do
			(create {EV_ENVIRONMENT}).application.implementation.set_locked_window (Void)
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


--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.42  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.41  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.40  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.33.4.11  2001/05/24 17:46:50  pichery
--| Switched the call to `forbid/allow_resize' with
--| `user_can_resize := True/False' so that we have the right information
--| about `user_can_resize' when you are in `forbid/allow_resize'.
--|
--| Revision 1.33.4.10  2001/04/12 16:36:37  king
--| Corrected has postcond as windows is a cell that is empty when item is void
--|
--| Revision 1.33.4.9  2001/02/17 23:20:50  pichery
--| Added `lock_update' / `unlock_update'
--|
--| Revision 1.33.4.8  2001/01/21 22:40:00  pichery
--| Added `lock_update' and `unlock_update' for windows implementation
--| purpose.
--|
--| Revision 1.33.4.7  2000/12/14 17:19:27  rogers
--| Added remove_title.
--|
--| Revision 1.33.4.6  2000/10/27 02:28:20  manus
--| Removed declaration or undefinition of `set_default_colors'. Now it is defined
--| in a platform dependent manner to improve performance and correctness.
--|
--| Revision 1.33.4.5  2000/10/26 19:49:44  rogers
--| Removed widget_group and set_widget_group as they are no longer in Vision2.
--|
--| Revision 1.33.4.4  2000/10/09 21:33:52  oconnor
--| Renamed ev_window_i.e to ev_titled_window_i.e
--| Renamed ev_untitled_window_i.e to ev_window_i.e
--|
--| Revision 1.9.4.8  2000/10/06 17:56:47  rogers
--| Addedm internal_maximum_width and internal_maximum_height which return the
--| minimum, if greater than the maximum, as a windows minimum size can be
--| constrained by the minimum_sizes of it's widgets.
--|
--| Revision 1.9.4.7  2000/09/22 00:28:59  rogers
--| Implemented user_can_resize. Added disable/enable_user_resize.
--|
--| Revision 1.9.4.6  2000/09/04 18:18:17  oconnor
--| inherit EV_POSITIONABLE_I
--|
--| Revision 1.9.4.5  2000/08/17 23:29:15  rogers
--| removed fixme not_reviewed. Comments, formatting. Replaced commented
--| pre conditions on set_minimum_size.
--|
--| Revision 1.9.4.4  2000/07/24 21:30:47  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.9.4.3  2000/07/12 21:26:45  brendel
--| Moved upper_bar and lower_bar from interface.
--|
--| Revision 1.9.4.2  2000/05/04 01:01:37  brendel
--| Cleanup.
--|
--| Revision 1.9.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/05/03 00:26:14  pichery
--| Removed useless `blocking_window'
--|
--| Revision 1.13  2000/04/28 22:04:13  brendel
--| Commented out strange redefintion of `has'.
--|
--| Revision 1.12  2000/04/28 21:43:34  brendel
--| Replaced EV_STATUS_BAR with EV_WIDGET.
--|
--| Revision 1.11  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
