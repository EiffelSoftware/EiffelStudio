--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision window, implementation interface."
	keywords: window
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TITLED_WINDOW_I
	
inherit
	EV_WINDOW_I
		redefine
			interface
		end

feature {EV_TITLED_WINDOW} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		deferred
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		deferred
		end

feature  -- Access

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified.
		require
		deferred
		end
	
	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular.
		require
		deferred
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon.
		require
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Status report

 	is_minimized: BOOLEAN is
			-- Is the window minimized (iconic state)?
		require
		deferred
		end

	is_maximized: BOOLEAN is
			-- Is the window maximized (take the all screen).
		require
		deferred
		end

feature -- Status setting

	raise is
			-- Raise a window. ie: put the window on the front
			-- of the screen.
		require
		deferred
		end

	lower is
			-- Lower a window. ie: put the window on the back
			-- of the screen.
		require
		deferred
		end

	minimize is
			-- Minimize the window.
		require
		deferred
		ensure
			is_minimized: is_minimized
		end

	maximize is
			-- Minimize the window.
		require
		deferred
		ensure
			is_maximized: is_maximized
		end

	restore is
			-- Restore the window when it is minimized or
			-- maximized. Do nothing otherwise.
		require
		deferred
		ensure
			--| FIXME  post-conditions do not match the state of restore
			not_minimized: not is_minimized
			not_maximized: not is_maximized
		end

feature -- Element change

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		require
			valid_name: txt /= Void
		deferred
		end

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		require
			pixmap_not_void: pixmap /= Void
		deferred
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Set `icon_pixmap' to `pixmap'.
		require
			pixmap_not_void: pixmap /= Void
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TITLED_WINDOW

end -- class EV_TITLED_WINDOW_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.34  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.33.6.5  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.33.6.4  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.33.6.3  2000/01/25 22:16:42  brendel
--| Added features `(dis)connect_accelerator'.
--|
--| Revision 1.33.6.2  1999/11/30 22:48:43  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.33.6.1  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.33.2.4  1999/11/04 23:10:42  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.33.2.3  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
