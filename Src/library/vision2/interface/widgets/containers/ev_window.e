indexing
	description:
		"Eiffel Vision window.  Top level window without title bar."
	status: "See notice at end of class"
	keywords: "toplevel, window, popup" 
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW

inherit
	EV_CELL
		export
			{NONE} set_parent
		undefine
			create_implementation
		redefine
			implementation,
			create_action_sequences,
			parent,
			has
		end

create
	default_create

feature  -- Access
 
	parent: EV_WINDOW is
			-- Window of which `Current' is a child.
		do
			Result ?= implementation.parent
		end

	maximum_width: INTEGER is
			-- Upper bound on `width' in pixels.
		do
			Result := implementation.maximum_width
		ensure
			bridge_ok: Result = implementation.maximum_width
		end

	maximum_height: INTEGER is
			-- Upper bound on `height' in pixels.
		do
			Result := implementation.maximum_height
		ensure
			bridge_ok: Result = implementation.maximum_height
		end

	title: STRING is
			-- A textual name used by the window manager.
		do
			Result := implementation.title
		ensure
			bridge_ok: Result = implementation.title
		end

	menu_bar: EV_MENU_BAR is
			-- Horizontal bar at top of client area that contains menu's.
		do
			Result := implementation.menu_bar
		ensure
			bridge_ok: Result = implementation.menu_bar
		end

	status_bar: EV_STATUS_BAR is
			-- Horizontal bar at bottom of client area that contains
			-- helpful information for the user.
		do
			Result := implementation.status_bar
		ensure
			bridge_ok: Result = implementation.status_bar
		end

	blocking_window: EV_WINDOW is
			-- Window that `Current' is a transient for.
		do
			Result := implementation.blocking_window
		ensure
			bridge_ok: Result = implementation.blocking_window
		end
feature -- Status report

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := implementation.has (v)	
		end

	user_can_resize: BOOLEAN is
			-- Can the user resize?
		do
			Result := implementation.user_can_resize
		ensure
			bridge_ok: Result = implementation.user_can_resize
		end

	is_modal: BOOLEAN is
			-- Must the window be closed before application can
			-- receive user events again?
		do
			Result := implementation.is_modal
		ensure
			bridge_ok: Result = implementation.is_modal
		end

