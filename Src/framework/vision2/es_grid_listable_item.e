note
	description: "A component displayed in a grid item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_LISTABLE_ITEM

inherit
	EVS_TEXT_ALIGNABLE

	EVS_BORDERED

	EVS_GRID_ITEM_HELPER
		export
			{NONE}all
		end

	ES_GRID_PICKABLE_ITEM

feature{NONE} -- Initialization

	initialize_item
			-- Initialize item.
		do
			on_pointer_button_pressed_agent := agent on_pointer_button_pressed
			on_pointer_double_press_agent := agent on_pointer_double_pressed
			on_pointer_move_agent := agent on_pointer_move
			on_pointer_leave_agent := agent on_pointer_leave
			enable_component_pebble
		end

feature -- Access

	component_padding: INTEGER
			-- Space in pixel between two components

	component_count: INTEGER
			-- Number of components attached to Current
		do
			Result := components.count
		ensure
			good_result: Result = components.count
		end

	component (a_index: INTEGER_32): like component_type
			-- Component in `components' at position indexed by 1-based `a_index'
		require
			a_index_valid: a_index >= 1 and a_index <= component_count
		do
			Result := components.i_th (a_index)
		ensure
			result_attached: Result /= Void
		end

	general_tooltip: EVS_GENERAL_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided cannot satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.

	veto_general_tooltip_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Agent to veto `general_tooltip' display
		do
			if veto_general_tooltip_function_internal = Void then
				veto_general_tooltip_function_internal := agent is_ponter_out_of_component
			end
			Result := veto_general_tooltip_function_internal
		ensure
			result_attached: Result /= Void
		end

	component_index_at_position (a_orignal_pointer_position: EV_COORDINATE): INTEGER
			-- 1-based Index component at `a_orignal_pointer_position'
			-- 0 if no such component is found.
		require
			not_void: a_orignal_pointer_position /= Void
		local
			l_coordinate: EV_COORDINATE
			l_pos: like component_position
			l_rec: EV_RECTANGLE
		do
			l_coordinate := relative_position (grid_item, a_orignal_pointer_position.x, a_orignal_pointer_position.y)
			Result := component_index_at_imp (l_coordinate)
		end

	component_index_at_pointer_position: INTEGER
			-- 1-based Index component at current pointer position
			-- 0 if no such component is found.
		local
			l_coordinate: EV_COORDINATE
			l_pos: like component_position
			l_rec: EV_RECTANGLE
		do
			l_coordinate := relative_pointer_position (grid_item)
			Result := component_index_at_imp (l_coordinate)
		end

	pick_component (i: INTEGER): ANY
			-- Try pick on the `i'-th component,
			-- return picked pebble.
		require
			i_valid: i > 0
		local
			l_coordinate: EV_COORDINATE
			l_item: like component_type
			l_rec: EV_RECTANGLE
		do
			if i <= component_position.count then
				l_coordinate := relative_pointer_position (grid_item)
				l_rec := component_position.i_th (i)
				if i <= component_count then
					l_item := component (i)
					l_item.on_pick (l_coordinate.x - l_rec.x, l_coordinate.y - l_rec.y)
					Result := l_item.last_pebble
				end
			end
		end

feature -- Status report

	is_pointer_in_component: BOOLEAN
			-- Is pointer in trailer for the moment?
			-- This query can be used to distinguish event source. For example,
			-- When both `pointer_double_press_actions' of Current grid item and
			-- `pointer_double_press_actions' of some trailer are invoked, this query will
			-- return True if the pointer is actually clicked on some trailer.

	is_component_pebble_enabled: BOOLEAN
			-- Does every item have its own pebble?
			-- Default: True

feature -- Setting

	set_component_padding (a_padding: INTEGER_32)
			-- Set `component_padding' with `a_padding'.
		do
			lock_update
			component_padding := a_padding
			unlock_update
			try_call_setting_change_actions
		ensure
			component_padding_set: component_padding = a_padding
		end

	set_general_tooltip (a_tooltip: like general_tooltip)
			-- Set `general_tooltip' with `a_tooltip' and enable it at the same time.
			-- Note: If `components' is not empty and pointer is over a component area, this tooltip won't be displayed.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := a_tooltip
			if not general_tooltip.veto_tooltip_display_functions.has (veto_general_tooltip_function) then
				general_tooltip.veto_tooltip_display_functions.extend (veto_general_tooltip_function)
			end
			general_tooltip.enable_tooltip
		ensure
			general_tooltip_set: general_tooltip = a_tooltip
		end

	remove_general_tooltip
			-- Remove `general_tooltip'.
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
				if general_tooltip.veto_tooltip_display_functions.has (veto_general_tooltip_function) then
					general_tooltip.veto_tooltip_display_functions.prune_all (veto_general_tooltip_function)
				end
			end
			general_tooltip := Void
		ensure
			general_tooltip_removed: general_tooltip = Void
		end

	enable_component_pebble
			-- Enable that every component can have its own pebble.
		do
			is_component_pebble_enabled := True
		ensure
			is_component_pebble_enabled: is_component_pebble_enabled
		end

	disable_component_pebble
			-- Disable that every component can have its own pebble.
		do
			is_component_pebble_enabled := False
		ensure
			is_component_pebble_disabled: not is_component_pebble_enabled
		end

	insert_component (a_component: like component_type; a_index: INTEGER_32)
			-- Insert `a_component' at 1-based position indexed by `a_index' in `components'.
		require
			a_component_valid: a_component /= Void and then not a_component.is_parented
			a_index_valid: a_index >= 1 and then a_index <= component_count + 1
		local
			l_components: like components
		do
			lock_update
			a_component.attach (grid_item)
			if a_index <= component_count then
				l_components := components
				l_components.go_i_th (a_index)
				l_components.put_left (a_component)
			else
				components.extend (a_component)
			end
			unlock_update
			try_call_setting_change_actions
			install_component_actions
		ensure
			component_inserted:
				components.has (a_component) and then a_component.is_parented and then a_component.grid_item = grid_item and then
				component_count = old component_count + 1
		end

	append_component (a_item: like component_type)
			-- Append `a_item' at the end of `items'.
		require
			a_item_attached: a_item /= Void
		do
			insert_component (a_item, component_count + 1)
		end

	remove_component (a_index: INTEGER_32)
			-- Remove trail from `components' at position indexed by `a_index'.
		require
			a_index_valid: a_index >= 1 and a_index <= component_count
		local
			l_components: like components
		do
			lock_update
			l_components := components
			l_components.go_i_th (a_index)
			l_components.item.detach
			l_components.remove
			unlock_update
			try_call_setting_change_actions
			if l_components.is_empty then
				uninstall_component_actions
			end
		ensure
			component_removed: component_count = old component_count - 1
		end

