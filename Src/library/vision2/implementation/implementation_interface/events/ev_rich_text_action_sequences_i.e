note
	description:
		"Action sequences for EV_RICH_TEXT_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	 EV_RICH_TEXT_ACTION_SEQUENCES_I

feature -- Event handling

	caret_move_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Actions to be performed when caret position changes.
		do
			if attached caret_move_actions_internal as l_result then
				Result := l_result
			else
				create Result
				caret_move_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when selection changes.
		do
			if attached selection_change_actions_internal as l_result then
				Result := l_result
			else
				create Result
				selection_change_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	file_access_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Actions to be performed while loading or saving.
			-- Event data is percentage of file written (0-100).
		do
			if attached file_access_actions_internal as l_result then
				Result := l_result
			else
				create Result
				file_access_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	caret_move_actions_internal: detachable EV_INTEGER_ACTION_SEQUENCE
			-- Implementation of once per object `caret_move_actions'.
		note
			option: stable
		attribute
		end

	selection_change_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `selection_change_actions'.
		note
			option: stable
		attribute
		end

feature {EV_ANY_I, EV_RICH_TEXT_BUFFERING_STRUCTURES_I}

	file_access_actions_internal: detachable EV_INTEGER_ACTION_SEQUENCE
			-- Implementation of once per object `file_access_actions'.
		note
			option: stable
		attribute
		end;

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










