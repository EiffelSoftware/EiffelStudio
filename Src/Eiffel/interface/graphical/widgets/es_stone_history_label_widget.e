note
	description: "[
		A widget based on the stone label widget ({ES_STONE_LABEL_WIDGET}) with added history management
		capabilities. The label widget is augmented with navigation back and forth buttons and a history
		jump-to menu for fast access.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STONE_HISTORY_LABEL_WIDGET

inherit
	ES_STONE_LABEL_WIDGET
		rename
			make as make_label_widget
		redefine
			build_widget_interface,
			is_interface_usable,
			on_after_initialized,
			on_stone_changed
		end

create
	make

convert
	widget: {EV_WIDGET, attached EV_WIDGET, EV_HORIZONTAL_BOX, attached EV_HORIZONTAL_BOX}

feature {NONE} -- Initialization

	make (a_container: attached like history_container)
			-- Initialize the widget with a history container
		require
			a_container_is_interface_usable: a_container.is_interface_usable
		do
			history_container := a_container
			make_label_widget
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
			history_container_set: history_container = a_container
		end

feature {NONE} -- Initialization: User interface

	build_widget_interface (a_widget: attached EV_HORIZONTAL_BOX)
			-- <Precursor>
		do
			Precursor (a_widget)

			create navigation_tool_bar.make

			create navigate_back_button.make
			navigate_back_button.set_pixel_buffer (mini_stock_pixmaps.general_previous_icon_buffer)
			navigate_back_button.set_pixmap (mini_stock_pixmaps.general_previous_icon)
			navigate_back_button.set_tooltip (locale_formatter.translation (tt_navigate_back))
			navigation_tool_bar.extend (navigate_back_button)
			register_action (navigate_back_button.pointer_button_press_actions,
				agent (ia_x: INTEGER_32; ia_y: INTEGER_32; ia_button: INTEGER_32; ia_x_tilt: REAL_64; ia_y_tilt: REAL_64; ia_pressure: REAL_64; ia_screen_x: INTEGER_32; ia_screen_y: INTEGER_32)
					do
						if navigate_back_button.is_sensitive then
							if ia_button = 1 then
								on_navigate_back
							elseif ia_button = 3 then
								on_show_navigate_menu (ia_x, ia_y, navigate_back_button, new_navigate_back_menu)
							end
						end
					end)

			create navigate_forward_button.make
			navigate_forward_button.set_pixel_buffer (mini_stock_pixmaps.general_next_icon_buffer)
			navigate_forward_button.set_pixmap (mini_stock_pixmaps.general_next_icon)
			navigate_forward_button.set_tooltip (locale_formatter.translation (tt_navigate_forward))
			navigation_tool_bar.extend (navigate_forward_button)
			register_action (navigation_tool_bar.pointer_button_press_actions,
				agent (ia_x: INTEGER_32; ia_y: INTEGER_32; ia_button: INTEGER_32; ia_x_tilt: REAL_64; ia_y_tilt: REAL_64; ia_pressure: REAL_64; ia_screen_x: INTEGER_32; ia_screen_y: INTEGER_32)
					do
						if navigate_forward_button.is_sensitive then
							if ia_button = 1 then
								on_navigate_forward
							elseif ia_button = 3 then
								on_show_navigate_menu (ia_x, ia_y, navigate_forward_button, new_navigate_forward_menu)
							end
						end
					end)

			navigation_tool_bar.compute_minimum_size
			a_widget.extend (navigation_tool_bar)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			propagate_drop_actions (Void)
			update_navigation
		end

feature {NONE} -- Access

	history_container: attached HISTORY_CONTAINER_I
			-- The history container used to preserve and managed history context.

feature {NONE} -- Measurement

	max_history_items: NATURAL_8
			-- Maximum number of history items to display
		do
			Result := 8
		ensure
			result_is_reasonable: Result <= 20
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then history_container.is_interface_usable
		end

feature {NONE} -- Status report

	is_navigating: BOOLEAN
			-- Indicates if a navigation is being performed.
			--| Note: This isused to determine if the stone is being updated as a result of navigation or
			--|       actual stone setting.

feature {NONE} -- User interface elements

	navigation_tool_bar: SD_TOOL_BAR
			-- History navigation tool bar.

	navigate_back_button: SD_TOOL_BAR_BUTTON
			-- Navigate back button.

	navigate_forward_button: SD_TOOL_BAR_BUTTON
			-- Navigate forward button.

	navigation_menu: EV_MENU
			-- Navigation menu container.

