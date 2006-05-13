indexing
	description: "Object that represents a tooltip window"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GENERAL_TOOLTIP_WINDOW

inherit
	EV_UNTITLED_DIALOG
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

feature{NONE} -- Initialization

	initialize is
			-- Initialize current tooltip window
		do
			disable_border
			disable_user_resize
			Precursor
		end

feature -- Show

	show_tooltip (pointer_x, pointer_y: INTEGER) is
			-- Show tooltip window at position relative to pointer position (pointer_x, pointer_y)
		require
			has_owner: has_owner
		local
			l_pos: EV_COORDINATE
		do
			set_size (owner.required_tooltip_width, owner.required_tooltip_height)
			l_pos := tooltip_left_top_position (pointer_x, pointer_y)
			set_position (l_pos.x, l_pos.y)
			safe_register_agent (pointer_motion_agent, ev_application.pointer_motion_actions)
			if related_window /= Void then
					-- With `related_window' set, we can ensure that displayed tooltip is always visiable.
				show_relative_to_window (related_window)
			else
					-- Without `related_window' set, displayed tooltip maybe invisiable after current application loses focus.
				show
			end
		end

	hide_tooltip is
			-- Hide tooltip
		do
			if is_displayed then
				safe_remove_agent (pointer_motion_agent, ev_application.pointer_motion_actions)
				hide
			end
		end

feature -- Status report

	has_owner: BOOLEAN is
			-- Does current has an owner?
		do
			Result := owner /= Void
		ensure
			good_result: (Result implies owner /= Void) and (not Result implies owner = Void)
		end

feature -- Owner operation

	attach_owner (a_owner: like owner) is
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
			extend (owner.tooltip_widget)
			timer.set_interval (owner_destroy_checking_internal)
		ensure
			owner_attached: has_owner
			widget_extended: has (owner.tooltip_widget)
		end

	detach_owner is
			-- Detach `owner'.
		require
			owner_attached: owner /= Void
		do
			owner.setup_timer (0, Void)
			safe_remove_agent (pointer_motion_agent, ev_application.pointer_motion_actions)
			owner.set_pointer_on_tooltip (False)
			owner.set_picking_from_tooltip (False)
			owner.set_is_pointer_on_tooltip (False)
			owner.set_is_tooltip_pined (False)
			timer.set_interval (0)
			owner := Void
		ensure
			owner_detached: not has_owner
		end

feature{NONE} -- Actions

	owner_destroyed_checker is
			-- Action to be performed when `owner' is destroyed.
		require
			has_owner: has_owner
		do
			if owner.is_owner_destroyed then
				detach_owner
				if is_displayed then
					hide
				end
			end
		ensure
			current_hidden: owner.is_owner_destroyed implies not is_displayed
		end

	on_pointer_motion (a_widget: EV_WIDGET; x, y: INTEGER) is
			-- Action to be performed when pointer moves
		do
			if has_recursive (a_widget) then
				owner.set_pointer_on_tooltip (True)
			else
				owner.set_pointer_on_tooltip (False)
			end
		end

feature{NONE} -- Measure

	actual_tooltip_window_width: INTEGER is
			-- Actual width in pixel of tooltip window
		local
			l_required_width: INTEGER
			l_max_width: INTEGER
		do
			l_required_width := owner.required_tooltip_width
			l_max_width := owner.max_tooltip_width
			if l_max_width > 0 and l_required_width > l_max_width then
				Result := l_max_width
			else
				Result := l_required_width
			end
		ensure
			result_non_negative: Result >= 0
		end

	actual_tooltip_window_height: INTEGER is
			-- Actual height in pixel of tooltip window
		local
			l_required_height,
			l_max_height: INTEGER
		do
			l_required_height := owner.required_tooltip_height
			l_max_height := owner.max_tooltip_height
			if l_max_height > 0 and l_required_height > l_max_height then
				Result := l_max_height
			else
				Result := l_required_height
			end
		ensure
			result_non_negative: Result >= 0
		end

	tooltip_left_top_position (pointer_x, pointer_y: INTEGER): EV_COORDINATE is
			-- Coordinate of left-top position of current tooltip window
			-- relative to pointer position (pointer_x, pointer_y)
			-- Returned value guarantees that whole tooltip is visiable in screen.
		local
			l_start_x, l_start_y: INTEGER
			l_end_x, l_end_y: INTEGER
			l_width, l_height: INTEGER
		do
			l_width := actual_tooltip_window_width
			l_height := actual_tooltip_window_height
			set_width (l_width)
			set_height (l_height)
			l_start_x := pointer_x
			l_start_y := pointer_y + owner.pointer_offset
			l_end_x := l_start_x + l_width - 1
			l_end_y := l_start_y + l_height - 1
			if l_end_y > screen.height then
				l_end_y := pointer_y - owner.pointer_offset
				l_start_y := l_end_y - l_width + 1
			end
			if l_end_x > screen.width then
				l_end_x := screen.width - 2
				l_start_x := l_end_x - l_width + 1
			end
			create Result.make (l_start_x, l_start_y)
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_related_window (a_window: EV_WINDOW) is
			-- Set `related_window' with `a_window'.
		require
			a_window_attached: a_window /= Void
			a_window_not_destroyed: not a_window.is_destroyed
		do
			related_window := a_window
		ensure
			related_window_set: related_window = a_window
		end

feature -- Owner

	owner: EVS_GENERAL_TOOLTIPABLE
			-- owner of current tooltip window

	related_window: EV_WINDOW
			-- Related window used to display tooltip
			-- It isn't necessory, but with it, we can ensure that a displayed tooltip is always visiable.

feature{NONE} -- Implementation

	is_in_default_state: BOOLEAN is
		do
			Result := True
		end

	timer: EV_TIMEOUT is
			-- Timer used to simulate tooltip delay time
		do
			if timer_internal = Void then
				create timer_internal
				timer_internal.actions.extend (agent owner_destroyed_checker)
			end
			Result := timer_internal
		ensure
			result_attached: Result /= Void
		end

	timer_internal: EV_TIMEOUT
			-- Internal timer used to simulate tooltip delay time

	pointer_motion_agent_internal: like pointer_motion_agent
			-- Internal `pointer_motion_agent'

	owner_destroy_checking_internal: INTEGER is 100
			-- Time interval (in milliseconds) to check if `owner' is destroyed

	pointer_motion_agent: PROCEDURE [ANY, TUPLE [EV_WIDGET, INTEGER, INTEGER]] is
			-- Wrapper of `on_pointer_motion'
		do
			if pointer_motion_agent_internal = Void then
				pointer_motion_agent_internal := agent on_pointer_motion
			end
			Result := pointer_motion_agent_internal
		ensure
			result_attached: Result /= Void
		end

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
