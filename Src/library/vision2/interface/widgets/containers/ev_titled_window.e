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
			initialize
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize is
   			-- Mark `Current' as initialized.
   			-- This must be called during the creation procedure
   			-- to satisfy the `is_initialized' invariant.
   			-- Descendants may redefine initialize to perform
   			-- additional setup tasks.
		do
			set_icon_pixmap (default_pixmaps.Default_window_icon)
			accelerators.add_actions.extend
				(implementation~connect_accelerator (?))
			accelerators.remove_actions.extend
				(implementation~disconnect_accelerator (?))
			Precursor {EV_WINDOW}
		end


feature -- Access

	accelerators: EV_ACCELERATOR_LIST is
			-- Key combination shortcuts associated with this window.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.accelerator_list
		end

	icon_name: STRING is
			-- Alternative name, displayed when window is minimised.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.icon_name
		ensure
			bridge_ok: equal (Result, implementation.icon_name)
		end 

	icon_pixmap: EV_PIXMAP is
			-- Window icon.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.icon_pixmap
		ensure
			bridge_ok: Result.is_equal (implementation.icon_pixmap)
		end
	
feature -- Status report

	is_minimized: BOOLEAN is
			-- Is displayed iconified/minimised?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_minimized
		ensure
			bridge_ok: Result = implementation.is_minimized
		end

	is_maximized: BOOLEAN is
			-- Is displayed at maximum size?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_maximized
		ensure
			bridge_ok: Result = implementation.is_maximized
		end

feature -- Status setting

	raise is
			-- Request that window be displayed above all other windows.
		require
			not_destroyed: not is_destroyed
		do
			implementation.raise
		end

	lower is
			-- Request that window be displayed below all other windows.
		require
			not_destroyed: not is_destroyed
		do
			implementation.lower
		end

	minimize is
			-- Display iconified/minimised.
			-- It is not possible to guarantee this on some
			-- platform configurations.
		require
			not_destroyed: not is_destroyed
		do
			implementation.minimize
		end

	maximize is
			-- Display at maximum size.
		require
			not_destroyed: not is_destroyed
		do
			implementation.maximize
		ensure
			is_maximized: is_maximized
		end

	restore is
			-- Restore to original position when minimized or maximized.
		require
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
			an_icon_name_not_void: an_icon_name /= Void
			an_icon_name_not_empty: not an_icon_name.is_empty
		do
			implementation.set_icon_name (an_icon_name)
		ensure
			icon_name_assigned: icon_name.is_equal (an_icon_name)
		end

	remove_icon_name is
			-- Make `icon_name' `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_icon_name
		ensure
			icon_name_removed: icon_name = Void
		end
		

	set_icon_pixmap (an_icon: EV_PIXMAP) is
			-- Assign `an_icon' to `icon'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: an_icon /= void
		do
			implementation.set_icon_pixmap (an_icon)
		ensure
			icon_pixmap_assigned: icon_pixmap.is_equal (an_icon)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TITLED_WINDOW_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Responsible for interaction with native graphics toolkit.
		do   
			create {EV_TITLED_WINDOW_IMP} implementation.make (Current)
		end

invariant
	accelerators_not_void: is_usable implies accelerators /= Void
		
end -- class EV_TITLED_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

