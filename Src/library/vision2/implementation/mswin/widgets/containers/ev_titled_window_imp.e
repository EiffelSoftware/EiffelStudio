--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision window. Display a window that allows only one%
		% child. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			--|FIXME See last_call_was_destroy from
			--|EV_WINDOW_IMP to see why this is
			--|undefined below.
			last_call_was_destroy
		redefine
			interface,
			initialize
		end

	EV_WINDOW_IMP
		rename
			-- Rename because the postconditions crashes.
			maximize as wel_maximize,
			minimize as wel_minimize
		redefine
			make,
			default_style,
			on_show,
			on_size,
			title,
			set_title,
			compute_minimum_height,
			compute_minimum_size,
			restore,
			interface,
			initialize,
			on_accelerator_command,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window. Window does not have any
			-- parents
		local
			e: EV_ENVIRONMENT
		do
			base_make (an_interface)
			title := ""
			make_top ("EV_TITLED_WINDOW")
		end

	initialize is
			-- Initialize Window
		local
			app_imp: EV_APPLICATION_IMP
		do
			{EV_WINDOW_IMP} Precursor
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			app_imp.add_root_window (interface)
			destroy_feature := interface~destroy
			interface.close_actions.extend (destroy_feature)
			is_initialized := True
			create accel_list.make (10)
		end

	destroy is
			-- Destroy `Current'.
		do
			if not on_wm_close_executed then
				-- If on_wm_close has not been called
				--| See comment for on_wm_close_executed in class
				--| EV_WINDOW_IMP
				interface.close_actions.prune_all (destroy_feature)
					-- Remove `destroy_feature' from
					-- `interface.close_actions'."
				interface.close_actions.call ([])
					-- Call `interface.close_actions'
			end
			{EV_WINDOW_IMP} Precursor
		end

	destroy_feature: PROCEDURE [EV_TITLED_WINDOW, TUPLE []]
		-- Holds the feature `interface.destroy'
		--| FIXME Why cannot we just prune for the real feature?
		--| It did not seem to work when attempted.

feature {EV_TITLED_WINDOW, EV_APPLICATION_IMP} -- Accelerators

	on_accelerator_command (an_accel_id: INTEGER) is
			-- Accelerator width `an_accel_id' has just been pressed.
		do
			check
				accel_list_has_an_accel_id: accel_list.has (an_accel_id)
			end
			accel_list.item (an_accel_id).actions.call ([])
		end

	accel_list: HASH_TABLE [EV_ACCELERATOR, INTEGER]
			-- List of accelerators connected to this window indexed by
			-- their `id'.

	accelerators: WEL_ACCELERATORS
			-- List of accelerators connected to this window.

	wel_acc_size: INTEGER is
			-- Used to initialize WEL_ARRAY.
		local
			wel_acc: WEL_ACCELERATOR
		once
			wel_acc ?= (create {EV_ACCELERATOR}).implementation
			Result := wel_acc.structure_size
		end

	create_accelerators is
			-- Recreate the accelerators.
		local
			wel_array: WEL_ARRAY [WEL_ACCELERATOR]
			acc: WEL_ACCELERATOR
			n: INTEGER
		do
			if accel_list.empty then
				accelerators := Void
			else
	 			from
	 				accel_list.start
		 			create wel_array.make (accel_list.count, wel_acc_size)
					n := 0
				until
					accel_list.after
				loop
					acc ?= accel_list.item_for_iteration.implementation
					wel_array.put (acc, n)
					accel_list.forth
					n := n + 1
	 			end
	 			create accelerators.make_with_array (wel_array)
			end
		end

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			check
				acc_imp_not_void: acc_imp /= Void
			end
			accel_list.put (an_accel, acc_imp.id)
			create_accelerators
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			check
				acc_imp_not_void: acc_imp /= Void
			end
			accel_list.remove (acc_imp.id)
			create_accelerators
		end

feature  -- Access

	title: STRING
			-- Application name to be displayed by
			-- the window manager

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		do
			if internal_icon_name = Void then
				Result := title
			else
				Result := internal_icon_name
			end
		end

	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
			check
				not_yet_implemented: False
			end
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status report

	is_minimized: BOOLEAN is
			-- Is the window minimized (iconic state)?
		do
			Result := flag_set (style, Ws_minimize) or
						(not is_show_requested and
							bit_set (internal_changes, 1028))
		end

	is_maximized: BOOLEAN is
			-- Is the window maximized (take the all screen).
		do
			Result := (is_show_requested and flag_set (style, Ws_maximize)) or
						(not is_show_requested and
							bit_set (internal_changes, 256))
		end

feature -- Status setting

	raise is
			-- Raise a window. ie: put the window on the front
			-- of the screen.
		do
			set_z_order (hwnd_top)
			set_focus
		end

	lower is
			-- Lower a window. ie: put the window on the back
			-- of the screen.
		do
			set_z_order (hwnd_bottom)
		end

	minimize is
			-- Minimize the window.
			-- Shows the window too.
		do
			if is_show_requested then
				wel_minimize
			else
				internal_changes := set_bit (internal_changes, 1028, True)
			end
		end

	maximize is
			-- Maximize the window.
			-- If the window is not shown, it gives it the screen
			-- size, but do not call the precursor otherwise, it
			-- shows the window.
		do
			if is_show_requested then
				wel_maximize
			else
				internal_changes := set_bit (internal_changes, 256, True)
			end
		end

	restore is
			-- Restore the window when it is minimized or
			-- maximized. Do nothing otherwise.
			-- If the window is not shown, it simply regive it
			-- its freedom to resize.
		do
			if is_show_requested then
				{EV_WINDOW_IMP} Precursor
			else
				internal_changes := set_bit (internal_changes, 256, False)
				internal_changes := set_bit (internal_changes, 1028, False)
			end
		end

feature -- Element change

	set_title (txt: STRING) is
			-- Make `txt' the title of the window.            
		do
			title := txt
			if not is_minimized then
				set_text (txt)
			end
		end

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		do
			internal_icon_name := txt
			if is_minimized then
				set_text (txt)
			end
		end	

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		do
			check
				not_yet_implemented: False
			end
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon pixmap.
		do
			check
				not_yet_implemented: False
			end
		end

