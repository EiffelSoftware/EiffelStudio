note
	description: "Pick-and-drop support for grid items"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_PND_SUPPORT

inherit
	EVS_GRID_UTILITY

	EV_SHARED_APPLICATION

create
	make_with_grid

feature{NONE} -- Initialization

	make_with_grid (a_grid: like grid)
			-- Initialize `grid' with `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		do
			internal_grid := a_grid
		ensure
			grid_set: grid = a_grid
		end

feature -- Access

	last_picked_item: EV_GRID_ITEM
			-- Last picked item	
			-- Void if no item is picked.	

	pick_start_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_COORDINATE]]
			-- Actions to be performed when pick starts from given grid item.
			-- Each agent in this should be responsible for certain kind of grid item.
			-- In an agent, `last_pebble' should be set through `set_last_pebble' if a pebble is confiremed to be returned and
			-- possible item redraw should be done also.
			-- For bug#14291
			-- EV_COORDINATE parameter is original X, Y pointer position (relative to grid top-left) when right click menu just popuped
		do
			if pick_start_actions_internal = Void then
				create pick_start_actions_internal
			end
			Result := pick_start_actions_internal
		ensure
			result_attached: Result /= Void
		end

	pick_end_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM]]
			-- Actions to be performed when pick ends from given grid item.
			-- Each agent in this should be responsible for certain kind of grid item.
			-- Don't set `last_picked_item' to Void in these agents.
		do
			if pick_end_actions_internal = Void then
				create pick_end_actions_internal
			end
			Result := pick_end_actions_internal
		ensure
			result_attached: Result /= Void
		end

	grid: ES_GRID
			-- Grid to which supports apply
		do
			Result := internal_grid
		ensure
			result_attached: Result /= Void
		end

	old_item_pebble_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], ANY]
			-- Old `item_pebble_function' in `grid' before last `enable_grid_item_pnd_support'

	stone_at_position (a_x, a_y: INTEGER): ANY
			-- Stone at position (`a_x', `a_y') which is related to the top-left coordinate of `grid'
			-- Void if no item is found or that item contains no stone.			
		local
			l_pickable_item: ES_GRID_PICKABLE_ITEM
		do
			l_pickable_item ?= grid_item_at_position (grid, a_x, a_y)
			if l_pickable_item /= Void then
				Result := l_pickable_item.pebble_at_position
			end
		end

feature -- Setting

	enable_grid_item_pnd_support
			-- Enable pick and drop on individual editor token.
			-- Actions in `pick_start_actions' will be invoked when pick starts and
			-- actions in `pick_end_actions' will be invoked when pick ends.
		do
			if not grid.pick_actions.has (on_pick_start_action) then
				grid.pick_actions.force_extend (on_pick_start_action)
			end
			if not grid.pick_ended_actions.has (on_pick_ended_action) then
				grid.pick_ended_actions.force_extend (on_pick_ended_action)
			end
			old_item_pebble_function := grid.item_pebble_function
			grid.set_item_pebble_function (on_pick_function)
		end

	disable_grid_item_pnd_support
			-- Disable pick and drop on individual editor token.
		do
			grid.pick_actions.prune_all (on_pick_start_action)
			grid.pick_ended_actions.prune_all (on_pick_ended_action)
			grid.set_item_pebble_function (old_item_pebble_function)
		end

	set_last_picked_item (a_item: like last_picked_item)
			-- Set `last_picked_item' with `a_item'.
		do
			last_picked_item := a_item
		ensure
			last_picked_item_set: last_picked_item = a_item
		end

feature{NONE} -- Implementation

	internal_grid: like grid
			-- Implementation of `grid'

	pick_start_actions_internal: like pick_start_actions
			-- Implementation of `pick_start_actions'

	pick_end_actions_internal: like pick_end_actions
			-- Implementation of `pick_end_actions'

	pebble_from_grid_item (a_item: EV_GRID_ITEM): ANY
			-- Pebble from `a_item'
		local
			l_position: EV_COORDINATE
		do
			if not ev_application.ctrl_pressed then
				if a_item /= Void and then a_item.parent = grid then
					l_position := a_item.parent.pointer_position
					Result := stone_at_position (l_position.x, l_position.y)
					if Result = Void and then old_item_pebble_function /= Void then
						Result := old_item_pebble_function.item ([a_item])
					end
				end
			end
			if Result = Void then
				set_last_picked_item (Void)
			else
				set_last_picked_item (a_item)
			end
		end

	on_pick_ended_action: PROCEDURE [ANY, TUPLE [a_item: EV_ABSTRACT_PICK_AND_DROPABLE]]
			-- Agent object of `on_pick_ended_from_grid_editor_token_item'
		do
			if on_pick_ended_action_internal = Void then
				on_pick_ended_action_internal := agent on_pick_end
			end
			Result := on_pick_ended_action_internal
		ensure
			result_attached: Result /= Void
		end

	on_pick_function: FUNCTION [ANY, TUPLE [a_item: EV_GRID_ITEM], ANY]
			-- Agent object of `on_pick_start_from_grid_editor_token_item'
		do
			if on_pick_function_internal = Void then
				on_pick_function_internal := agent pebble_from_grid_item
			end
			Result := on_pick_function_internal
		ensure
			result_attached: Result /= Void
		end

	on_pick_ended_action_internal: like on_pick_ended_action
			-- Implementation of `on_pick_ended_action'

	on_pick_function_internal: like on_pick_function
			-- Implementation of `on_pick_function'

	on_pick_start_action: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER]]
			-- agent of `on_pick_start'
		do
			if on_pick_start_action_internal = Void then
				on_pick_start_action_internal := agent on_pick_start
			end
			Result := on_pick_start_action_internal
		end

	on_pick_start_action_internal: like on_pick_start_action
			-- Implementation of `on_pick_start_action'

	on_pick_start (a_x, a_y: INTEGER)
			-- Action to be performed when pick-and-drop starts
		local
			l_position: EV_COORDINATE
		do
			if not pick_start_actions.is_empty then
				create l_position.make (a_x, a_y + grid.header.height)
				pick_start_actions.call ([grid_item_at_position (grid, l_position.x, l_position.y), l_position])
			end
		end

	on_pick_end (a_area: EV_ABSTRACT_PICK_AND_DROPABLE)
			-- Action to be performed when pick-and-drop ends
		do
			if last_picked_item /= Void then
				pick_end_actions.call ([last_picked_item])
			end
			set_last_picked_item (Void)
		ensure
			last_picked_item_cleared: last_picked_item = Void
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
