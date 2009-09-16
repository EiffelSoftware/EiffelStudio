note
	description: "Object browser expanded viewer  ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_BROWSER_VIEWER_BOX

inherit
	EB_OBJECT_VIEWER
		redefine
			build_mini_tool_bar,
			build_tool_bar
		end

	ES_OBJECTS_GRID_MANAGER

	EV_SHARED_APPLICATION

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	build_widget
		local
			vb: EV_VERTICAL_BOX
			viewerborder: EV_VERTICAL_BOX
		do
			create vb
			widget := vb
			if not is_associated_with_tool then
				vb.set_border_width (layout_constants.dialog_unit_to_pixels (2))
			end

				--| Viewer
			create viewerborder
			viewerborder.set_border_width (layout_constants.dialog_unit_to_pixels (1))
			viewerborder.set_background_color ((create {EV_STOCK_COLORS}).black)

			create viewer.make_with_name ("ObjectBrowseViewer", "obv")
			viewer.set_column_count_to (5)
			viewer.set_minimum_height (100)
			viewer.set_default_columns_layout (<<
						[1, True, False, 150, interface_names.l_name, interface_names.to_name],
						[2, True, False, 150, interface_names.l_value, interface_names.to_value],
						[3, True, False, 100, interface_names.l_type, interface_names.to_type],
						[4, True, False, 80, interface_names.l_address, interface_names.to_address],
						[5, True, False, 200, interface_names.l_Context, interface_names.to_context]
					>>
				)
			viewer.set_columns_layout (1, viewer.default_columns_layout)
			viewer.drop_actions.extend (agent on_stone_dropped)
			viewer.drop_actions.set_veto_pebble_function (agent is_valid_stone)
			viewer.initialize_layout_management (Void)
			viewer.enable_layout_management
			viewer.set_pre_activation_action (agent pre_activate_cell)

			viewer.set_configurable_target_menu_mode
			viewer.set_configurable_target_menu_handler (agent context_menu_handler)

			build_slices_cmd
			viewer.set_slices_cmd (slices_cmd)

			viewerborder.extend (viewer)
			vb.extend (viewerborder)

 			set_title (name)
		end

	build_slices_cmd
		do
			if slices_cmd = Void then
				create slices_cmd.make (Current)
				slices_cmd.enable_sensitive
			end
		end

	build_hexa_cmd
		do
			if hex_format_cmd = Void then
				create hex_format_cmd.make (agent set_hexadecimal_mode)
				hex_format_cmd.enable_sensitive
			end
		end

	build_tool_bar
		local
			tb: SD_TOOL_BAR
		do
			if not is_associated_with_tool then
				build_slices_cmd
				build_hexa_cmd
				if tool_bar = Void then
					create tb.make
					tool_bar := tb

					tb.extend (slices_cmd.new_mini_sd_toolbar_item)
					tb.extend (hex_format_cmd.new_mini_sd_toolbar_item)
					tb.extend (object_viewer_cmd.new_mini_sd_toolbar_item)

					tb.compute_minimum_size
				end
			end
		end

	build_mini_tool_bar
		do
			build_slices_cmd
			build_hexa_cmd
			if mini_tool_bar = Void then
				create mini_tool_bar.make

				mini_tool_bar.extend (slices_cmd.new_mini_sd_toolbar_item)
				mini_tool_bar.extend (hex_format_cmd.new_mini_sd_toolbar_item)
				mini_tool_bar.extend (object_viewer_cmd.new_mini_sd_toolbar_item)

				mini_tool_bar.compute_minimum_size
			end
		end

feature -- Access

	name: STRING_GENERAL
		do
			Result := Interface_names.t_viewer_object_browser_title
		end

	widget: EV_WIDGET

	viewer: ES_OBJECTS_GRID

feature -- Access

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN
			-- Is `st' valid stone for Current?
		do
			Result := attached {OBJECT_STONE} a_stone as st
		end

	objects_grid_object_line (add: DBG_ADDRESS): ES_OBJECTS_GRID_OBJECT_LINE
		do
			if has_object and viewer.row_count > 0 then
				if current_object.object_address.is_equal (add) then
					Result ?= viewer.row (1).data
				end
			end
		end

feature -- Change

	refresh
			-- Recompute the displayed text.
		do
			viewer.record_layout
			clear
			if
				Debugger_manager.application_is_executing
				and then Debugger_manager.application_is_stopped
			then
				if has_object then
					retrieve_dump_value
					viewer.insert_new_row (1)
					if current_dump_value /= Void then
						viewer.attach_dump_value_to_grid_row (viewer.row (1), viewers_manager.current_dump_value, "Object")
					else
						viewer.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text (Interface_names.l_dbg_unable_to_get_value_message))
					end
				end
			end
			viewer.restore_layout
		end

	destroy
			-- Destroy Current
		do
			reset
			if widget /= Void then
				widget.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation

	set_hexadecimal_mode (v: BOOLEAN)
		do
			viewer.set_hexadecimal_mode (v)
		end

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND
		do
			Result := Eb_debugger_manager.object_viewer_cmd
		end

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

	clear
			-- Clean current data, useless if dialog closed or destroyed
		do
			viewer.set_row_count_to (0)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu handler
		local
			l_dev_window: EB_DEVELOPMENT_WINDOW
		do
			l_dev_window := window_manager.last_focused_development_window
			if l_dev_window /= Void then
				l_dev_window.menus.context_menu_factory.object_viewer_browser_view_menu (a_menu, a_target_list, a_source, a_pebble, viewer)
			end
		end

feature {NONE} -- Event handling

	on_stone_dropped (st: OBJECT_STONE)
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action
			-- Close dialog
		do
			destroy
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