feature -- Status setting

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		do
			implementation.set_blocking_window (a_window)
		ensure
			assigned: blocking_window = a_window
		end

	enable_modal is
			-- Set `is_modal' to `True'.
		do
			implementation.enable_modal
		ensure
			is_modal: is_modal
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
			implementation.disable_modal
		ensure
			not_is_modal: not is_modal
		end

	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset from parent to `a_x' pixels.
		do
			implementation.set_x_position (a_x)
		ensure
			x_position_assigned: x_position = a_x
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset from parent to `a_y' pixels.
		do
			implementation.set_y_position (a_y)
		ensure
			y_position_assigned: y_position = a_y
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset from parent to `a_x' pixels.
			-- Set vertical offset from parent to `a_y' pixels.
		do
			implementation.set_position (a_x, a_y)
		ensure
			x_position_assigned: x_position = a_x
			y_position_assigned: y_position = a_y
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width' pixels.
		require
			a_width_positive_or_zero: a_width >= 0
		do
			implementation.set_width (a_width)
		ensure
			width_assigned: width = minimum_width or else width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height' pixels.
		require
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.set_height (a_height)
		ensure
			height_assigned: height = minimum_height or else height = a_height
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width' pixels.
			-- Set the vertical size to `a_height' pixels.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.set_size (a_width, a_height)
		ensure
			width_assigned: width = minimum_width or else width = a_width
			height_assigned: height = minimum_height or else height = a_height
		end

	enable_user_resize is
			-- Allow user to resize.
		do
			implementation.allow_resize
		ensure
			user_can_resize: user_can_resize
		end

	disable_user_resize is
			-- Prevent user from resizing.
		do
			implementation.forbid_resize
		ensure
			not_user_can_resize: not user_can_resize
		end

	set_maximum_width (a_maximum_width: INTEGER) is
			-- Assign `a_maximum_width' to `maximum_width' in pixels.
		require
			a_maximum_width_non_negative: a_maximum_width >= 0
			a_maximum_width_not_less_than_minimum_width:
				a_maximum_width >= minimum_width
		do
			implementation.set_maximum_width (a_maximum_width)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
		end 

	set_maximum_height (a_maximum_height: INTEGER) is
			-- Assign `a_maximum_height' to `maximum_height' in pixels.
		require
			a_maximum_height_non_negative: a_maximum_height >= 0
			a_maximum_height_not_less_than_minimum_height:
				a_maximum_height >= minimum_height
		do
			implementation.set_maximum_height (a_maximum_height)
		ensure
			maximum_height_assigned: maximum_height = a_maximum_height
		end

	set_maximum_size (a_maximum_width, a_maximum_height: INTEGER) is
			-- Assign `a_maximum_width' to `maximum_width'
			-- and `a_maximum_height' to `maximum_height' in pixels.
		require
			a_maximum_width_not_less_than_minimum_width:
				a_maximum_width >= minimum_width
			a_maximum_height_not_less_than_minimum_height:
				a_maximum_height >= minimum_height
		do
			implementation.set_maximum_size (a_maximum_width, a_maximum_height)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
			maximum_height_assigned: maximum_height = a_maximum_height
		end

	set_title (a_title: STRING) is
			-- Make `text' the new title.
		require
			a_title_not_void: a_title /= Void
		do
			implementation.set_title (a_title)
		ensure
			a_title_assigned: title.is_equal (a_title)
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		require
			no_menu_bar_assigned: menu_bar = Void
			a_menu_bar_not_void: a_menu_bar /= Void
		do
			implementation.set_menu_bar (a_menu_bar)
		ensure
			assigned: menu_bar = a_menu_bar
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		do
			implementation.remove_menu_bar
		ensure
			void: menu_bar = Void
		end

	set_status_bar (a_bar: EV_STATUS_BAR) is
			-- Make `a_bar' the new status bar of the window.
		require
			no_status_bar_assigned: status_bar = Void
			a_bar_not_void: a_bar /= Void
		do
			implementation.set_status_bar (a_bar)
		ensure
			a_bar_assigned: status_bar = a_bar
		end

	remove_status_bar is
			-- Set `status_bar' to `Void'.
		do
			implementation.remove_status_bar
		ensure
			void: status_bar = Void
		end

feature -- Event handling

	close_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when window is closed.

	move_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when window moves.

