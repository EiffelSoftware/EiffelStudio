note
	description: "Object that represents a tooltip window"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GENERAL_TOOLTIP_WINDOW

inherit
	EV_POPUP_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

	EVS_GENERAL_TOOLTIP_UTILITY
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Create current tooltip window
		do
			make_with_shadow
		end

	initialize
			-- Initialize current tooltip window
		do
			disable_border
			disable_user_resize
			disconnect_from_window_manager
			key_release_actions.extend (agent on_key_release)
			Precursor
		end

feature -- Show

	show_tooltip (pointer_x, pointer_y: INTEGER)
			-- Show tooltip window at position relative to pointer position (pointer_x, pointer_y)
		require
			has_owner: has_owner
		local
			l_pos: EV_COORDINATE
		do
			if attached owner as o then
				set_size (o.required_tooltip_width, o.required_tooltip_height)
				l_pos := tooltip_left_top_position (o, pointer_x, pointer_y)
				set_position (l_pos.x, l_pos.y)
				safe_register_agent (pointer_motion_agent, ev_application.pointer_motion_actions)

				show
			else
				check has_owner: False end
			end
		end

	hide_tooltip
			-- Hide tooltip
		do
			if is_displayed then
				safe_remove_agent (pointer_motion_agent, ev_application.pointer_motion_actions)
				hide
			end
		end

feature -- Status report

	has_owner: BOOLEAN
			-- Does current has an owner?
		do
			Result := owner /= Void
		ensure
			good_result: (Result implies owner /= Void) and (not Result implies owner = Void)
		end

feature -- Owner operation

	attach_owner (a_owner: attached like owner)
			-- Attach `a_owner' to `owner'.
		require
			a_owner_attached: a_owner /= Void
		do
				-- We detach `owner' first, if any
			if has_owner then
				detach_owner
			end
			owner := a_owner
			if not is_empty then
				wipe_out
			end
			extend (a_owner.tooltip_widget)
			timer.set_interval (owner_destroy_checking_internal)
		ensure
			owner_attached: has_owner
			owner_set: owner = a_owner
			widget_extended: has (a_owner.tooltip_widget)
		end

	detach_owner
			-- Detach `owner'.
		require
			owner_attached: owner /= Void
		do
			if attached owner as o then
				o.setup_timer (0, Void)
				safe_remove_agent (pointer_motion_agent, ev_application.pointer_motion_actions)

				o.set_pointer_on_tooltip (False)
				o.set_picking_from_tooltip (False)
				o.set_is_pointer_on_tooltip (False)
				o.set_is_tooltip_pined (False)
			else
				check has_owner: False end
				safe_remove_agent (pointer_motion_agent, ev_application.pointer_motion_actions)
			end
			timer.set_interval (0)
			owner := Void
		ensure
			owner_detached: not has_owner
		end

feature {NONE} -- Actions

	owner_destroyed_checker
			-- Action to be performed when `owner' is destroyed.
		require
			has_owner: has_owner
		do
			if attached owner as o and then o.is_owner_destroyed then
				detach_owner
				if is_displayed then
					hide
				end
			end
		ensure
			current_hidden: (attached owner as en_owner and then en_owner.is_owner_destroyed) implies not is_displayed
		end

	on_pointer_motion (a_widget: EV_WIDGET; x, y: INTEGER)
			-- Action to be performed when pointer moves
		do
			if attached owner as o then
				if has_recursive (a_widget) then
					o.set_pointer_on_tooltip (True)
				else
					o.set_pointer_on_tooltip (False)
				end
			end
		end

feature {NONE} -- Measure

	actual_tooltip_window_width (a_owner: attached like owner): INTEGER
			-- Actual width in pixel of tooltip window
		require
			a_owner_attached: a_owner /= Void
		local
			l_required_width: INTEGER
			l_max_width: INTEGER
		do
			l_required_width := a_owner.required_tooltip_width
			l_max_width := a_owner.max_tooltip_width
			if l_max_width > 0 and l_required_width > l_max_width then
				Result := l_max_width
			else
				Result := l_required_width
			end
		ensure
			result_non_negative: Result >= 0
		end

	actual_tooltip_window_height (a_owner: attached like owner): INTEGER
			-- Actual height in pixel of tooltip window
		require
			a_owner_attached: a_owner /= Void
		local
			l_required_height,
			l_max_height: INTEGER
		do
			l_required_height := a_owner.required_tooltip_height
			l_max_height := a_owner.max_tooltip_height
			if l_max_height > 0 and l_required_height > l_max_height then
				Result := l_max_height
			else
				Result := l_required_height
			end
		ensure
			result_non_negative: Result >= 0
		end

	tooltip_left_top_position (a_owner: attached like owner; pointer_x, pointer_y: INTEGER): EV_COORDINATE
			-- Coordinate of left-top position of current tooltip window
			-- relative to pointer position (pointer_x, pointer_y)
			-- Returned value guarantees that whole tooltip is visiable in screen.
		require
			a_owner_attached: a_owner /= Void
		local
			l_start_x, l_start_y: INTEGER
			l_end_x, l_end_y: INTEGER
			l_width, l_height: INTEGER
			vw: INTEGER
		do
			l_width := actual_tooltip_window_width (a_owner)
			l_height := actual_tooltip_window_height (a_owner)
			set_width (l_width)
			set_height (l_height)
			l_start_x := pointer_x
			l_start_y := pointer_y + a_owner.pointer_offset
			l_end_x := l_start_x + l_width - 1
			l_end_y := l_start_y + l_height - 1
			if l_end_y > screen.implementation.virtual_height then
				l_end_y := pointer_y - a_owner.pointer_offset
				l_start_y := l_end_y - l_height + 1
			end
			vw := screen.implementation.virtual_width
			if l_end_x > vw then
				l_end_x := vw - 2
				l_start_x := l_end_x - l_width + 1
			end
			create Result.make (l_start_x, l_start_y)
		ensure
			result_attached: Result /= Void
		end

feature -- Owner

	owner: detachable EVS_GENERAL_TOOLTIPABLE
			-- owner of current tooltip window

feature{NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Redefined to True since we are changing the default state by redefining `initialize'.
		do
			Result := True
		end

	timer: EV_TIMEOUT
			-- Timer used to simulate tooltip delay time
		local
			t: like timer_internal
		do
			t := timer_internal
			if t = Void then
				create t
				t.actions.extend (agent owner_destroyed_checker)
				timer_internal := t
			end
			Result := t
		ensure
			result_attached: Result /= Void
		end

	timer_internal: detachable EV_TIMEOUT
			-- Internal timer used to simulate tooltip delay time

	pointer_motion_agent_internal: detachable like pointer_motion_agent
			-- Internal `pointer_motion_agent'

	owner_destroy_checking_internal: INTEGER = 100
			-- Time interval (in milliseconds) to check if `owner' is destroyed

	pointer_motion_agent: PROCEDURE [EV_WIDGET, INTEGER, INTEGER]
			-- Wrapper of `on_pointer_motion'
		local
			agt: like pointer_motion_agent_internal
		do
			agt := pointer_motion_agent_internal
			if agt = Void then
				agt := agent on_pointer_motion
				pointer_motion_agent_internal := agt
			end
			Result := agt
		ensure
			result_attached: Result /= Void
		end

	on_key_release (a_key: EV_KEY)
			-- Handle key release action
		do
			if a_key.code = {EV_KEY_CONSTANTS}.Key_escape then
				hide_tooltip
			end
		end
note
        copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
        license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
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
