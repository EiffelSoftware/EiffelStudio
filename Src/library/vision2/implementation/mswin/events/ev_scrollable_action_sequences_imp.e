note
	description:
		"Action sequences for scrollable area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

class
	EV_SCROLLABLE_ACTION_SEQUENCES_IMP

inherit
	EV_SCROLLABLE_ACTION_SEQUENCE_I

feature -- Event handling

	create_horizontal_scroll_actions: EV_SCROLL_ACTION_SEQUENCE
			-- <Precursor>
		do
			create Result
		end

	create_vertical_scroll_actions: EV_SCROLL_ACTION_SEQUENCE
			-- <Precursor>
		do
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end


