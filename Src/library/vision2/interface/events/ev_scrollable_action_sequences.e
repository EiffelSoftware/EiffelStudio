note
	description: "Actions used by scrollable widget"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	EV_SCROLLABLE_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_SCROLLABLE_ACTION_SEQUENCE_I

feature -- Event handling

	vertical_scroll_action: EV_SCROLL_ACTION_SEQUENCE
			-- Vertical bar scroll action
		do
			Result := implementation.vertical_scroll_action
		ensure
			not_void: Result /= Void
		end

	horizontal_scroll_action: EV_SCROLL_ACTION_SEQUENCE
			-- Horizontal bar scroll action
		do
			Result := implementation.horizontal_scroll_action
		ensure
			not_void: Result /= Void
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


