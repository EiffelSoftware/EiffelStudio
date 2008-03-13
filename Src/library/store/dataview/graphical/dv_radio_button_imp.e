indexing
	description: "Dummy implementation for DV_RADIO_BUTTON for type checking purposes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_RADIO_BUTTON_IMP

inherit
	DV_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_RADIO_BUTTON_IMP
		redefine
			interface, radio_group
		end

create
	make

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: DV_RADIO_BUTTON

feature {EV_ANY_I} -- Implementation

	radio_group: LINKED_LIST [EV_RADIO_BUTTON_IMP];
			-- <Precursor>

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DV_RADIO_BUTTON_IMP
