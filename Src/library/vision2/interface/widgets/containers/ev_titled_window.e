indexing
	description: "Eiffel Vision titled window. Top level titled window."
	status: "See notice at end of class"
	keywords: "window, title bar, title"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_TITLED_WINDOW

inherit
	EV_WINDOW
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end

create
	default_create

feature  -- Access

	accelerators: ACTIVE_LIST [EV_ACCELERATOR]
			-- Key combination shortcuts associated with this window.
			--| FIXME The same key combination can be added to this list.
			--| GTK takes only the latest one set. Object-comparison is turned on
			--| for this list, so that the user can check whether a specific
			--| accelerator is already installed using `has'.

	icon_name: STRING is
			-- Alternative name, displayed when window is minimised.
		do
			Result := implementation.icon_name
		ensure
			bridge_ok: Result.is_equal (implementation.icon_name)
		end 

	icon_pixmap: EV_PIXMAP is
			-- Window icon.
		do
			Result := implementation.icon_pixmap
		ensure
			bridge_ok: Result.is_equal (implementation.icon_pixmap)
		end
	
	icon_mask: EV_PIXMAP is
			-- Transparency mask for `icon_pixmap'.
		do
			Result := implementation.icon_mask
		ensure
			valid_result: Result.is_equal (implementation.icon_mask)
		end

feature -- Status report

	is_minimized: BOOLEAN is
			-- Is displayed iconified/minimised?
		require
		do
			Result := implementation.is_minimized
		ensure
			bridge_ok: Result = implementation.is_minimized
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
		require
		do
			Result := implementation.is_maximized
		ensure
			bridge_ok: Result = implementation.is_maximized
		end

feature -- Status setting

	raise is
			-- Request that window be displayed above all other windows.
		do
			implementation.raise
		end

	lower is
			-- Request that window be displayed below all other windows.
		do
			implementation.lower
		end

	minimize is
			-- Display iconified/minimised.
		do
			implementation.minimize
		ensure
			is_minimized: is_minimized
		end

	maximize is
			-- Display at maximum size.
		do
			implementation.maximize
		ensure
			is_maximized: is_maximized
		end

	restore is
			-- Restore to original position when minimized or maximized.
		do
			implementation.restore
		ensure
			minimize_restored: old is_minimized implies not is_minimized
			maximize_restored: old is_maximized implies not is_maximized
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING) is
			-- Assign `an_icon_name' to `icon_name'.
		require
			an_icon_name_not_void: an_icon_name /= Void
		do
			implementation.set_icon_name (an_icon_name)
		ensure
			icon_name_assigned: icon_name.is_equal (an_icon_name)
		end

	set_icon_mask (an_icon_mask: EV_PIXMAP) is
			-- Assign `an_icon_mask' to `icon_mask'.
		require
			pixmap_not_void: an_icon_mask /= Void
		do
			implementation.set_icon_mask (an_icon_mask)
		ensure
			icon_mask_assigned: icon_mask.is_equal (an_icon_mask)
		end

	set_icon_pixmap (an_icon: EV_PIXMAP) is
			-- Assign `an_icon' to `icon'.
		require
			pixmap_not_void: an_icon /= void
		do
			implementation.set_icon_pixmap (an_icon)
		ensure
			icon_pixmap_assigned: icon_pixmap.is_equal (an_icon)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TITLED_WINDOW_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of window with a title
		do   
			create {EV_TITLED_WINDOW_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create action sequences.
		do   
			Precursor
			create accelerators
			accelerators.compare_objects
			accelerators.add_actions.extend (implementation~connect_accelerator)
			accelerators.remove_actions.extend (implementation~disconnect_accelerator)
		end

invariant
	accelerators_not_void: accelerators /= Void
		
end -- class EV_TITLED_WINDOW

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.7  2000/02/04 01:01:38  brendel
--| Changed export status of Implementation.
--|
--| Revision 1.1.2.6  2000/02/03 22:54:42  brendel
--| Changed export status of Implementation.
--|
--| Revision 1.1.2.5  2000/01/28 20:00:14  oconnor
--| released
--|
--| Revision 1.1.2.4  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  2000/01/25 22:15:53  brendel
--| Connection to accelerators (ACTIVE_LIST) now takes place here.
--|
--| Revision 1.1.2.2  2000/01/25 16:56:34  brendel
--| Added accelerators of type ACTIVE_LIST (cluster: event).
--|
--| Revision 1.1.2.1  2000/01/24 23:16:09  oconnor
--| Moved content of ev_window.e into ev_titled_window.e
--| Moved content of ev_untitled_window.e into ev_window.e
--| Removed ev_untitled_window.e
--|
--| Revision 1.41.2.1.2.4  2000/01/15 01:34:08  oconnor
--| fixed comments, contracts and layout
--|
--| Revision 1.41.2.1.2.3  1999/12/16 09:22:33  oconnor
--| removed make_root
--|
--| Revision 1.41.2.1.2.2  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.41.2.1.2.1  1999/11/24 00:20:24  oconnor
--| merged from  REVIEW_BRANCH_19991006
--|
--| Revision 1.40.2.6  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.40.2.5  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
