note
	description: "Dialog to setup customized tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL_DIALOG

inherit
	EB_CUSTOMIZED_FORMATTER_DIALOG [EB_CUSTOMIZED_TOOL_DESP]

create
	make

feature{NONE} -- Initializatioin

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			default_initialize
			empty_selection_label.set_text (interface_names.l_select_tool)
			set_title (interface_names.t_setup_customized_tool)
			add_button.set_tooltip (interface_names.f_add_tool)
			remove_button.set_tooltip (interface_names.f_remove_tool)
		end

feature -- Access

	name_of_item (a_item: EB_CUSTOMIZED_TOOL_DESP): STRING_GENERAL
			-- Name of `a_item'
		do
			Result := a_item.name
		end

	item_grid_column_count: INTEGER
			-- Number of columns in `item_grid'
		do
			Result := 1
		end

	new_item: EB_CUSTOMIZED_TOOL_DESP
			-- New item used when adding new item
		local
			l_descriptor: EB_CUSTOMIZED_TOOL_DESP
			l_uuid_generator: UUID_GENERATOR
		do
			create l_uuid_generator
			create l_descriptor.make (next_item_name, l_uuid_generator.generate_uuid.out)
			l_descriptor.set_pixmap_location ("")
			Result := l_descriptor
		end

feature{NONE} -- Actions

	on_name_change (a_new_data: STRING_32; a_descriptor: EB_CUSTOMIZED_TOOL_DESP)
			-- Action to be performed when `a_new_data' changes.
			-- Invoke `a_setter' to set this new data.
			-- After setting, invoke `a_referesh' to refresh Current dialog if `a_refresher' is not Void.
		require
			a_new_data_attached: a_new_data /= Void
			a_descriptor_attached: a_descriptor /= Void
		do
			set_has_changed (True)
			a_descriptor.set_name (a_new_data)
			refresh_grid_for_descriptor (a_descriptor)
			if handler_dialog /= Void then
				handler_dialog.set_tool_name (a_new_data)
			end
		end

	on_data_change (a_new_data: STRING_32; a_setter: PROCEDURE [ANY, TUPLE [STRING]]; a_refresher: PROCEDURE [ANY, TUPLE])
			-- Action to be performed when `a_new_data' changes.
			-- Invoke `a_setter' to set this new data.
			-- After setting, invoke `a_referesh' to refresh Current dialog if `a_refresher' is not Void.
		require
			a_new_data_attached: a_new_data /= Void
			a_setter_attached: a_setter /= Void
		do
			set_has_changed (True)
			a_setter.call ([string_8_from_string_32 (a_new_data)])
			if a_refresher /= Void then
				a_refresher.call (Void)
			end
		end

	on_handlers_change (a_handlers: HASH_TABLE [STRING, STRING]; a_descriptor: EB_CUSTOMIZED_TOOL_DESP)
			-- Action to be performed when handlers of `a_descriptor' changes.
		require
			a_handlers_attached: a_handlers /= Void
			a_descriptor_attached: a_descriptor /= Void
		do
			a_descriptor.handlers.wipe_out
			from
				a_handlers.start
			until
				a_handlers.after
			loop
				a_descriptor.extend_handler (a_handlers.item_for_iteration, a_handlers.key_for_iteration)
				a_handlers.forth
			end
			set_has_changed (True)
		end

feature{NONE} -- Implementation/Data

	default_icon_pixmap: EV_PIXMAP
			-- Default icon pixmap for `items'
		do
			Result := pixmaps.icon_pixmaps.diagram_export_to_png_icon
		end

	new_item_name: STRING
			-- Base for new created items
		do
			Result := "New tool #"
		end

	name_property: STRING_PROPERTY
			-- Name property

	handler_dialog: EB_STONE_HANDLER_DIALOG
			-- Dialog to setup stone handler

	data_from_row (a_row: EV_GRID_ROW): EB_CUSTOMIZED_TOOL_DESP
			-- Data from `a_row'.
		do
			Result ?= a_row.data
		end

feature{NONE} -- Implementation

	load_descriptors
			-- Load descriptors retrieved from `items_getter' into Current.
			-- Keep a copy of retrieved descriptors so modification done in Current dialog don't mess up the source.
		local
			l_desps: like descriptors
			l_callback: EB_CUSTOMIZED_TOOL_XML_CALLBACK
		do
			items.wipe_out
			create l_callback.make
			l_desps :=
				items_from_xml_document (
					xml_document_for_items (n_tools, items_getter.item (Void), agent customized_tool_manager.xml_for_descriptor),
					l_callback,
					agent l_callback.tools,
					agent l_callback.last_error
				)
			l_desps.do_all (agent items.force_last)
			set_has_changed (False)
		end

	setup_item_grid
			-- Setup `item_grid'.
		do
			item_grid.column (1).set_title (interface_names.t_tool_name)
		end

	bind_item_row (a_descriptor: EB_CUSTOMIZED_TOOL_DESP; a_grid_row: EV_GRID_ROW)
			-- Bind `a_descriptor' in `a_grid_row'.
		local
			l_item: EV_GRID_LABEL_ITEM
			l_pixmap: EV_PIXMAP
		do
			create l_item.make_with_text (a_descriptor.name)
			l_pixmap := pixmap_from_file (a_descriptor.pixmap_location)
			l_pixmap.stretch (16, 16)
			l_item.set_pixmap (l_pixmap)
			a_grid_row.set_data (a_descriptor)
			a_grid_row.set_item (1, l_item)
		end

	resize_item_grid
			-- Resize `item_grid'.
		do
		end

	bind_property_grid (a_descriptor: EB_CUSTOMIZED_TOOL_DESP)
			-- Load information of `a_descriptor' in `property_grid'.
		local
			l_grid: like property_grid
			l_name: like name_property
			l_pixmap: FILE_PROPERTY
			l_handler: DIALOG_PROPERTY [HASH_TABLE [STRING, STRING]]
			l_dialog: EB_STONE_HANDLER_DIALOG
		do
			l_grid := property_grid
			l_grid.clear_description
			l_grid.reset
				-- Build "General" section.
			l_grid.add_section (interface_names.l_general)

			create l_name.make (interface_names.l_name)
			l_name.set_value (a_descriptor.name.as_string_32)
			l_name.change_value_actions.extend (agent on_name_change (?, a_descriptor))
			name_property := l_name
			l_grid.add_property (l_name)

			create l_pixmap.make (interface_names.l_pixmap_file)
			l_pixmap.set_value (string_32_from_string_8 (a_descriptor.pixmap_location))
			l_pixmap.change_value_actions.extend (agent on_data_change (?, agent a_descriptor.set_pixmap_location, Void))
			l_grid.add_property (l_pixmap)

			create l_dialog.make (a_descriptor.name.as_string_32, available_tools, stone_table)
			create l_handler.make_with_dialog (interface_names.l_stone_handler, l_dialog)
			l_handler.set_description (interface_names.l_stone_handler_help)
			l_handler.set_display_agent (agent handler_display_function)
			l_handler.set_value (a_descriptor.handlers)
			l_dialog.data_change_actions.extend (agent l_handler.set_value (?))
			l_handler.change_value_actions.extend (agent on_handlers_change (?, a_descriptor))
			l_handler.disable_text_editing
			handler_dialog := l_dialog
			l_grid.add_property (l_handler)

			l_grid.current_section.expand
			l_name.enable_select
		end

	refresh_grid_for_descriptor (a_descriptor: EB_CUSTOMIZED_TOOL_DESP)
			-- Refresh grid item for `a_descriptor'.
		local
			l_grid_row: EV_GRID_ROW
			l_selected: BOOLEAN
		do
			item_grid.row_select_actions.block
			item_grid.row_deselect_actions.block
			l_grid_row := descriptor_row_table.item (a_descriptor)
			check l_grid_row /= Void end
			l_selected := l_grid_row.is_selected
			bind_item_row (a_descriptor, l_grid_row)
			if l_selected then
				l_grid_row.enable_select
			end
			item_grid.row_select_actions.resume
			item_grid.row_deselect_actions.resume
		end

	handler_display_function (a_handler_table: HASH_TABLE [STRING, STRING]): STRING_32
			-- String representation of handlers given by `a_handler_table'
		require
			a_handler_table_attached: a_handler_table /= Void
		local
			l_stone_name: STRING_GENERAL
			l_tools: like available_tools
			l_tool_table: HASH_TABLE [STRING_GENERAL, STRING]
			l_tool: STRING_GENERAL
		do
			l_tools := available_tools
			create l_tool_table.make (20)
			from
				l_tools.start
			until
				l_tools.after
			loop
				l_tool_table.put (l_tools.item.a_tool_name, l_tools.item.a_tool_id)
				l_tools.forth
			end

			create Result.make (64)
			from
				a_handler_table.start
			until
				a_handler_table.after
			loop
				l_stone_name := stone_table.item (a_handler_table.key_for_iteration)
				l_tool := l_tool_table.item (a_handler_table.item_for_iteration)
				if l_stone_name /= Void and then l_tool /= Void then
					if not Result.is_empty then
						Result.append (", ")
					end
					Result.append (l_tool)
					Result.append ("(")
					Result.append (l_stone_name)
					Result.append (")")
				end
				a_handler_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

	stone_table: HASH_TABLE [STRING_32, STRING]
			-- Stone table [Stone display name, stone name]
		do
			if stone_table_internal = Void then
				create stone_table_internal.make (5)
				stone_table_internal.put (interface_names.l_feature_stone_name, n_feature_stone)
				stone_table_internal.put (interface_names.l_compiled_class_stone_name, n_compiled_class_stone)
				stone_table_internal.put (interface_names.l_uncompiled_class_stone_name, n_uncompiled_class_stone)
				stone_table_internal.put (interface_names.l_group_stone_name, n_group_stone)
				stone_table_internal.put (interface_names.l_target_stone_name, n_target_stone)
			end
			Result := stone_table_internal
		ensure
			result_attached: Result /= Void
		end

	stone_table_internal: like stone_table
			-- Implementation of `stone_table'

	available_tools: LIST [TUPLE [a_tool_name: STRING_GENERAL; a_tool_id: STRING]]
			-- List of available tools
			-- Those that have been removed in Current dialog are not taken into consideration.
		local
			l_item_table: HASH_TABLE [EB_CUSTOMIZED_TOOL_DESP, STRING]
			l_cursor: DS_ARRAYED_LIST_CURSOR [EB_CUSTOMIZED_TOOL_DESP]
			l_tool: EB_CUSTOMIZED_TOOL
			l_tools: LIST [EB_CUSTOMIZED_TOOL]
			l_shell_tools: DS_ARRAYED_LIST_CURSOR [ES_TOOL [EB_TOOL]]
			l_shell_tool: ES_TOOL [EB_TOOL]
		do
			create {LINKED_LIST [TUPLE [a_tool_name: STRING_GENERAL; a_tool_id: STRING]]} Result.make
			create l_item_table.make (items.count)
			l_cursor := items.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item_table.put (l_cursor.item, l_cursor.item.id)
				l_cursor.forth
			end

				-- Retrieve the environment tools
			l_shell_tools := window_manager.last_focused_development_window.shell_tools.all_tools.new_cursor
			from l_shell_tools.start until l_shell_tools.after loop
				l_shell_tool := l_shell_tools.item
				Result.extend ([l_shell_tool.title, l_shell_tool.content_id.as_string_8])
				l_shell_tools.forth
			end

				-- Retrieve the customized tools
			l_tools := window_manager.last_focused_development_window.tools.customized_tools
			from
				l_tools.start
			until
				l_tools.after
			loop
				l_tool := l_tools.item
				check l_tool_attached: l_tool /= Void end
				if l_item_table.has (l_tool.title_for_pre) then
					Result.extend ([l_tool.title, l_tool.title_for_pre])
					l_item_table.remove (l_tool.title_for_pre)
				end
				l_tools.forth
			end
			from
				l_item_table.start
			until
				l_item_table.after
			loop
				Result.extend ([l_item_table.item_for_iteration.name, l_item_table.key_for_iteration])
				l_item_table.forth
			end
		ensure
			result_attached: Result /= Void
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
