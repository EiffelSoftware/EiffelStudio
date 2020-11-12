note
	description: "Dialog to setup customized formatters"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SETUP_CUSTOMIZED_FORMATTER_DIALOG

inherit
	EB_CUSTOMIZED_FORMATTER_DIALOG [EB_CUSTOMIZED_FORMATTER_DESP]
		redefine
			on_ok
		end

	PROPERTY_HELPER
		undefine
			copy,
			default_create
		end

create
	make

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			default_initialize
			empty_selection_label.set_text (interface_names.l_select_formatter)
			set_title (interface_names.t_customized_formatter_setup)
			add_button.set_tooltip (interface_names.f_add_formatter)
			remove_button.set_tooltip (interface_names.f_remove_formatter)
		end

feature -- Access

	name_of_item (a_item: EB_CUSTOMIZED_FORMATTER_DESP): STRING_GENERAL
			-- Name of `a_item'
		do
			Result := a_item.name
		end

	item_grid_column_count: INTEGER
			-- Number of columns in `item_grid'
		do
			Result := 2
		end

	new_item: EB_CUSTOMIZED_FORMATTER_DESP
			-- New item used when adding new item
		local
			l_descriptor: EB_CUSTOMIZED_FORMATTER_DESP
		do
			create l_descriptor.make (next_item_name.as_string_8)
			l_descriptor.set_header (interface_names.l_formatter_default_header (interface_names.l_ellipsis))
			l_descriptor.set_temp_header (interface_names.l_formatter_default_temp_header (interface_names.l_ellipsis))
			l_descriptor.enable_global_scope
			Result := l_descriptor
		end

