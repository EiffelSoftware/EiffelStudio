indexing
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

	build_widget is
		local
			vb: EV_VERTICAL_BOX
			viewerborder: EV_VERTICAL_BOX
		do
			create vb
			widget := vb
			vb.set_border_width (layout_constants.dialog_unit_to_pixels (2))

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

			viewerborder.extend (viewer)
			vb.extend (viewerborder)

 			set_title (name)
		end

feature -- Access

	name: STRING_GENERAL is
		do
			Result := Interface_names.t_viewer_object_browser_title
		end

	widget: EV_WIDGET

	viewer: ES_OBJECTS_GRID

feature -- Access

	is_valid_stone (st: OBJECT_STONE; is_strict: BOOLEAN): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := st /= Void
		end

	objects_grid_object_line (add: STRING): ES_OBJECTS_GRID_OBJECT_LINE is
		do
			if has_object and viewer.row_count > 0 then
				if current_object.object_address.is_equal (add) then
					Result ?= viewer.row (1).data
				end
			end
		end

feature -- Change

	refresh is
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

	destroy is
			-- Destroy Current
		do
			reset
			if widget /= Void then
				widget.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND is
		do
			Result := Eb_debugger_manager.object_viewer_cmd
		end

	is_in_default_state: BOOLEAN is
		do
			Result := True
		end

	clear is
			-- Clean current data, useless if dialog closed or destroyed
		do
			viewer.set_row_count_to (0)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
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

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action is
			-- Close dialog
		do
			destroy
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