feature {NONE} -- Implementation

	internal_icon_name: STRING
			-- Name given by the user.

	compute_minimum_height is
			-- Recompute the minimum height of the object.
		local
			mh: INTEGER
		do
			-- We calculate the values first
			mh := title_bar_height + window_border_height +
				2 * window_frame_height

			if child /= Void then
				mh := mh + child.minimum_height
			end
			if has_menu then
				mh := mh + menu_bar_height
			end
			if status_bar /= Void then
				mh := mh + status_bar.height
			end

			-- Finaly, we set the value
			internal_set_minimum_height (mh)
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			mw, mh: INTEGER
		do
			-- We calculate the values first
			mw := 2 * window_frame_width
			mh := title_bar_height + window_border_height +
				2 * window_frame_height

			if child /= Void then
				mw := mw + child.minimum_width
				mh := mh + child.minimum_height
			end
			if has_menu then
				mh := mh + menu_bar_height
			end
			if status_bar /= Void then
				mh := mh + status_bar.height
			end

			-- Finaly, we set the value
			internal_set_minimum_size (mw, mh)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_overlapped + Ws_dlgframe + Ws_thickframe
					+ Ws_clipchildren + Ws_clipsiblings
					+ Ws_minimizebox + Ws_maximizebox
					+ Ws_border + Ws_sysmenu 
		end

	on_show is
			-- When the window receive the on_show message,
			-- it resizes the window at the size of the child.
			-- And it send the message to the child because wel
			-- don't
		local
			w, h: INTEGER
		do
			-- We check if there is a menu
			if has_menu then
				draw_menu
			end

			-- Different behaviors if the window was maximized or not.
			if is_maximized then
				integrate_changes
				wel_maximize
			elseif is_minimized then
				integrate_changes
				wel_minimize
			else
				-- The width to give to the window
				if bit_set (internal_changes, 64) then
					w := width
					internal_changes := set_bit (internal_changes, 64, False)
				else
					w := 0
				end
	
				-- The height to give to the window
				if bit_set (internal_changes, 128) then
					h := height
					internal_changes := set_bit (internal_changes, 128, False)
				else
					h := 0
				end
	
				wel_resize (w.max (minimum_width).min (maximum_width),
					h.max (minimum_height).min (maximum_height))
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		local
			str: STRING
		do
			if size_type = size_minimized then
				set_text (icon_name)
			elseif size_type = size_restored or size_type = size_maximized then
				set_text (title)
			end
			{EV_WINDOW_IMP} Precursor (size_type, a_width, a_height)
		end

feature {NONE} -- Implementation

	interface: EV_TITLED_WINDOW

end -- class EV_TITLED_WINDOW_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.60  2000/04/03 16:39:10  rogers
--| Redefined destroy from EV_WINDOW_IMP. Added `destroy_feature'.
--|
--| Revision 1.59  2000/03/21 20:21:09  brendel
--| Fixed initialization of WEL_ARRAY [WEL_ACCELERATOR].
--|
--| Revision 1.58  2000/03/21 02:27:49  brendel
--| First implementation of accelerators.
--|
--| Revision 1.57  2000/03/16 17:20:59  brendel
--| Calling {EV_APPLICATION_IMP}.add_root_window immediately instead of
--| through interface.
--|
--| Revision 1.56  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.55.2.1  2000/03/11 00:19:16  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.55  2000/02/29 22:18:27  rogers
--| Redefined initialize, to add the window to the root windows list and to
--| also extend the close_actions with destroy.
--|
--| Revision 1.54  2000/02/29 17:55:24  rogers
--| Undefined last_call_was_destroy  inherited from EV_TITLED_WINDOW_I as
--| last_call_from_destroy is now re-defined in EV_WINDOW_IMP. Needs fixing.
--|
--| Revision 1.53  2000/02/28 19:39:07  rogers
--| During creation, the window is now added to the root_windows list
--| (Still used for windows implementation).
--|
--| Revision 1.52  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.51  2000/02/14 22:26:34  oconnor
--| merged from HACK-O-RAMA
--|
--| Revision 1.49.6.7  2000/02/04 19:08:03  rogers
--| Removed make_with_owner.
--|
--| Revision 1.49.6.6  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.49.6.5  2000/01/27 19:30:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.49.6.4  2000/01/25 23:33:02  brendel
--| Added (dis)connect_accelerator.
--|
--| Revision 1.49.6.3  2000/01/18 00:17:39  rogers
--| Undefined propatae_foreground_color and propagate_background_color from
--| EV_WINDOW_I.
--|
--| Revision 1.49.6.2  1999/12/17 00:44:22  rogers
--| Altered to fit in with the review branch. Some redefinitions required,
--| make now takes an interface. is_show_requested replaces shown.
--|
--| Revision 1.49.6.1  1999/11/24 17:30:30  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.49.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
