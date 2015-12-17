note
	description: "General tooltip handler"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TOOLTIP_HANDLER

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Access

	tooltip: ES_SMART_TOOLTIP_WINDOW
			-- Tooktip window
		local
			l_tooltip_window: like tooltip
		do
			l_tooltip_window := tooltip_internal
			if l_tooltip_window = Void then
				create l_tooltip_window.make
				l_tooltip_window.set_hide_timeout (3_000)
				tooltip_internal := l_tooltip_window
			end
			Result := l_tooltip_window
		ensure
			Result_set: Result /= Void
		end

feature -- Events

	on_enter_editor_token (a_token: EDITOR_TOKEN)
			-- Propagte pointer move event.
		local
			l_timer: like show_tooltip_timer
			l_delay: like show_tooltip_interval
		do
			if show_tooltip_possible (a_token) then
				l_delay := show_tooltip_interval
				if l_delay > 0 then
					l_timer := show_tooltip_timer
					if l_timer = Void then
						create l_timer
						show_tooltip_timer := l_timer
					end
						-- The pointer context might have been changed.
						-- Reschedule displaying tooltip when the tooltip has not been shown
						-- in previous scheduler.
					l_timer.set_interval (0)
					l_timer.actions.wipe_out
					l_timer.actions.extend_kamikaze (agent verify_token_and_show_tooltip (a_token))
					l_timer.set_interval (l_delay)
					last_token := a_token
				else
					show_tooltip (a_token)
				end
			else
				stop_tooltip_timer
				hide_tooltip
			end
		end

	propagate_parent_move (x, y, width, height, a_old_x, a_old_y: INTEGER)
			-- Propagate move
			-- Arguments are positions from the parent window
		do
			if attached tooltip as l_tooltip and then l_tooltip.is_shown then
				l_tooltip.popup_window.set_position (l_tooltip.popup_window.screen_x + x - a_old_x, l_tooltip.popup_window.screen_y + y - a_old_y)
			end
		end

feature -- Action

	hide_tooltip
			-- Hide the tooltip
		do
			if attached tooltip as l_tooltip and then l_tooltip.is_shown then
				l_tooltip.hide
			end
			last_token := Void
		end

	hide_tooltip_pointer_off
			-- Hide the tooltip in a given time `a_timeout' if the mouse pointer is off.
		local
			l_timer: detachable EV_TIMEOUT
		do
			l_timer := hide_tooltip_timer
			if l_timer = Void then
				create l_timer
				hide_tooltip_timer := l_timer
			end
			l_timer.set_interval (0)
			l_timer.actions.wipe_out
			l_timer.actions.extend_kamikaze (agent do
				if not is_pointer_entered then
					hide_tooltip
				end
			end)
			l_timer.set_interval (hide_tooltip_timeout)
		end

	show_tooltip (a_token: EDITOR_TOKEN)
			-- Show tooltip
		require
			a_token: a_token /= Void
		deferred
		end

	setup_pointer_actions (a_widget: EV_WIDGET)
			-- Setup pointer enter leave actions for the tooltip
			-- Make sure `is_pointer_entered' is properly set.
		require
			widget_set: a_widget /= Void
		do
			a_widget.pointer_enter_actions.extend (agent do is_pointer_entered := True end)
			a_widget.pointer_leave_actions.extend (agent do is_pointer_entered := False end)
		end

feature -- Query

	show_tooltip_possible (a_token: detachable EDITOR_TOKEN): BOOLEAN
			-- Is it possible to show tooltip?
		do
			Result := True
		end

	is_pointer_entered: BOOLEAN
			-- Is pointer entered?

feature -- Status change

	set_show_position_callback (a_pos_c: like show_position_callback)
			-- Set `show_position_callback' with `a_pos_c'.
		do
			show_position_callback := a_pos_c
		ensure
			show_position_callback_set: show_position_callback = a_pos_c
		end

feature {NONE} -- Implementation

	stop_tooltip_timer
			-- Destroy the tooltip timer
		do
			if attached show_tooltip_timer as l_timer then
				l_timer.set_interval (0)
				l_timer.actions.wipe_out
			end
		end

	verify_token_and_show_tooltip (a_requested_token: EDITOR_TOKEN)
			-- Verify the token is still the one that was requested.
			-- It is possible that when the actual tooltip is ready to show, thw mouse
			-- cursor is already moved somewhere else.
		require
			a_requested_token_set: a_requested_token /= Void
		do
			if a_requested_token = last_token then
				show_tooltip (a_requested_token)
			end
		end

	show_tooltip_timer: detachable EV_TIMEOUT
			-- Timer to show tooltip

	hide_tooltip_timer: detachable EV_TIMEOUT
			-- Timer to hide the tooltip

	show_position_callback: detachable FUNCTION [INTEGER, INTEGER, detachable TUPLE [x, y: INTEGER]]
			-- Call back to query a preferred show position
			-- Arguments and return values are screen positions

	tooltip_internal: detachable ES_SMART_TOOLTIP_WINDOW
			-- Tooltip window

	last_token: detachable EDITOR_TOKEN
			-- Last token on which the tooltip is ready to show.

	show_tooltip_interval: INTEGER
			-- Wait a bit to show the tooltip
		do
			Result := preferences.debug_tool_data.show_debug_tooltip_delay
		end

	hide_tooltip_timeout: INTEGER = 200
			-- Timeout to wait pointer move onto the tooltip (ms).

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
