note
	description: "Object that represents a component to be displayed in a grid listable item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_ITEM_COMPONENT

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item attached to Current

	required_width: INTEGER
			-- Required width in pixel
		deferred
		ensure
			result_attached: Result >= 0
		end

	required_height: INTEGER
			-- Required height in pixel
		deferred
		ensure
			result_attached: Result >= 0
		end

	last_pebble: ANY
			-- Last pebble returned from `on_pick'

	pebble_at_position (a_x, a_y: INTEGER): ANY
			-- Pebble at position (`a_x', `a_y') which is related to Current component
			-- Void if no pebble is found.
		deferred
		end

feature -- General tooltip

	general_tooltip: EVS_GENERAL_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided cannot satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.

	owner_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer enter actions of owner of current tooltip
			-- Attach this to owner's `pointer_enter_actions'.
		do
			Result := pointer_enter_actions
		end

	owner_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer leave actions of owner of current tooltip
			-- Attach this to owner's `pointer_leave_actions'.			
		do
			Result := pointer_leave_actions
		end

	is_owner_destroyed: BOOLEAN
			-- If owner destroyed
			-- Attach this to owner's `is_destroyed'.
		do
			Result := grid_item.is_destroyed
		end

	set_general_tooltip (a_tooltip: like general_tooltip)
			-- Set `general_tooltip' with `a_tooltip' and enable it at the same time.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := a_tooltip
			general_tooltip.enable_tooltip
		ensure
			general_tooltip_set: general_tooltip = a_tooltip
		end

	remove_general_tooltip
			-- Remove `general_tooltip'.
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := Void
		ensure
			general_tooltip_removed: general_tooltip = Void
		end

feature -- Status report

	is_action_blocked: BOOLEAN
			-- Should actions attached current be blocked so they don't interfere with actions in `grid_item'?

	is_parented: BOOLEAN
			-- Does Current attached to a grid editor token item?
		do
			Result := grid_item /= Void
		end

	is_displayable: BOOLEAN
			-- Can Current component been displayed
		do
			Result := is_parented and then grid_item.is_parented
		end

feature -- Pointer status

	is_pointer_in: BOOLEAN
			-- Is pointer within the area of current trailer?

	set_is_pointer_in (b: BOOLEAN)
			-- Set `is_pointer_in' with `b'.
		do
			is_pointer_in := b
		ensure
			is_pointer_in_set: is_pointer_in = b
		end

feature -- Attachment

	attach (a_grid_item: like grid_item)
			-- Attached Current to `a_grid_item'.
		require
			not_parented: not is_parented
			a_grid_item_attached: a_grid_item /= Void
		do
			set_grid_item (a_grid_item)
		ensure
			attached_result: is_parented and then grid_item = a_grid_item
		end

	detach
			-- Detach current from `grid_item'.
		do
			set_grid_item (Void)
		ensure
			detached: not is_parented and then grid_item = Void
		end

feature -- Setting

	set_grid_item (a_grid_item: like grid_item)
			-- Set `grid_item' with `a_grid_item'.
		do
			grid_item := a_grid_item
		ensure
			a_grid_item_set: grid_item = a_grid_item
		end

	block_actions
			-- Block actions attached to Current.
		do
			is_action_blocked := True
		ensure
			actions_blocked: is_action_blocked
		end

	resume_actions
			-- Resume blocked actions is
		do
			is_action_blocked := False
		ensure
			actions_resumed: not is_action_blocked
		end

feature -- Drawing

	display (a_drawable: EV_DRAWABLE; a_start_x, a_start_y: INTEGER; a_width, a_height: INTEGER)
			-- Draw current component in `a_drawable' starting from (`a_start_x', `a_start_y').
			-- `a_start_x' and `a_start_y' are 0-based.
			-- `a_width' and `a_height' are allowed width and leight of current component.
		require
			a_drawable_attached: a_drawable /= Void
			current_parented: is_parented
		deferred
		end

feature -- Actions

	on_pick (a_x, a_y: INTEGER)
			-- Action to be performed when pick occurs at position (`a_x', `a_y') relative to top-left corner of current item
		deferred
		end

	on_pick_ended
			-- Action to be performed when pick-and-drop process ended
		deferred
		end

feature -- Actions

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.
			-- Note: `pointer_motion_actions' of associated grid item will be always invoked.
		do
			if pointer_motion_actions_internal = Void then
				create pointer_motion_actions_internal
			end
			Result := pointer_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.
			-- Note: `pointer_button_press_actions' of associated grid item will be always invoked.
		do
			if pointer_button_press_actions_internal = Void then
				create pointer_button_press_actions_internal
			end
			Result := pointer_button_press_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.
			-- Note: `pointer_double_press_actions' of associated grid item will be always invoked.
		do
			if pointer_double_press_actions_internal = Void then
				create pointer_double_press_actions_internal
			end
			Result := pointer_double_press_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is released.
			-- Note: `pointer_button_release_actions' of associated grid item will be always invoked.
		do
			if pointer_button_release_actions_internal = Void then
				create pointer_button_release_actions_internal
			end
			Result := pointer_button_release_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer enters widget.
			-- Note: `pointer_enter_actions' of associated grid item will be invoked as well if
			--       pointer moves from outside of the grid item.
		do
			if pointer_enter_actions_internal = Void then
				create pointer_enter_actions_internal
			end
			Result := pointer_enter_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer leaves widget.
			-- Note: `pointer_leave_actions' of associated grid item will be invoked as well if
			--       pointer moves outside of the grid item.			
		do
			if pointer_leave_actions_internal = Void then
				create pointer_leave_actions_internal
			end
			Result := pointer_leave_actions_internal
		ensure
			not_void: Result /= Void
		end

feature{NONE} -- Implementation

	pointer_motion_actions_internal: like pointer_motion_actions
			-- Implementation of `pointer_motion_actions'

	pointer_button_press_actions_internal: like pointer_button_press_actions
			-- Implementation of `pointer_button_press_actions'

	pointer_double_press_actions_internal: like pointer_double_press_actions
			-- Implementation of `pointer_double_press_actions'

	pointer_button_release_actions_internal: like pointer_button_release_actions
			-- Implementation of `pointer_button_release_actions'

	pointer_enter_actions_internal: like pointer_enter_actions
			-- Implementation of `pointer_enter_actions'

	pointer_leave_actions_internal: like pointer_leave_actions;
			-- Implementation of `pointer_leave_actions'

feature{NONE} -- Implementation/Setting

	set_last_pebble (a_pebble: like last_pebble)
			-- Set `last_pebble' with `a_pebble'.
		do
			last_pebble := a_pebble
		ensure
			last_pebble_set: last_pebble = a_pebble
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
