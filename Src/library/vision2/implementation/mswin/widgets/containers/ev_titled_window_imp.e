--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision titled window. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			last_call_was_destroy
		redefine
			interface
		end

	EV_WINDOW_IMP
		rename
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
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create titled window.
		do
			base_make (an_interface)
			title := ""
			make_top ("EV_TITLED_WINDOW")
		end

feature -- Access

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

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		local
			icon_res: INTEGER
			icon: WEL_ICON
			ev_pixmap: EV_PIXMAP
			ev_pixmap_imp: EV_PIXMAP_IMP
		do
			icon_res := cwin_send_message_result (
				wel_item, 
				Wm_geticon, 
				Wel_icon_constants.Icon_big,
				0
				)
			if icon_res /= 0 then
				create icon.make_by_pointer(
					cwel_integer_to_pointer(icon_res)
					)
				create ev_pixmap
				ev_pixmap_imp ?= ev_pixmap.implementation
				ev_pixmap_imp.set_with_icon (icon)
				Result := ev_pixmap
			else
				Result := default_pixmaps.Default_window_icon
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

	set_icon_pixmap (a_pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon pixmap.
		local
			icon: WEL_ICON
			pixmap_imp: EV_PIXMAP_IMP_STATE
		do
			pixmap_imp ?= a_pixmap.implementation
			icon := pixmap_imp.icon
			if icon = Void then
				icon := pixmap_imp.build_icon
			end
			cwin_send_message (
				wel_item, 
				Wm_seticon, 
				Wel_icon_constants.Icon_big,
				cwel_pointer_to_integer(icon.item)
				)
			cwin_send_message (
				wel_item, 
				Wm_seticon, 
				Wel_icon_constants.Icon_small,
				cwel_pointer_to_integer(icon.item)
				)
			set_class_icon (icon)
			set_class_small_icon (icon)
		end

feature {NONE} -- Implementation

	internal_icon_name: STRING
			-- Name given by the user.

	compute_minimum_height is
			-- Recompute the minimum height of the object.
		local
			mh: INTEGER
		do
			if exists then
				mh := title_bar_height + window_border_height + 2 * window_frame_height
				if has_menu then
					mh := mh + menu_bar_height
				end
				if not interface.upper_bar.empty then
					mh := mh + interface.upper_bar.minimum_height + 1
				end
				if item_imp /= Void then
					mh := mh + item_imp.minimum_height
				end
				if not interface.lower_bar.empty then
					mh := mh + interface.lower_bar.minimum_height + 1
				end
				internal_set_minimum_height (mh)
			end
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			mw, mh: INTEGER
		do
			if exists then
				mw := 2 * window_frame_width
				if item_imp /= Void then
					mw := mw + item_imp.minimum_width
				end
				mw := mw.max (interface.upper_bar.minimum_width).max (interface.lower_bar.minimum_width)

				mh := title_bar_height + window_border_height + 2 * window_frame_height
				if has_menu then
					mh := mh + menu_bar_height
				end
				if not interface.upper_bar.empty then
					mh := mh + interface.upper_bar.minimum_height + 1
				end
				if item_imp /= Void then
					mh := mh + item_imp.minimum_height
				end
				if not interface.lower_bar.empty then
					mh := mh + interface.lower_bar.minimum_height + 1
				end
				internal_set_minimum_size (
					mw.max (interface.upper_bar.minimum_width).max (interface.lower_bar.minimum_width),
					mh)
			end
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
					w := wel_width
					internal_changes := set_bit (internal_changes, 64, False)
				else
					w := 0
				end
	
				-- The height to give to the window
				if bit_set (internal_changes, 128) then
					h := wel_height
					internal_changes := set_bit (internal_changes, 128, False)
				else
					h := 0
				end
	
				wel_resize (
					w.max (minimum_width).min (maximum_width),
					h.max (minimum_height).min (maximum_height)
					)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		do
			if size_type = Wel_window_constants.Size_minimized then
				set_text (icon_name)
			elseif size_type = Wel_window_constants.Size_restored or
			       size_type = Wel_window_constants.Size_maximized
			then
				set_text (title)
			end
			{EV_WINDOW_IMP} Precursor (size_type, a_width, a_height)
		end

feature {NONE} -- Implementation

	interface: EV_TITLED_WINDOW

feature {NONE} -- Constants

	Wel_icon_constants: WEL_ICON_CONSTANTS is
			-- Icon constants (Icon_Big & Icon_small)
		once
			create Result
		end

end -- class EV_TITLED_WINDOW_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.72  2000/06/09 01:02:52  manus
--| Merge code of DEVEL branch version 1.49.4.7  to TRUNC
--|
--| Revision 1.49.4.7  2000/05/30 16:10:40  rogers
--| Removed unreferenced variables.
--|
--| Revision 1.49.4.6  2000/05/05 00:15:23  brendel
--| Fixed minimum height.
--|
--| Revision 1.49.4.5  2000/05/04 04:21:40  pichery
--| Removed local variable `default_pixmap'. Is it
--| now a once function.
--|
--| Revision 1.49.4.4  2000/05/04 01:10:07  brendel
--| Uses lower_bar and upper_bar.
--|
--| Revision 1.49.4.3  2000/05/03 22:16:28  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--| Revision 1.49.4.2  2000/05/03 19:09:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.70  2000/05/03 04:35:46  pichery
--| Fixed bug in feature `set_icon_pixmap'
--|
--| Revision 1.69  2000/05/03 00:34:35  pichery
--| Removed `icon_mask' & related features
--| Implemented `icon_pixmap' and `set_icon_pixmap'.
--| It does not work yet.
--|
--| Revision 1.68  2000/04/29 03:29:34  pichery
--| Fixed bug.
--|
--| Revision 1.67  2000/04/29 03:27:57  pichery
--| Protected `compute_minimum_size' with
--| test on `exists'.
--|
--| Revision 1.66  2000/04/29 00:44:47  brendel
--| Changed to take minimum width of status bar into account.
--|
--| Revision 1.65  2000/04/28 23:41:27  brendel
--| Uses status bar's minimum height instead of height.
--|
--| Revision 1.64  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.63  2000/04/20 16:31:03  brendel
--| Moved accelerator code into EV_WINDOW_IMP.
--|
--| Revision 1.62  2000/04/19 00:44:24  brendel
--| Revised. Moved some stuff into EV_WINDOW_IMP. Will also be needed for
--| accelerator features.
--|
--| Revision 1.61  2000/04/13 19:40:26  brendel
--| Added 2 FIXME's and removed 1.
--|
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
