indexing
	description:
		" EiffelVision window. Display a window that allows only one%
		% child. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I

	EV_UNTITLED_WINDOW_IMP
		redefine
			make,
			make_with_owner,
			default_style,
			on_show,
			on_size,
			title,
			set_title,
			compute_minimum_height,
			compute_minimum_size
		end

creation
	make,
	make_with_owner,
	make_root

feature {NONE} -- Initialization

	make is
			-- Create a window. Window does not have any
			-- parents
		do
			title := ""
			make_top ("EV_WINDOW")
		end

	make_with_owner (par: EV_WINDOW) is
			-- Create a window with a parent.
			-- For a window, we cannot set the parent after or it does a 
		local
			ww: WEL_FRAME_WINDOW
		do
			title := ""
			ww ?= par.implementation
			check
				valid_owner: ww /= Void
			end
			make_child (ww, "EV_WINDOW")
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
			Result := flag_set (style, Ws_minimize)
		end

	is_maximized: BOOLEAN is
			-- Is the window maximized (take the all screen).
		do
			Result := flag_set (style, Ws_maximize)
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

			-- We check if there is a menu
			if has_menu then
				draw_menu
			end

			-- We resize everything and draw the menu.
			resize (w.max (minimum_width).min (maximum_width), h.max (minimum_height).min (maximum_height))
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
			{EV_UNTITLED_WINDOW_IMP} Precursor (size_type, a_width, a_height)
		end

end -- class EV_WINDOW_IMP

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

