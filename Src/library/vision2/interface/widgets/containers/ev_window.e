indexing
	description: "Objects that represent a window displayed on screen."
	keywords: window
	date: "$Date$"
	revision: "$Revision$"

--! FIXME : General comment/question are contracts like this ok?
--!         valid_result: foo > bar
--!         valid result does not really say much. 
--!         would a more descriptive tag be better, after all the tag's
--!         only purpose is for extra description.
--!         bar_small_enough: foo > bar 
--!         - sam 19990920

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

create
	make_root,
	make_top_level,
	make

feature {NONE} -- Initialization

	make_root is
			-- Create as application's root window.
		do
			create {EV_WINDOW_IMP} implementation.make_root
			widget_make (Void)
		ensure then
			window_exists: not destroyed
		--	False
			--| fix_me Are we the aplication root?
			--|        do we exist? - sam 19990920
		end

	make_top_level is
			-- Create without parent.
			-- Managed by the window manager.
		do
			create {EV_WINDOW_IMP} implementation.make
			widget_make (Void)
		ensure then
			parentless: parent = Void
			window_exists: not destroyed		
		end

	make (par: EV_WINDOW) is
			-- Create as child of `par'.
			-- Destroyed when `par' destoyed. 
		do
			create {EV_WINDOW_IMP} implementation.make_with_owner (par)
			widget_make (par)
		ensure then
			has_correct_parent: parent = par
			window_exists: not destroyed
		end

feature  -- Access

	icon_name: STRING is
			-- Alternative name, displayed when window iconified.
			--! FIXME  Do we say iconified of minimised? - sam 19990920
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
			valid_result: Result.is_equal (implementation.icon_mask)
		end

	icon_pixmap: EV_PIXMAP is
			-- Window icon.
		require
			exists: not destroyed
		do
			Result := implementation.icon_pixmap
		ensure
			valid_result: Result.is_equal (implementation.icon_pixmap)
		end

feature -- Status report

	is_minimized: BOOLEAN is
			-- Is minimized?
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
			-- Display above all other windows.
		require
			exists: not destroyed
		do
			implementation.raise
		--ensure
		--	False
			--| fix_me wee need to check if we are indeed above all other windows. - sam 19990920
		end

	lower is
			-- Display below all other windows.
			--! FIXME  Is this right? Does lower go all the way down or just one level down? - sam 19990920
		require
			exists: not destroyed
		do
			implementation.lower
		--ensure
		--	False
			--| fix_me wee need to check if we are indeed below all other windows. - sam 19990920
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
			-- Restore to original position when minimized or maximized.
		require
			exists: not destroyed
		do
			implementation.restore
		ensure
			--! FIXME  I am maximised, I click minimise, then restore: not_maximised exception. - sam 19990920
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
		ensure
			icon_name_set: icon_name = txt
		end

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Assign `pixmap' to icon mask.
		require
			exists: not destroyed
			valid_mask: is_valid (pixmap)
		do
			implementation.set_icon_mask (pixmap)
		ensure
			icon_mask_set: icon_mask.is_equal (pixmap)
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Assign `pixmap' to icon.
		require
			exists: not destroyed
			valid_pixmap: is_valid (pixmap)
		do
			implementation.set_icon_pixmap (pixmap)
		ensure
			icon_pixmap_set: icon_pixmap.is_equal (pixmap)
		end

feature -- Implementation

	implementation: EV_WINDOW_I
			--! FIXME  Do we need a reference to where ever the pattern
			--! for this is described? - sam 19990920
			-- Implementation of window
		
end -- class EV_WINDOW

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

