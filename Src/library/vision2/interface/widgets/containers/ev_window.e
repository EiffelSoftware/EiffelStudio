indexing
	description: "Objects that represent a window displayed on screen."
	keywords: window
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
			-- Create as application's root window.
		do
			create {EV_WINDOW_IMP} implementation.make_root
			widget_make (Void)
		end

	make_top_level is
			-- Create without parent.
		do
			create {EV_WINDOW_IMP} implementation.make
			widget_make (Void)
		end

	make (par: EV_WINDOW) is
			-- Create as child of `par'. Destroyed when `par' destoyed. 
		do
			create {EV_WINDOW_IMP} implementation.make_with_owner (par)
			widget_make (par)
		end

feature  -- Access

	icon_name: STRING is
			-- Alternative name, displayed when window iconified.
		require
			exists: not destroyed
		do
			Result := implementation.icon_name
		ensure
			valid_result: Result = implementation.icon_name
		end 
	
	icon_mask: EV_PIXMAP is
			-- Mask for `icon_pixmap'.
		require
			exists: not destroyed
		do
			Result := implementation.icon_mask
		ensure
			valid_result: Result = implementation.icon_mask
		end

	icon_pixmap: EV_PIXMAP is
			-- Window icon.
		require
			exists: not destroyed
		do
			Result := implementation.icon_pixmap
		ensure
			valid_result: Result = implementation.icon_pixmap
		end

feature -- Status report

	is_minimized: BOOLEAN is
			--is minimized?
		require
			exists: not destroyed
		do
			Result := implementation.is_minimized
		ensure
			valid_result: Result = implementation.is_minimized
		end

	is_maximized: BOOLEAN is
			-- Is maximized?
		require
			exists: not destroyed
		do
			Result := implementation.is_maximized
		ensure
			valid_result: Result = implementation.is_maximized
		end

feature -- Status setting

	raise is
			-- Bring to front of screen.
		require
			exists: not destroyed
		do
			implementation.raise
		end

	lower is
			-- Move to back of screen.
		require
			exists: not destroyed
		do
			implementation.lower
		end

	minimize is
			-- Minimize.
		require
			exists: not destroyed
		do
			implementation.minimize
		ensure
			is_minimized: is_minimized
		end

	maximize is
			-- Maximize.
		require
			exists: not destroyed
		do
			implementation.maximize
		ensure
			is_maximized: is_maximized
		end

	restore is
			-- Restore to original position when minimized or
			-- maximized.
		require
			exists: not destroyed
		do
			implementation.restore
		ensure
			not_minimized: not is_minimized
			not_maximized: not is_maximized
		end

feature -- Element change

	set_icon_name (txt: STRING) is
			-- Assign `txt' to icon name.
		require
			exists: not destroyed
			valid_name: txt /= Void
		do
			implementation.set_icon_name (txt)
		end

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Assign `pixmap' to icon mask.
		require
			exists: not destroyed
			valid_mask: is_valid (pixmap)
		do
			implementation.set_icon_mask (pixmap)
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Assign `pixmap' to icon.
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

--!----------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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

