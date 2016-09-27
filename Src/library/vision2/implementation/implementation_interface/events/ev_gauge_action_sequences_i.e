note
	description:
		"Action sequences for EV_GAUGE_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_GAUGE_ACTION_SEQUENCES_I

feature -- Event handling

	change_actions: EV_VALUE_CHANGE_ACTION_SEQUENCE
			-- Actions to be performed when `value' changes.
		do
			if attached change_actions_internal as l_result then
				Result := l_result
			else
				create Result
				change_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	change_actions_internal: detachable EV_VALUE_CHANGE_ACTION_SEQUENCE
			-- Implementation of once per object `change_actions'.
		note
			option: stable
		attribute
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











