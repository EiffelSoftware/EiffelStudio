note
	description:
		"Action sequences for EV_COMBO_BOX_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "$Date"
	revision: "$Revision"

deferred class
	 EV_COMBO_BOX_ACTION_SEQUENCES_I


feature -- Event handling

	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when drop down list is displayed.
		do
			if attached drop_down_actions_internal as l_result then
				Result := l_result
			else
				create Result
				drop_down_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	drop_down_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `drop_down_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	list_hidden_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when drop down list is hidden.
		do
			if attached list_hidden_actions_internal as l_result then
				Result := l_result
			else
				create Result
				list_hidden_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	list_hidden_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `list_hidden_actions'.
		note
			option: stable
		attribute
		end;

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




end











