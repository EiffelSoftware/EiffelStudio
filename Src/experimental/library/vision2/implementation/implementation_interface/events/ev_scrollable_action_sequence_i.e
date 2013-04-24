note
	description: "Actions used by scrollable widget"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	EV_SCROLLABLE_ACTION_SEQUENCE_I

feature -- Event handling

	vertical_scroll_action: EV_SCROLL_ACTION_SEQUENCE
			-- Vertical bar scroll action
		do
			if vertical_scroll_actions_internal = Void then
				vertical_scroll_actions_internal :=
					 create_vertical_scroll_actions
			end
			Result := vertical_scroll_actions_internal
		ensure
			not_void: Result /= Void
		end

	horizontal_scroll_action: EV_SCROLL_ACTION_SEQUENCE
			-- Horizontal bar scroll action
		do
			if horizontal_scroll_actions_internal = Void then
				horizontal_scroll_actions_internal :=
					 create_horizontal_scroll_actions
			end
			Result := horizontal_scroll_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_horizontal_scroll_actions: EV_SCROLL_ACTION_SEQUENCE
			-- Create a horizontal scroll action sequence.
		deferred
		end

	create_vertical_scroll_actions: EV_SCROLL_ACTION_SEQUENCE
			-- Create a vertical scroll action sequence.
		deferred
		end

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


