note
	description:
		"Action sequences for EV_TOOL_BAR_BUTTON_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_I

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when button is pressed then released.
		do
			if attached select_actions_internal as l_result then
				Result := l_result
			else
				create Result
				init_select_actions (Result)
				select_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when drop down button is pressed.
		do
			if attached drop_down_actions_internal as l_result then
				Result := l_result
			else
				create Result
				drop_down_actions_internal := Result
			end
		end

feature {EV_ANY_I} -- Implementation

	select_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE note option: stable attribute end
			-- Implementation of once per object `select_actions'.

	init_select_actions (a_select_actions: like select_actions)
			-- Initialize `a_select_actions' accordingly to the current widget.
		do
		end

	drop_down_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE note option: stable attribute end;
			-- Implementation of once per object `drop_down_acions'.

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