feature{NONE} -- Action type constants

	pointer_button_pressed_action_type: INTEGER = 1
	pointer_double_press_action_type: INTEGER = 2
	pointer_button_release_action_type: INTEGER = 3

	is_action_type_valid (a_type: INTEGER): BOOLEAN
			-- Is `a_type' a valid action type?
		do
			Result :=
				a_type = pointer_button_pressed_action_type or
				a_type = pointer_double_press_action_type or
				a_type = pointer_button_release_action_type
		end

feature{NONE} -- Implementation

	components: ARRAYED_LIST [like component_type]
			-- List of components attached to Current item
		do
			if components_internal = Void then
				create components_internal.make (1)
			end
			Result := components_internal
		ensure
			result_attached: Result /= Void
		end

	components_internal: like components
			-- Implementation of `components'

	required_component_width: INTEGER_32
			-- Required width in pixel for displaying all attached `components'
		local
			l_trailer: like components
		do
			l_trailer := components
			if not l_trailer.is_empty then
				from
					l_trailer.start
				until
					l_trailer.after
				loop
					Result := Result + l_trailer.item.required_width
					l_trailer.forth
				end
				Result := Result + (l_trailer.count - 1) * component_padding
			end
		ensure
			result_attached: Result >= 0
		end

	required_component_height: INTEGER_32
			-- Required height in pixel to display all attached `components'
		local
			l_trailer: like components
			l_height: INTEGER_32
		do
			l_trailer := components
			if not l_trailer.is_empty then
				from
					l_trailer.start
				until
					l_trailer.after
				loop
					l_height := l_trailer.item.required_height
					if l_height > Result then
						Result := l_height
					end
					l_trailer.forth
				end
			end
		ensure
			result_attached: Result >= 0
		end

	component_position: LINKED_LIST [EV_RECTANGLE]
			-- Position area of `components'
		do
			if component_position_internal = Void then
				create component_position_internal.make
			end
			Result := component_position_internal
		ensure
			result_attached: Result /= Void
		end

	component_position_internal: like component_position
			-- Implementation of `component_position'

	component_type: ES_GRID_ITEM_COMPONENT
			-- Component anchor type

	set_is_pointer_in_component (b: BOOLEAN)
			-- Set `is_ponter_in_trailer' with `b'.
		do
			is_pointer_in_component := b
		ensure
			is_pointer_in_trailer_set: is_pointer_in_component = b
		end

	veto_general_tooltip_function_internal: like veto_general_tooltip_function
			-- Implementation of `veto_general_tooltip_function'

	component_index_at_imp (a_relative_position: EV_COORDINATE): INTEGER
			-- Implementation for `component_index_at_position' and `component_index_at_curernt_position'
		require
			not_void: a_relative_position /= Void
		local
			l_pos: like component_position
			l_rec: EV_RECTANGLE
		do
			l_pos := component_position
			if not l_pos.is_empty then
				from
					l_pos.start
				until
					l_pos.after or Result > 0
				loop
					l_rec := l_pos.item
					if l_rec.has_x_y (a_relative_position.x, a_relative_position.y) then
						Result := l_pos.index
					else
						l_pos.forth
					end
				end
			end
		end

