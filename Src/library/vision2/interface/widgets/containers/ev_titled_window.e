indexing
	description:
		"Top level titled window. Contains a single widget."
	appearance:
		" __________________ %N%
		%|`title'       _[]X|%N%
		%|------------------|%N%
		%|                  |%N%
		%|      `item'      |%N%
		%|__________________|"
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
	default_create,
	make_with_title,
	make_for_test

feature -- Access

	--| FIXME Segmentation violation on both platforms when extending this
	--| list when calling rout_obj_call_procedure. Run-time bug?
	--Disabled pending investigation of possible compiler bug.
	--accelerators: ACTIVE_LIST [EV_ACCELERATOR]
			-- Key combination shortcuts associated with this window.
		--| FIXME The same key combination can be added to this list.
		--| GTK takes only the latest one set. Object-comparison is turned on
		--| for this list, so that the user can check whether a specific
		--| accelerator is already installed using `has'.

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Associate `an_accel' with this window.
			-- May be replaced by ACTIVE_LIST [EV_ACCELERATOR].
		do
			implementation.connect_accelerator (an_accel)
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Remove `an_accel' from this window.
			-- May be replaced by ACTIVE_LIST [EV_ACCELERATOR].
		do
			implementation.disconnect_accelerator (an_accel)
		end

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
		do
			Result := implementation.is_minimized
		ensure
			bridge_ok: Result = implementation.is_minimized
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
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
			--| FIXME VB probably impossible for GTK.
			--| is_minimized: is_minimized
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
			--| FIXME VB probably impossible for GTK.
			--| minimize_restored: old is_minimized implies not is_minimized
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
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Responsible for interaction with the native graphics toolkit.
		do   
			create {EV_TITLED_WINDOW_IMP} implementation.make (Current)
		end

	create_action_sequences is
				-- See `{EV_ANY}.create_action_sequences'.
		do   
			Precursor
		--| FIXME See top.
		--|	create accelerators
		--|	accelerators.compare_objects
		--|	accelerators.add_actions.extend (implementation~connect_accelerator (?))
		--|	accelerators.remove_actions.extend
		--|		(implementation~disconnect_accelerator (?))
		end

--|invariant
--|	accelerators_not_void: accelerators /= Void
		
end -- class EV_TITLED_WINDOW

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
--| Revision 1.14  2000/03/21 23:06:11  brendel
--| Added creation procedure make_with_title.
--|
--| Revision 1.13  2000/03/21 22:10:39  oconnor
--| added comment
--|
--| Revision 1.12  2000/03/21 20:11:03  brendel
--| Commented out accelerators (ACTIVE_LIST [EV_ACCELERATOR]) in favor of
--| `connect_accelerator' and `disconnect_accelerator', until the bug has been
--| fixed. See comments for details.
--|
--| Revision 1.11  2000/03/21 02:25:27  brendel
--| ACTIVE_LIST is not used anymore.
--| Replaced by 2 features.
--|
--| Revision 1.10  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.9  2000/03/08 02:57:04  brendel
--| Commented out postconditions regarding is_minimized, because GTK window
--| is not actually minimized until the end of the event.
--|
--| Revision 1.8  2000/03/08 02:30:21  brendel
--| Fully implemented is_minimized, is_maximized, maximize, minimize, restore.
--|
--| Revision 1.7  2000/03/07 01:35:37  brendel
--| Cosmetics
--|
--| Revision 1.6  2000/03/01 20:07:36  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.5  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.4  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.3  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
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