feature{NONE} -- Actions

	on_displayer_change (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_new_value: HASH_TABLE [TUPLE [view_name: STRING; sorting: STRING], STRING])
			-- Action to be performed when displayer/tool of `a_descriptor' changed
		require
			a_descriptor_attached: a_descriptor /= Void
			a_new_value_attached: a_new_value /= Void
		do
			set_has_changed (True)
			a_descriptor.wipe_out_tools
			from
				a_new_value.start
			until
				a_new_value.after
			loop
				a_descriptor.extend_tool (a_new_value.key_for_iteration, a_new_value.item_for_iteration.view_name, a_new_value.item_for_iteration.sorting)
				a_new_value.forth
			end
			refresh_grid_for_descriptor (a_descriptor)
		end

	on_data_change (a_new_data: READABLE_STRING_32; a_setter: PROCEDURE [STRING]; a_refresher: PROCEDURE)
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

	on_data_32_change (a_new_data: READABLE_STRING_32; a_setter: PROCEDURE [READABLE_STRING_32]; a_refresher: PROCEDURE)
			-- Action to be performed when `a_new_data' changes.
			-- Invoke `a_setter' to set this new data.
			-- After setting, invoke `a_referesh' to refresh Current dialog if `a_refresher' is not Void.
		require
			a_new_data_attached: a_new_data /= Void
			a_setter_attached: a_setter /= Void
		do
			set_has_changed (True)
			a_setter.call ([a_new_data])
			if a_refresher /= Void then
				a_refresher.call (Void)
			end
		end

	on_data_general_change (a_new_data: READABLE_STRING_32; a_setter: PROCEDURE [READABLE_STRING_GENERAL]; a_refresher: PROCEDURE)
			-- Action to be performed when `a_new_data' changes.
			-- Invoke `a_setter' to set this new data.
			-- After setting, invoke `a_referesh' to refresh Current dialog if `a_refresher' is not Void.
		require
			a_new_data_attached: a_new_data /= Void
			a_setter_attached: a_setter /= Void
		do
			set_has_changed (True)
			a_setter.call ([a_new_data])
			if a_refresher /= Void then
				a_refresher.call (Void)
			end
		end

	on_filter_change (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_filter: BOOLEAN)
			-- Action to be performed if metric filter status changed for `a_descrptor' from `property_grid'
		require
			a_descriptor_attached: a_descriptor /= Void
		do
			set_has_changed (True)
			a_descriptor.set_is_filter_enabled (a_filter)
		end

	on_scope_change  (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_scope: READABLE_STRING_32)
			-- Action to be performed if formatter scope status changed for `a_descrptor' from `property_grid'
		require
			a_descriptor_attached: a_descriptor /= Void
			a_scope_attached: a_scope /= Void
		do
			set_has_changed (True)
			if a_scope.same_string (interface_names.l_eiffelstudio) then
				a_descriptor.enable_global_scope
			else
				a_descriptor.enable_target_scope
			end
		end

	on_metric_change  (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_metric: READABLE_STRING_GENERAL)
			-- Action to be performed if formatter metric changed for `a_descrptor' from `property_grid'
		require
			a_descriptor_attached: a_descriptor /= Void
			a_metric_attached: a_metric /= Void
		local
			l_tool_value: HASH_TABLE [TUPLE [view_name: STRING; sorting: STRING], STRING]
			l_metric_name: STRING
			l_metric: EB_METRIC
			l_displayers: EB_FORMATTER_DISPLAYERS
		do
			l_metric_name := string_8_from_string_32 (a_metric)
			if property_grid /= Void and then property_grid.is_displayed then
					-- Set formatter name.
				if is_default_item_name (string_32_from_string_8 (formatter_name_property.value)) and then formatter_name_property /= Void then
					formatter_name_property.set_value (interface_names.first_character_as_upper (a_metric))
				end
					-- Set header.
				if header_property /= Void and then header_property.text.is_equal (interface_names.l_formatter_default_header (interface_names.l_ellipsis).as_string_32) then
					header_property.set_value (interface_names.l_formatter_default_header (interface_names.first_character_as_upper (a_metric)))
				end
					-- Set temp header.
				if temp_header_property /= Void and then temp_header_property.text.is_equal (interface_names.l_formatter_default_temp_header (interface_names.l_ellipsis).as_string_32) then
					temp_header_property.set_value (interface_names.l_formatter_default_temp_header (a_metric.as_lower))
				end
					-- Set default tools.
				if displayed_in_tools_property /= Void then
					l_tool_value := displayed_in_tools_property.value
					if l_tool_value = Void or else l_tool_value.is_empty then
						if metric_manager.is_metric_calculatable (l_metric_name) then
							l_metric := metric_manager.metric_with_name (l_metric_name)
							if l_metric.unit = class_unit or l_metric.unit = feature_unit then
								create l_tool_value.make (1)
								create l_displayers
								l_tool_value.put ([l_displayers.domain_displayer, ""], window_manager.last_focused_development_window.shell_tools.tool ({ES_CLASS_TOOL}).content_id)
							end
							if l_tool_value /= Void then
								displayed_in_tools_property.set_value (l_tool_value)
								refresh_grid_for_descriptor (a_descriptor)
							end
						end
					end
					if metric_property /= Void then
						if metric_manager.is_metric_calculatable (l_metric_name) then
							metric_property.set_tooltip ("")
							metric_property.set_foreground_color (Void)
						else
							metric_property.set_foreground_color ((create {EV_STOCK_COLORS}).red)
							metric_property.set_tooltip (interface_names.l_formatter_invalid_metric)
						end
					end
				end
			end
			set_has_changed (True)
			a_descriptor.set_metric_name (l_metric_name)
		end

	on_ok
			-- Action to be performed when "OK" button is pressed
		local
			l_warning: ES_DISCARDABLE_WARNING_PROMPT
		do
			if
				has_changed and then
				not workbench.universe_defined and then
				descriptors.there_exists (agent (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): BOOLEAN do Result := a_descriptor.is_target_scope end)
			then
				create l_warning.make_standard (interface_names.l_target_scope_customzied_formatter_not_saved, interface_names.l_discard_target_scope_customized_formatter, create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.discard_target_scope_customized_formatter_preference, True))
				l_warning.set_button_action (l_warning.dialog_buttons.ok_button, agent on_confirmed_ok)
				l_warning.show_on_active_window
			else
				on_confirmed_ok
			end
		end

	on_confirmed_ok
			-- Action to be performed when close and save is conformed
		do
			if is_displayed then
				hide
			end
			ok_actions.call (Void)
		end

