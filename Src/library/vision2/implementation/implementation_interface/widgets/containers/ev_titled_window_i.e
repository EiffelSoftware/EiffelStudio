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

