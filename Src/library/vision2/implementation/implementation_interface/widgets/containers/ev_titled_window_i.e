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

	accelerator_list: EV_ACCELERATOR_LIST is
			-- Key combination shortcuts associated with this window.
		do
			if accelerators_internal = Void then
				create accelerators_internal
				accelerators_internal.compare_objects
			end
			Result := accelerators_internal
		end

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

	remove_icon_name is
			-- make `icon_name' `void'
		do
			set_icon_name ("")
		end

	set_icon_pixmap (an_icon: EV_PIXMAP) is
			-- Assign `an_icon' to `icon'.
		require
			pixmap_not_void: an_icon /= void
		deferred
		ensure
			icon_pixmap_assigned: icon_pixmap.is_equal (an_icon)
		end

feature {EV_WIDGET_I} -- Implementation

	help_enabled: BOOLEAN
			-- Are accelerators `EV_APPLICATION.Help_accelerator' and `EV_APPLICATION.Contextual_help_accelerator' connected?

	enable_help is
			-- Connect accelerators `EV_APPLICATION.Help_accelerator' and `EV_APPLICATION.Contextual_help_accelerator'.
		require
			help_disabled: not help_enabled
		do
			connect_accelerator (Environment.Application.Help_accelerator)
			connect_accelerator (Environment.Application.Contextual_help_accelerator)
			help_enabled := True
		ensure
			help_enabled: help_enabled
		end

feature {EV_ANY_I} -- Implementation

	accelerators_internal: EV_ACCELERATOR_LIST

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.4  2000/12/14 17:20:06  rogers
--| Added remove_icon_name.
--|
--| Revision 1.1.2.3  2000/10/11 20:57:02  raphaels
--| Optimized `enable_help'.
--|
--| Revision 1.1.2.2  2000/10/11 20:50:00  raphaels
--| Added `help_enabled' and `enable_help'.
--|
--| Revision 1.1.2.1  2000/10/09 21:33:52  oconnor
--| Renamed ev_window_i.e to ev_titled_window_i.e
--| Renamed ev_untitled_window_i.e to ev_window_i.e
--|
--| Revision 1.33.4.3  2000/08/16 20:15:33  rogers
--| renamed accelerators to accelerator_list.
--|
--| Revision 1.33.4.2  2000/08/16 19:52:56  king
--| Added accelerators implementation
--|
--| Revision 1.33.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
