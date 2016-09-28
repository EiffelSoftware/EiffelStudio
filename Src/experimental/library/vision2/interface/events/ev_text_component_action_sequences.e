note
	description:
		"Action sequences for EV_TEXT_COMPONENT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_COMPONENT_ACTION_SEQUENCES

inherit
	EV_ACTION_SEQUENCES

feature {NONE} -- Implementation

	implementation: EV_TEXT_COMPONENT_ACTION_SEQUENCES_I
		deferred
		end

feature -- Event handling

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `text' changes.
		do
			Result := implementation.change_actions
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

