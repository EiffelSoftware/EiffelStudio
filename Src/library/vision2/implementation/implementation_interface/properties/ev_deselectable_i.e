note
	description:
		"Eiffel Vision deselectable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "deselect, deselectable, selectable, select"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DESELECTABLE_I

inherit
	EV_SELECTABLE_I
		redefine
			interface
		end

feature -- Status setting

	toggle
			-- Change `is_selected'.
		require
			not_is_destroyed: not is_destroyed
			can_be_selected: not is_selected implies is_selectable
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		end

	disable_select
			-- Deselect the object.
		require
			is_selectable: is_selectable
		deferred
		ensure
			deselected: not is_selected
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DESELECTABLE note option: stable attribute end;
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




end -- class EV_DESELECTABLE_I









