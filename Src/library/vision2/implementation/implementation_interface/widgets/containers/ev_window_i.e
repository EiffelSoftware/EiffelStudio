indexing
	description: 
		"EiffelVision window, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WINDOW_I
	
inherit
	EV_UNTITLED_WINDOW_I

feature {NONE} -- Initialization

	make_with_owner (par: EV_WINDOW) is
			-- Create a window with `par' as parent.
			-- The life of the window will depend on
			-- the one of `par'.
		deferred
		end

feature  -- Access

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		require
			exists: not destroyed
		deferred
		end
	
	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		require
			exists: not destroyed
		deferred
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Status report

 	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_iconic_state is
			-- Set start state of the application to be iconic.
		require
			exists: not destroyed
		deferred
		end

 	set_normal_state is
			-- Set start state of the application to be normal.
		require
			exists: not destroyed
		deferred
		end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		require
			exists: not destroyed
			valid_name: txt /= Void
		deferred
		end

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		require
			exists: not destroyed
			valid_mask: is_valid (pixmap)
		deferred
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Set `icon_pixmap' to `pixmap'.
		require
			exists: not destroyed
			valid_pixmap: is_valid (pixmap)
		deferred
		end

end -- class EV_WINDOW_I

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
