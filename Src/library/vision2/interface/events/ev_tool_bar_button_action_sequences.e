note
	description:
		"Action sequences for EV_TOOL_BAR_BUTTON."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES

inherit
	EV_ACTION_SEQUENCES

feature {NONE} -- Implementation

	implementation: EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_I
		deferred
		end

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when button is pressed then released.
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Special event handling

	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when dropdown button is pressed.
		do
			Result := implementation.drop_down_actions
		ensure
			not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end

