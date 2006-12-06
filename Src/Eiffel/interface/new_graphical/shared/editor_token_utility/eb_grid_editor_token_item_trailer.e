indexing
	description: "Object that represents a trailer which can be put into a editor token grid item, after the editor token text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_GRID_EDITOR_TOKEN_ITEM_TRAILER

feature -- Access

	required_width: INTEGER is
			-- Required width in pixel
		deferred
		ensure
			result_attached: Result >= 0
		end

	required_height: INTEGER is
			-- Required height in pixel
		deferred
		ensure
			result_attached: Result >= 0
		end

	grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Grid editor token item associated with Current

	general_tooltip: EVS_GENERAL_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided cannot satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.

feature -- Status report

	is_action_blocked: BOOLEAN
			-- Should actions attached current be blocked so they don't interfere with actions in `grid_item'?

	is_parented: BOOLEAN is
			-- Does Current attached to a grid editor token item?
		do
			Result := grid_item /= Void
		end

feature -- Drawing

	draw (a_drawable: EV_DRAWABLE; a_start_x, a_start_y: INTEGER) is
			-- Draw current trailer in `a_drawable' starting from (`a_start_x', `a_start_y').
			-- `a_start_x' and `a_start_y' are 0-based.
		require
			a_drawable_attached: a_drawable /= Void
			current_parented: is_parented
		deferred
		end

feature{EB_GRID_EDITOR_TOKEN_ITEM} -- Attachment

	attach (a_grid_item: like grid_item) is
			-- Attached Current to `a_grid_item'.
		require
			not_parented: not is_parented
		do
			grid_item := a_grid_item
		ensure
			attached: is_parented and then grid_item = a_grid_item
		end

	detach is
			-- Detach current from `grid_item'.
		do
			grid_item := Void
		ensure
			detached: not is_parented and then grid_item = Void
		end

feature -- Setting

	block_actions is
			-- Block actions attached to Current.
		do
			is_action_blocked := True
		ensure
			actions_blocked: is_action_blocked
		end

	resume_actions is
			-- Resume blocked actions is
		do
			is_action_blocked := False
		ensure
			actions_resumed: not is_action_blocked
		end

	set_general_tooltip (a_tooltip: like general_tooltip) is
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

	remove_general_tooltip is
			-- Remove `general_tooltip'.
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := Void
		ensure
			general_tooltip_removed: general_tooltip = Void
		end

feature -- Actions

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		do
			if pointer_motion_actions_internal = Void then
				create pointer_motion_actions_internal
			end
			Result := pointer_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is pressed.
		do
			if pointer_button_press_actions_internal = Void then
				create pointer_button_press_actions_internal
			end
			Result := pointer_button_press_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is double clicked.
		do
			if pointer_double_press_actions_internal = Void then
				create pointer_double_press_actions_internal
			end
			Result := pointer_double_press_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is released.
		do
			if pointer_button_release_actions_internal = Void then
				create pointer_button_release_actions_internal
			end
			Result := pointer_button_release_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			if pointer_enter_actions_internal = Void then
				create pointer_enter_actions_internal
			end
			Result := pointer_enter_actions_internal
		ensure
			not_void: Result /= Void
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			if pointer_leave_actions_internal = Void then
				create pointer_leave_actions_internal
			end
			Result := pointer_leave_actions_internal
		ensure
			not_void: Result /= Void
		end

feature{EB_GRID_EDITOR_TOKEN_ITEM} -- Pointer status

	is_pointer_in: BOOLEAN
			-- Is pointer within the area of current trailer?

	set_is_pointer_in (b: BOOLEAN) is
			-- Set `is_pointer_in' with `b'.
		do
			is_pointer_in := b
		ensure
			is_pointer_in_set: is_pointer_in = b
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
