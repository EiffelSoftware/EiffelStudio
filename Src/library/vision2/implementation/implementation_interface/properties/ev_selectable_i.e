note
	description:
		"Eiffel Vision selectable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "select, selectable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Status report

	is_selectable: BOOLEAN
			-- May the object be selected?
		do
			Result := True
		end

	is_selected: BOOLEAN
			-- Is objects state set to selected?
		deferred
		end

feature -- Status setting

	enable_select
			-- Select the object.
		require
			is_selectable: is_selectable
		deferred
		ensure
			selected: is_selected
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SELECTABLE note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

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




end -- class EV_SELECTABLE_I









