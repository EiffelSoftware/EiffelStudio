--| FIXME Not for release
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
			propagate_background_color
		redefine
			interface
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
			interface
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window. Window does not have any
			-- parents
		do
			base_make (an_interface)
			title := ""
			make_top ("EV_TITLED_WINDOW")
		end

feature {EV_TITLED_WINDOW} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		do
			check
				to_be_implemented: False
			end
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		do
			check
				to_be_implemented: False
			end
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
						(not is_show_requested and bit_set (internal_changes, 1028))
		end

	is_maximized: BOOLEAN is
			-- Is the window maximized (take the all screen).
		do
			Result := (is_show_requested and flag_set (style, Ws_maximize)) or
						(not is_show_requested and bit_set (internal_changes, 256))
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
			mh := title_bar_height + window_border_height + 2 * window_frame_height

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
			mh := title_bar_height + window_border_height + 2 * window_frame_height

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
	
				resize (w.max (minimum_width).min (maximum_width), h.max (minimum_height).min (maximum_height))
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
--| Undefined propatae_foreground_color and propagate_background_color from EV_WINDOW_I.
--|
--| Revision 1.49.6.2  1999/12/17 00:44:22  rogers
--| Altered to fit in with the review branch. Some redefinitions required, make now takes an interface. is_show_requested replaces shown.
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