feature {EV_WINDOW, EV_ANY_I} -- Implementation

	implementation: EV_WINDOW_I
            -- Responsible for interaction with the underlying native graphics
            -- toolkit.

	create_implementation is
			-- Create implementation of window.
		do
			create {EV_WINDOW_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create empty action sequences, not yet connected to events.
		do
			{EV_CELL} Precursor
			create close_actions
			create resize_actions
			create move_actions
		end

invariant
	title_not_void: is_useable implies title /= Void


	--| FIXME IEK When Using X we can only use hints to set max/min dimensions,
	--| This means that the width can be greater than the max width set (& height)
	--width_not_greater_than_maximum_width: width <= maximum_width
	--height_not_greater_than_maximum_height: height <= maximum_height

	--| FIXME Do not hold
	--consistent_horizontal_bounds: maximum_width >= minimum_width 
	--consistent_vertical_bounds: maximum_height >= minimum_height

	close_actions_not_void: close_actions /= Void
	resize_actions_not_void: resize_actions /= Void
	move_actions_not_void: move_actions /= Void

end -- class EV_WINDOW

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
--| Revision 1.43  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.41.2.1.2.14  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.41.2.1.2.13  2000/02/07 19:21:13  king
--| Removed resize_actions as this is already inherited from cell
--|
--| Revision 1.41.2.1.2.12  2000/02/04 22:12:09  king
--| Redefined has feature to accomodate for menu and status bar
--|
--| Revision 1.41.2.1.2.11  2000/02/04 21:17:52  king
--| Added status bar features
--|
--| Revision 1.41.2.1.2.10  2000/02/03 22:56:19  brendel
--| Added *menu_bar features.
--|
--| Revision 1.41.2.1.2.9  2000/01/28 20:00:15  oconnor
--| released
--|
--| Revision 1.41.2.1.2.8  2000/01/27 19:30:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.41.2.1.2.7  2000/01/26 18:11:38  brendel
--| Removed modal-related features.
--|
--| Revision 1.41.2.1.2.6  2000/01/25 00:08:05  oconnor
--| removed obsolete command manipulation features
--| use action sequences instead
--|
--| Revision 1.41.2.1.2.5  2000/01/24 23:16:09  oconnor
--| Moved content of ev_window.e into ev_titled_window.e
--| Moved content of ev_untitled_window.e into ev_window.e
--| Removed ev_untitled_window.e
--|
--| Revision 1.9.6.21  2000/01/20 18:50:11  oconnor
--| handle new non deferred EV_CELL class inheritnce
--|
--| Revision 1.9.6.20  2000/01/18 00:45:36  king
--| Removed max width/height invariants as they are only hints in X and may
--| not be used
--|
--| Revision 1.9.6.19  2000/01/18 00:04:10  brendel
--| Commented out invariants that do not hold.
--|
--| Revision 1.9.6.18  2000/01/17 20:39:12  oconnor
--| reinstated max width/height pending further thought :)
--|
--| Revision 1.9.6.16  2000/01/17 02:10:33  oconnor
--| Missing for log for 1.9.6.14:
--| Removed widget grouping feature temporarily.
--| To be reinstated after core vision is finished.
--|
--| Revision 1.9.6.15  2000/01/17 01:56:19  oconnor
--| added invariants for actions sequences
--|
--| Revision 1.9.6.14  2000/01/17 01:55:16  oconnor
--| Added action sequences.
--| Fixed comments.
--|
--| Revision 1.9.6.13  2000/01/17 00:39:20  oconnor
--| Previous log message in error.
--| Added invariants, fixed comments.
--|
--| Revision 1.9.6.12  2000/01/17 00:25:45  oconnor
--| comments and formattinginterface/widgets/ev_widget.e
--|
--| Revision 1.9.6.11  2000/01/15 02:01:20  oconnor
--| comments
--|
--| Revision 1.9.6.10  1999/12/17 23:20:52  oconnor
--| formatting
--|
--| Revision 1.9.6.9  1999/12/16 09:23:35  oconnor
--| applied review recomendations and did general cleanup
--|
--| Revision 1.9.6.8  1999/12/15 20:17:30  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.9.6.7  1999/12/07 18:55:08  brendel
--| Improved contracts on dimension setting routines.
--|
--| Revision 1.9.6.6  1999/12/07 18:05:26  brendel
--| Commented out postconditions on dimension setting routines.
--|
--| Revision 1.9.6.5  1999/12/02 22:11:25  brendel
--| Added features set_size and set_position, since they are removed from
--| widget.
--|
--| Revision 1.9.6.4  1999/12/02 20:05:35  brendel
--| Removed parent_needed from redefenition clause.
--|
--| Revision 1.9.6.3  1999/11/24 22:40:59  oconnor
--| added review notes
--|
--| Revision 1.9.6.2  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.6.1  1999/11/24 00:20:24  oconnor
--| merged from  REVIEW_BRANCH_19991006
--|
--| Revision 1.9.2.6  1999/11/17 02:01:19  oconnor
--| use new EV_CELL class
--|
--| Revision 1.9.2.5  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.9.2.4  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.9.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
