indexing
	description:
		"Eiffel Vision titled window. Implementation interface."
	status: "See notice at end of class"
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

feature -- Access

	icon_name: STRING is
			-- Alternative name, displayed when window is minimised.
		deferred
		end 

	icon_pixmap: EV_PIXMAP is
			-- Window icon.
		deferred
		end
	
feature -- Status report

	is_minimized: BOOLEAN is
			-- Is displayed iconified/minimised?
		deferred
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
		deferred
		end

feature -- Status setting

	raise is
			-- Request that window be displayed above all other windows.
		deferred
		end

	lower is
			-- Request that window be displayed below all other windows.
		deferred
		end

	minimize is
			-- Display iconified/minimised.
		deferred
		ensure
			--| FIXME VB probably impossible for GTK.
			--| is_minimized: is_minimized
		end

	maximize is
			-- Display at maximum size.
		deferred
		ensure
			is_maximized: is_maximized
		end

	restore is
			-- Restore to original position when minimized or maximized.
		deferred
		ensure
			--| FIXME VB probably impossible for GTK.
			--| minimize_restored: old is_minimized implies not is_minimized
			maximize_restored: old is_maximized implies not is_maximized
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING) is
			-- Assign `an_icon_name' to `icon_name'.
		require
			an_icon_name_not_void: an_icon_name /= Void
		deferred
		ensure
			icon_name_assigned: icon_name.is_equal (an_icon_name)
		end

	set_icon_pixmap (an_icon: EV_PIXMAP) is
			-- Assign `an_icon' to `icon'.
		require
			pixmap_not_void: an_icon /= void
		deferred
		ensure
			icon_pixmap_assigned: icon_pixmap.is_equal (an_icon)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TITLED_WINDOW

end -- class EV_TITLED_WINDOW_I

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
--| Revision 1.39  2000/05/03 00:27:40  pichery
--| Removed useless `icon_mask' feature
--|
--| Revision 1.38  2000/03/08 02:57:56  brendel
--| Commented out is_minimized postconditions.
--|
--| Revision 1.37  2000/03/07 01:36:49  brendel
--| Changed in compliance with interface.
--|
--| Revision 1.36  2000/03/07 00:28:51  brendel
--| Updated contracts from interface.
--| Cosmetics.
--|
--| Revision 1.35  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
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