feature {NONE} -- User interface manipulation

	update_navigation
			-- Updates the navigation widgets based on the history state.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_container: like history_container
		do
			l_container := history_container
			if l_container.can_undo then
				navigate_back_button.enable_sensitive
			else
				navigate_back_button.disable_sensitive
			end
			if l_container.can_redo then
				navigate_forward_button.enable_sensitive
			else
				navigate_forward_button.disable_sensitive
			end
		end

	populate_history_menu (a_menu: EV_MENU; a_items: DS_LINEAR [HISTORY_STACK_ITEM_I])
			-- Populates a history menu with a list of history item.
			--
			-- `a_menu': Menu to populate with the history items.
			-- `a_items': A list of history items to generate a menu for.
		require
			is_interface_usable: is_interface_usable
			a_menu_attached: a_menu /= Void
			not_a_menu_is_destroyed: not a_menu.is_destroyed
			a_items_attached: a_items /= Void
			not_a_items_is_empty: not a_items.is_empty
			a_items_count_small_enough: a_items.count <= max_history_items
		local
			l_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			l_pixmap: EV_PIXMAP
			l_menu_item: EV_MENU_ITEM
		do
			a_menu.wipe_out

			create l_factory
			from a_items.start until a_items.after loop
				if attached {HISTORY_STACK_STONE_ITEM} a_items.item_for_iteration as l_stone_item then
					if attached l_stone_item.stone as l_stone then
						create l_menu_item.make_with_text (l_stone_item.description.as_string_32)
						l_pixmap := l_factory.pixmap_from_stone (l_stone)
						if l_pixmap /= Void then
							l_menu_item.set_pixmap (l_pixmap)
						end
						l_menu_item.select_actions.extend (agent history_container.undo_to (l_stone_item))
						a_menu.extend (l_menu_item)
					end
				end
				a_items.forth
			end
		end

feature {NONE} -- Action handlers

	on_navigate_back
			-- Called when the user chooses to navigate back in the history
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			history_container_can_undo: history_container.can_undo
		local
			l_application: EV_APPLICATION
		do
			l_application := ev_application
			if l_application.shift_pressed and not (l_application.ctrl_pressed or l_application.alt_pressed) then
					-- Show menu
				--show_navigation_menu (new_navigate_back_menu, navigate_back_button)
			else
				is_navigating := True
				history_container.undo
				is_navigating := False
				update_navigation
			end
		ensure
			is_navigating_unchanged: is_navigating = old is_navigating
		end

	on_navigate_forward
			-- Called when the user chooses to navigate forward in the history
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			history_container_can_redo: history_container.can_redo
		local
			l_application: EV_APPLICATION
		do
			l_application := ev_application
			if l_application.shift_pressed and not (l_application.ctrl_pressed or l_application.alt_pressed) then
					-- Show menu
				--show_navigation_menu (new_navigate_forward_menu, navigate_forward_button)
			else
				is_navigating := True
				history_container.redo
				is_navigating := False
				update_navigation
			end
		ensure
			is_navigating_unchanged: is_navigating = old is_navigating
		end

	on_show_navigate_menu (a_x: INTEGER; a_y: INTEGER; a_button: SD_TOOL_BAR_BUTTON; a_menu: EV_MENU)
			-- Shows a navigation menu contextually to a tool bar button.
			--
			-- `a_x': Relative X position.
			-- `a_y': Relative Y position.
			-- `a_button': A button to show the menu contextually to.
			-- `a_menu': The menu to show contextually to a button.
		require
			a_x_non_negative: a_x >= 0
			a_y_non_negative: a_y >= 0
			a_button_attached: a_button /= Void
			not_a_button_is_destroyed: not a_button.is_destroyed
			a_button_has_tool_bar: a_button.tool_bar /= Void
			a_menu_attached: a_menu /= Void
			not_a_menu_is_destroyed: not a_menu.is_destroyed
			not_a_menu_is_empty: not a_menu.is_empty
		local
			l_tool_bar: detachable SD_GENERIC_TOOL_BAR
		do
			l_tool_bar := a_button.tool_bar
			if l_tool_bar /= Void then
				if attached {EV_WIDGET} l_tool_bar as l_widget then
					a_menu.show_at (l_widget, a_x, a_y)
				else
					check not_possible: False end
				end
			end
		end

feature {NONE} -- Event handlers

	on_stone_changed (a_old_stone: detachable STONE)
			-- <Precursor>
		do
			Precursor (a_old_stone)
			if not is_navigating then
				if a_old_stone /= Void then
					history_container.put (new_history_stack_item (a_old_stone))
					update_navigation
				end
			end
		end

feature {NONE} -- Factory

	new_history_stack_item (a_stone: detachable STONE): attached HISTORY_STACK_STONE_ITEM
			-- Creates a new history stack item for the Current stone state.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_usable: is_stone_usable (a_stone)
		do
			create Result.make (Current, a_stone)
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

	new_navigate_back_menu: attached EV_MENU
			-- Create a new menu for the back button.
		require
			is_interface_usable:is_interface_usable
			can_undo: history_container.can_undo
		do
			if attached navigation_menu then
				Result := navigation_menu
			else
				create Result
				navigation_menu := Result
			end
			populate_history_menu (Result, history_container.top_undo_items (max_history_items))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	new_navigate_forward_menu: attached EV_MENU
			-- Create a new menu for the next button.
		require
			is_interface_usable:is_interface_usable
			can_redo: history_container.can_redo
		do
			if attached navigation_menu then
				Result := navigation_menu
			else
				create Result
				navigation_menu := Result
			end
			populate_history_menu (Result, history_container.top_redo_items (max_history_items))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Internationalization

	l_no_history: STRING = "Empty"
	tt_navigate_back: STRING = "Navigate to the back in the history.%NHold SHIFT to view the jump-to history menu"
	tt_navigate_forward: STRING = "Navigate to the forward in the history.%NHold SHIFT to view the jump-to history menu"

;note
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
