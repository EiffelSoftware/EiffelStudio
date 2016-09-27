note
	description: "Actions used by scrollable widget"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	EV_SCROLLABLE_ACTION_SEQUENCES_I

feature -- Event handling

	vertical_scroll_action: EV_SCROLL_ACTION_SEQUENCE
			-- Vertical bar scroll action
		do
			if attached vertical_scroll_actions_internal as l_result then
				Result := l_result
			else
				create Result
				vertical_scroll_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	horizontal_scroll_action: EV_SCROLL_ACTION_SEQUENCE
			-- Horizontal bar scroll action
		do
			if attached horizontal_scroll_actions_internal as l_result then
				Result := l_result
			else
				create Result
				horizontal_scroll_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	vertical_scroll_actions_internal: detachable EV_SCROLL_ACTION_SEQUENCE
			-- Vertical bar scroll action
		note
			option: stable
		attribute
		end

	horizontal_scroll_actions_internal: detachable EV_SCROLL_ACTION_SEQUENCE
			-- Horizontal bar scroll action
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


