note
	description:
		"Eiffel Vision titled window. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TITLED_WINDOW_I

inherit
	EV_WINDOW_I
		redefine
			interface
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_I

feature -- Access

	icon_name: STRING_32
			-- Alternative name, displayed when window is minimised.
		deferred
		end

	icon_pixmap: EV_PIXMAP
			-- Window icon.
		deferred
		end

feature -- Status report

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?
		deferred
		end

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?
		deferred
		end

feature -- Status setting

	raise
			-- Request that window be displayed above all other windows.
		deferred
		end

	lower
			-- Request that window be displayed below all other windows.
		deferred
		end

	minimize
			-- Display iconified/minimised.
		deferred
		ensure
			--| FIXME VB probably impossible for GTK.
			--| is_minimized: is_minimized
		end

	maximize
			-- Display at maximum size.
		deferred
		ensure
			is_maximized: is_maximized
		end

	restore
			-- Restore to original position when minimized or maximized.
		deferred
		ensure
			--| FIXME VB probably impossible for GTK.
			--| minimize_restored: old is_minimized implies not is_minimized
			maximize_restored: old is_maximized implies not is_maximized
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING_GENERAL)
			-- Assign `an_icon_name' to `icon_name'.
		require
			an_icon_name_not_void: an_icon_name /= Void
		deferred
		ensure
			icon_name_assigned: icon_name.is_equal (an_icon_name)
		end

	set_icon_pixmap (an_icon: EV_PIXMAP)
			-- Assign `an_icon' to `icon'.
		require
			pixmap_not_void: an_icon /= Void
		deferred
		ensure
			icon_pixmap_assigned: icon_pixmap.is_equal (an_icon)
		end

feature {EV_WIDGET_I} -- Implementation

	help_enabled: BOOLEAN
			-- Are accelerators `EV_APPLICATION.Help_accelerator' and `EV_APPLICATION.Contextual_help_accelerator' connected?

	enable_help
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

	interface: EV_TITLED_WINDOW;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TITLED_WINDOW_I