feature{NONE} -- component actions maintaining

	install_component_actions
			-- Install actions used for components.
		local
			l_grid_item: like grid_item
		do
			l_grid_item := grid_item
			if not l_grid_item.pointer_button_press_actions.has (on_pointer_button_pressed_agent) then
				l_grid_item.pointer_button_press_actions.extend (on_pointer_button_pressed_agent)
			end
			if not l_grid_item.pointer_double_press_actions.has (on_pointer_double_press_agent) then
				l_grid_item.pointer_double_press_actions.extend (on_pointer_double_press_agent)
			end
			if not l_grid_item.pointer_motion_actions.has (on_pointer_move_agent) then
				l_grid_item.pointer_motion_actions.extend (on_pointer_move_agent)
			end
			if not l_grid_item.pointer_leave_actions.has (on_pointer_leave_agent) then
				l_grid_item.pointer_leave_actions.extend (on_pointer_leave_agent)
			end
			if not l_grid_item.pointer_button_release_actions.has (on_pointer_button_releasd_agent) then
				l_grid_item.pointer_button_release_actions.extend (on_pointer_button_releasd_agent)
			end
			set_is_pointer_in_component (False)
			component_position.wipe_out
		end

	uninstall_component_actions
			-- Uninstall actions used for components.
		local
			l_grid_item: like grid_item
		do
			l_grid_item := grid_item
			if l_grid_item.pointer_button_press_actions.has (on_pointer_button_pressed_agent) then
				l_grid_item.pointer_button_press_actions.prune_all (on_pointer_button_pressed_agent)
			end
			if l_grid_item.pointer_double_press_actions.has (on_pointer_double_press_agent) then
				l_grid_item.pointer_double_press_actions.prune_all (on_pointer_double_press_agent)
			end
			if l_grid_item.pointer_motion_actions.has (on_pointer_move_agent) then
				l_grid_item.pointer_motion_actions.prune_all (on_pointer_move_agent)
			end
			if l_grid_item.pointer_leave_actions.has (on_pointer_leave_agent) then
				l_grid_item.pointer_leave_actions.prune_all (on_pointer_leave_agent)
			end
			if l_grid_item.pointer_button_release_actions.has (on_pointer_button_releasd_agent) then
				l_grid_item.pointer_button_release_actions.prune_all (on_pointer_button_releasd_agent)
			end
			set_is_pointer_in_component (False)
		end

	check_component_actions (x, y: INTEGER; a_action_type: INTEGER; a_arguments: TUPLE)
			-- Find a component which is under position (`x', `y') and call action whose type is `a_action_type' with arguments `a_arguments'.
			-- (`x', `y') is relative to top-left corner of current grid item.
		require
			a_action_type_valid: is_action_type_valid (a_action_type)
		local
			l_component: like component_type
			l_components: like components
			l_positions: like component_position
			done: BOOLEAN
		do
			l_components := components
			if not l_components.is_empty then
				from
					l_components.start
					l_positions := component_position
					l_positions.start
				until
					l_positions.after or done
				loop
					l_component := l_components.item
					if not l_component.is_action_blocked then
						if l_positions.item.has_x_y (x, y) then
							call_agent (l_component, a_action_type, a_arguments)
							done := True
						end
					end
					l_positions.forth
					if not l_components.after then
						l_components.forth
					end
				end
			end
		end

	call_agent (a_component: like component_type; a_action_type: INTEGER; a_arguments: TUPLE)
			-- Call actions of type `a_action_type' from `a_component_index'-th component in `components' with arguments `a_arguments'.
		require
			a_component_attached: a_component /= Void
			a_action_type_valid: is_action_type_valid (a_action_type)
		local
			l_button_argument: TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]
		do
			inspect
				a_action_type
			when pointer_button_pressed_action_type then
				l_button_argument ?= a_arguments
				a_component.pointer_button_press_actions.call (l_button_argument)
			when pointer_double_press_action_type then
				l_button_argument ?= a_arguments
				a_component.pointer_double_press_actions.call (l_button_argument)
			when pointer_button_release_action_type then
				l_button_argument ?= a_arguments
				a_component.pointer_button_release_actions.call (l_button_argument)
			end
		end

feature{NONE} -- Implementation/Status report

	is_position_in_area (a_x, a_y: INTEGER; a_rec: EV_RECTANGLE): BOOLEAN
			-- Is position (`a_x', `a_y') in area defined by `a_rec'?
		require
			a_rec_attached: a_rec /= Void
		do
			Result := a_rec.has_x_y (a_x, a_y)
		end

	is_ponter_out_of_component: BOOLEAN
			-- Is pointer out of trailer area?
		do
			Result := not is_pointer_in_component
		end

feature{NONE} -- Actions for components

	on_pointer_button_pressed_agent: PROCEDURE [ANY, TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]]
			-- Agent of `on_pointer_button_pressed'

	on_pointer_double_press_agent: PROCEDURE [ANY, TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]]
			-- Agent of `on_pointer_double_pressed'			

	on_pointer_button_releasd_agent: PROCEDURE [ANY, TUPLE [x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER]]
			-- Agent of `on_pointer_button_release'

	on_pointer_leave_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_pointer_leave'

	on_pointer_move_agent: PROCEDURE [ANY, TUPLE [x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER]];
			-- Agent of `on_pointer_move'

	on_pointer_button_pressed (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Action to be performed when pointer pressed
		do
			check_component_actions (x, y, pointer_button_pressed_action_type, [x, y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
		end

	on_pointer_double_pressed (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Action to be performed when pointer pressed
		do
			check_component_actions (x, y, pointer_double_press_action_type, [x, y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
		end

	on_pointer_move (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Action to be performed when pointer moves in current grid
		do
			on_pointer_move_internal (x, y, x_tilt, y_tilt, pressure, screen_x, screen_y, False)
		end

	on_pointer_move_internal (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER; a_leave: BOOLEAN)
			-- Action to be performed when pointer moves on current item
			-- `a_leave' means is this aciton called when pointer leaves current item.
		local
			l_component: like component_type
			l_components: like components
			l_positions: like component_position
			l_position: EV_RECTANGLE
			l_pointer_in_component: BOOLEAN
		do
			l_components := components
			if not l_components.is_empty then
				l_pointer_in_component := is_pointer_in_component
				from
					set_is_pointer_in_component (False)
					l_components.start
					l_positions := component_position
					l_positions.start
				until
					l_positions.after
				loop
					l_component := l_components.item
					l_position := l_positions.item
					if l_position.has_x_y (x, y) then
						if not l_component.is_pointer_in then
							l_component.set_is_pointer_in (True)
							if not l_component.is_action_blocked then
								l_component.pointer_enter_actions.call ([l_position.x - x , l_position.y - y, x_tilt, y_tilt, pressure, screen_x, screen_y])
							end
						end
						if not is_pointer_in_component then
							set_is_pointer_in_component (True)
						end
					else
						if l_component.is_pointer_in then
							l_component.set_is_pointer_in (False)
							if not l_component.is_action_blocked then
								l_component.pointer_leave_actions.call ([l_position.x - x , l_position.y - y, x_tilt, y_tilt, pressure, screen_x, screen_y])
							end
						end
					end
					l_positions.forth
					l_components.forth
				end
				if not a_leave and then general_tooltip /= Void then
					if l_pointer_in_component and then not is_pointer_in_component then
						general_tooltip.force_enter
					elseif not l_pointer_in_component and then l_pointer_in_component then
						general_tooltip.force_leave
					end
				end
			end
		end

	on_pointer_leave
			-- Action to be performed when pointer leaves current item
		do
			on_pointer_move_internal (-1, -1, 1, 0, 0, 0, 0, True)
		end

	on_pointer_button_release (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Action to be performed when pointer button is released
		do
			check_component_actions (x, y, pointer_button_release_action_type, [x, y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