feature -- Setting

	load_descriptors
			-- Load descriptors retrieved from `items_getter' into Current.
			-- Keep a copy of retrieved descriptors so modification done in Current dialog don't mess up the source.
		local
			l_original_desps: like descriptors
			l_desps: like descriptors
			l_callback: EB_CUSTOMIZED_FORMATTER_XML_CALLBACK
		do
			create l_callback.make
			items.wipe_out
			l_original_desps := items_getter.item (Void)
			l_desps :=
				items_from_xml_document (
					xml_document_for_items (n_formatters, l_original_desps, agent customized_formatter_manager.xml_for_descriptor),
					l_callback,
					agent l_callback.formatters,
					agent l_callback.last_error
			)
			check l_desps.count = l_original_desps.count end
			from
				l_original_desps.start
				l_desps.start
			until
				l_original_desps.after
			loop
				if l_original_desps.item.is_global_scope then
					l_desps.item.enable_global_scope
				else
					l_desps.item.enable_target_scope
				end
				l_original_desps.forth
				l_desps.forth
			end
			l_desps.do_all (agent items.force)
			set_has_changed (False)
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
			Result := "New formatter #"
		end

	display_value (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): HASH_TABLE [TUPLE [view_name: STRING; sorting: STRING], STRING]
			-- Displayer value from `a_descriptor'
		require
			a_descriptor_attached: a_descriptor /= Void
		local
			l_tools: HASH_TABLE [STRING, STRING]
			l_sorting: HASH_TABLE [STRING, STRING]
		do
			create Result.make (2)
			l_tools := a_descriptor.tools
			l_sorting := a_descriptor.sorting_orders
			from
				l_tools.start
			until
				l_tools.after
			loop
				Result.put ([l_tools.item_for_iteration, l_sorting.item (l_tools.key_for_iteration)], l_tools.key_for_iteration)
				l_tools.forth
			end
		ensure
			result_attached: Result /= Void
		end

	formatter_name_property: STRING_PROPERTY
			-- Property for formatter name

	header_property: STRING_PROPERTY
			-- Property for formatter header

	temp_header_property: STRING_PROPERTY
			-- Property for formatter temporary header

	displayed_in_tools_property: DIALOG_PROPERTY [HASH_TABLE [TUPLE [view_name: STRING; sorting: STRING], STRING]]
			-- Property for formatter displayed-in

	displayer_dialog: EB_DISPLAYER_DIALOG
			-- Displayer dialog

	metric_property: MENU_PROPERTY [READABLE_STRING_GENERAL]
			-- Property to setup metric

	data_from_row (a_row: EV_GRID_ROW): EB_CUSTOMIZED_FORMATTER_DESP
			-- Data from `a_row'.
		do
			Result ?= a_row.data
		end

feature{NONE} -- Implementation

	setup_item_grid
			-- Setup `item_grid'.
		do
			item_grid.column (1).set_title (interface_names.l_formatter)
			item_grid.column (2).set_title (interface_names.l_displayed_in)
		end

	bind_property_grid (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP)
			-- Load information of `a_descriptor' in `property_grid'.
		local
			l_grid: like property_grid
			l_name: STRING_PROPERTY
			l_tooltip: STRING_PROPERTY
			l_header: STRING_PROPERTY
			l_temp_header: STRING_PROPERTY
			l_pixmap: FILE_PROPERTY
			l_metric: like metric_property
			l_metric_filter: BOOLEAN_PROPERTY
			l_scope: STRING_CHOICE_PROPERTY

			l_tools: like displayed_in_tools_property
			l_dialog: like displayer_dialog
			l_displayer_value: like display_value
		do
			l_grid := property_grid
			l_grid.clear_description
			l_grid.reset
				-- Build "General" section.
			l_grid.add_section (interface_names.l_general)

			create l_name.make (interface_names.l_name)
			l_name.set_value (string_32_from_string_8 (a_descriptor.name))
			l_name.change_value_actions.extend (agent on_data_change (?, agent a_descriptor.set_name, agent refresh_grid_for_descriptor (a_descriptor)))
			formatter_name_property := l_name
			l_grid.add_property (l_name)

			create l_tooltip.make (interface_names.l_tooltip_lbl)
			l_tooltip.set_value (a_descriptor.tooltip)
			l_tooltip.change_value_actions.extend (agent on_data_32_change (?, agent a_descriptor.set_tooltip, Void))
			l_grid.add_property (l_tooltip)

			create l_header.make (interface_names.l_header)
			l_header.set_value (a_descriptor.header)
			l_header.change_value_actions.extend (agent on_data_32_change (?, agent a_descriptor.set_header, Void))
			l_header.set_description (metric_names.concatenated_string ((<<interface_names.l_formatter_header_help, interface_names.l_formatter_placeholder>>).linear_representation, "%N"))
			header_property := l_header
			l_grid.add_property (l_header)

			create l_temp_header.make (interface_names.l_temp_header)
			l_temp_header.set_value (a_descriptor.temp_header)
			l_temp_header.change_value_actions.extend (agent on_data_32_change (?, agent a_descriptor.set_temp_header, Void))
			l_temp_header.set_description (metric_names.concatenated_string ((<<interface_names.l_formatter_temp_header_help, interface_names.l_formatter_placeholder>>).linear_representation, "%N"))
			temp_header_property := l_temp_header
			l_grid.add_property (l_temp_header)

			create l_pixmap.make (interface_names.l_pixmap_file)
			l_pixmap.set_value (a_descriptor.pixmap_location.name)
			l_pixmap.change_value_actions.extend (agent on_data_general_change (?, agent a_descriptor.set_pixmap_location, Void))
			l_grid.add_property (l_pixmap)

			l_grid.current_section.expand

				-- Build "Metric" section.
			l_grid.add_section (interface_names.l_tab_metrics)

			create l_metric.make_with_menu (interface_names.l_tab_metrics, metric_menu)
			l_metric.set_value (string_32_from_string_8 (a_descriptor.metric_name))
			l_metric.change_value_actions.extend (agent on_metric_change (a_descriptor, ?))
			l_metric.set_value_retriever (agent (a_menu_item: EV_MENU_ITEM): STRING_GENERAL do Result := a_menu_item.text end)
			l_metric.set_value_converter (agent (a_text: STRING_32): STRING_GENERAL do Result := a_text end)
			l_metric.set_description (interface_names.l_formatter_metric_help)
			l_metric.enable_auto_set_data
			l_metric.enable_text_editing
			metric_property := l_metric
			l_grid.add_property (l_metric)

			l_metric_filter := new_boolean_property (interface_names.l_metric_filter, a_descriptor.is_filter_enabled)
			l_metric_filter.change_value_actions.extend (agent on_filter_change (a_descriptor, ?))
			l_metric_filter.set_description (interface_names.l_formatter_filter_help)
			l_grid.add_property (l_metric_filter)

			l_grid.current_section.expand

				-- Build "Layout" section.
			l_grid.add_section (interface_names.l_layout)

			create l_scope.make_with_choices (interface_names.l_scope,
				create {ARRAYED_LIST [STRING_32]}.make_from_array (<<interface_names.l_eiffelstudio, interface_names.l_target>>))
			if a_descriptor.is_global_scope then
				l_scope.set_value (interface_names.l_eiffelstudio)
			else
				l_scope.set_value (interface_names.l_target)
			end
			l_scope.set_description (interface_names.l_formatter_scope_help)
			l_scope.change_value_actions.extend (agent on_scope_change (a_descriptor, ?))
			l_grid.add_property (l_scope)

			create l_dialog.make (string_32_from_string_8 (a_descriptor.name), tool_table)
			create l_tools.make_with_dialog (interface_names.l_displayed_in, l_dialog)
			l_tools.set_display_agent (agent tools_display_function)
			l_tools.set_description (interface_names.l_formatter_displayed_in_help)
			l_displayer_value := display_value (a_descriptor)
			l_dialog.set_value (l_displayer_value)
			l_tools.set_value (l_displayer_value)
			l_dialog.data_change_actions.extend (agent l_tools.set_value)
			displayer_dialog := l_dialog
			l_tools.change_value_actions.extend (agent on_displayer_change (a_descriptor, ?))
			displayed_in_tools_property := l_tools
			l_grid.add_property (l_tools)
			l_grid.current_section.expand

			l_metric.enable_select
		end

	refresh_grid_for_descriptor (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP)
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
			if displayer_dialog /= Void then
				displayer_dialog.set_formatter_name (a_descriptor.name)
			end
		end

	tools_display_function (a_tool_value: like display_value): STRING_32
			-- String representation of `a_tool_value' for grid display
		require
			a_tool_value_attached: a_tool_value /= Void
		local
			l_tool_table: like tool_table
			l_tool_name: STRING_GENERAL
			l_tool_info: TUPLE [display_name: STRING_GENERAL; pixmap: EV_PIXMAP]
			l_has_text: BOOLEAN
		do
			create Result.make (64)
			l_tool_table := tool_table
			from
				a_tool_value.start
			until
				a_tool_value.after
			loop
				l_tool_info := l_tool_table.item (a_tool_value.key_for_iteration)
				if l_tool_info /= Void then
					l_tool_name := l_tool_info.display_name
					if l_tool_name /= Void then
						if l_has_text then
							Result.append (", ")
						end
						Result.append (l_tool_name)
						if not l_has_text then
							l_has_text := True
						end
					end
				end
				a_tool_value.forth
			end
		ensure
			result_attached: Result /= Void
		end

	resize_item_grid
			-- Resize `item_grid'.
		local
			l_size_table: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
		do
			create l_size_table.make (1)
			l_size_table.put ([100, 200], 1)
			item_grid_wrapper.auto_resize_columns (item_grid, l_size_table)
		end

	sorted_tools_for_formatter (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): LIST [TUPLE [displayed_name: STRING_GENERAL; pixmap: EV_PIXMAP]]
			-- Sorted store names for tools of `a_descriptors'
		require
			a_descriptor_attached: a_descriptor /= Void
		local
			l_tools: HASH_TABLE [STRING, STRING]
			l_tool_info: TUPLE [displayed_name: STRING_GENERAL; pixmap: EV_PIXMAP]
			l_table: HASH_TABLE [TUPLE [displayed_name: STRING_GENERAL; pixmap: EV_PIXMAP], STRING_GENERAL]
			l_sorted: SORTED_TWO_WAY_LIST [STRING_GENERAL]
			l_tool_table: like tool_table
			l_display_name: STRING_GENERAL
			l_store_name: STRING
		do
			l_tools := a_descriptor.tools
			l_tool_table := tool_table
			create {LINKED_LIST [TUPLE [displayed_name: STRING_GENERAL; pixmap: EV_PIXMAP]]} Result.make
			create l_table.make (l_tools.count)
			create l_sorted.make
			from
				l_tools.start
			until
				l_tools.after
			loop
				l_store_name := l_tools.key_for_iteration
				if l_tool_table.has (l_store_name) then
					l_tool_info := l_tool_table.item (l_store_name)
					l_display_name := l_tool_info.displayed_name
					l_table.put (l_tool_info, l_display_name)
					l_sorted.put_front (l_display_name)
				end
				l_tools.forth
			end
			l_sorted.sort
			from
				l_sorted.start
			until
				l_sorted.after
			loop
				Result.extend (l_table.item (l_sorted.item))
				l_sorted.forth
			end
		ensure
			result_attached: Result /= Void
		end

	bind_item_row (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_grid_row: EV_GRID_ROW)
			-- Bind `a_descriptor' in `a_grid_row'.
		local
			l_formatter_item: EV_GRID_LABEL_ITEM
			l_tools_item: ES_GRID_LIST_ITEM
			l_pixmap_component: ES_GRID_PIXMAP_COMPONENT
			l_tool_info: TUPLE [displayed_name: STRING_GENERAL; pixmap: EV_PIXMAP]
			l_sorted_tools: LIST [TUPLE [displayed_name: STRING_GENERAL; pixmap: EV_PIXMAP]]
		do
				-- Build formatter name grid item.
			create l_formatter_item.make_with_text (string_32_from_string_8 (a_descriptor.name))
			l_formatter_item.set_pixmap (pixmap_from_file (a_descriptor.pixmap_location))
			a_grid_row.set_item (1, l_formatter_item)

				-- Build formatter displayed tools grid item.
			create l_tools_item
			l_tools_item.set_component_padding (4)
			l_tools_item.enable_component_pebble

			l_sorted_tools := sorted_tools_for_formatter (a_descriptor)
			from
				l_sorted_tools.start
			until
				l_sorted_tools.after
			loop
				l_tool_info := l_sorted_tools.item
				create l_pixmap_component.make (l_tool_info.pixmap)
				l_tools_item.insert_component (l_pixmap_component, l_tools_item.component_count + 1)
				l_pixmap_component.set_general_tooltip (displayed_in_tooltip (l_tool_info.displayed_name, l_pixmap_component, l_tools_item))
				l_sorted_tools.forth
			end
			a_grid_row.set_item (2, l_tools_item)
			a_grid_row.set_data (a_descriptor)
		end

	displayed_in_tooltip (a_tool_name: STRING_GENERAL; a_component: ES_GRID_ITEM_COMPONENT; a_item: ES_GRID_LISTABLE_ITEM): EVS_GENERAL_TOOLTIP
			-- Tooltip for `a_tool_name'.
		require
			a_tool_name_attached: a_tool_name /= Void
		local
			l_toolname: STRING_GENERAL
			l_tooltip: EVS_WIDGET_TOOLTIP
		do
			l_toolname := a_tool_name.twin
			l_toolname.append (" ")
			l_toolname.append (interface_names.t_tool_name.as_lower)
			create l_tooltip.make (a_component.pointer_enter_actions, a_component.pointer_leave_actions, Void, agent (a_item.grid_item).is_destroyed, create {EV_LABEL}.make_with_text (l_toolname))
			l_tooltip.unify_background_color
			l_tooltip.enable_repeat_tooltip_display
			Result := l_tooltip
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
