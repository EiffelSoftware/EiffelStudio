indexing
	description: "EiffelVision window. Window is a visible window%
				% on the screen."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_WINDOW

inherit
	EV_UNTITLED_WINDOW
		redefine
			implementation,
			make,
			make_top_level,
			make_root
		end

creation
	make_root,
	make_top_level,
	make

feature {NONE} -- Initialization

	make_root is
			-- Create a root window for the application.
		do
			create {EV_WINDOW_IMP} implementation.make_root
			widget_make (Void)
		end

	make_top_level is
			-- Create a top level window (a Window 
			-- without a parent).
		do
			create {EV_WINDOW_IMP} implementation.make
			widget_make (Void)
		end

	make (par: EV_WINDOW) is
			-- Create a window with a parent. Current
			-- window will be closed when the parent is
			-- closed. The parent of window is a window 
			-- (and not any EV_CONTAINER).
		do
			create {EV_WINDOW_IMP} implementation.make_with_owner (par)
			widget_make (par)
		end

feature  -- Access

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified 
		require
			exists: not destroyed
		do
			Result := implementation.icon_name
		end 
	
	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		require
			exists: not destroyed
		do
			Result := implementation.icon_mask
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		require
			exists: not destroyed
		do
			Result := implementation.icon_pixmap
		ensure
			valid_result: Result /= Void
		end

feature -- Status report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		require
			exists: not destroyed
		do
			Result := implementation.is_iconic_state
		end

feature -- Status setting

	set_iconic_state is
			-- Set start state of the application
			-- to be iconic.
		require
			exists: not destroyed
		do
			implementation.set_iconic_state
		end

	set_normal_state is
			-- Set start state of the application to be normal.
		require
			exists: not destroyed
		do
			implementation.set_normal_state
		end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		require
			exists: not destroyed
		do
			implementation.set_maximize_state
		end

feature -- Element change

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		require
			exists: not destroyed
			valid_name: txt /= Void
		do
			implementation.set_icon_name (txt)
		end

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		require
			exists: not destroyed
			valid_mask: is_valid (pixmap)
		do
			implementation.set_icon_mask (pixmap)
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon pixmap.
		require
			exists: not destroyed
			valid_pixmap: is_valid (pixmap)
		do
			implementation.set_icon_pixmap (pixmap)
		end

feature -- Implementation

	implementation: EV_WINDOW_I
			-- Implementation of window
		
end -- class EV_WINDOW

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

