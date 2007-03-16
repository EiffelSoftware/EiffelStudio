indexing
	description: "Customized formatter whose functionality is defined by specified metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER

inherit
	EB_BROWSER_FORMATTER
		rename
			make as old_make
		redefine
			old_make,
			is_valid,
			is_customized_fomatter,
			name,
			enable_sensitive,
			sorting_order_getter,
			sorting_order_setter
		end

	EB_STONE_UTILITY

	EB_DOMAIN_ITEM_UTILITY

	EB_SHARED_METRIC_MANAGER

	EXCEPTIONS

	EB_METRIC_INTERFACE_PROVIDER

create
	make

feature{NONE} -- Initialization

	old_make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			Precursor (a_manager)
			if tooltip /= Void and then not tooltip.is_empty then
				capital_command_name.append ("%N")
				capital_command_name.append (tooltip)
			end
		end

	make (a_manager: like manager; a_cmd_name: STRING_GENERAL; a_header: like header; a_temp_header: like temp_header; a_menu_name: like menu_name; a_metric: like metric; a_viewer: like viewer; a_icon_location: like icon_location; a_tooltip: like tooltip) is
			-- Initialize Current.
		require
			a_manager_attached: a_manager /= Void
			a_cmd_name_attached: a_cmd_name /= Void
			a_header_attached: a_header /= Void
			a_temp_header_attached: a_temp_header /= Void
			a_menu_name_attached: a_menu_name /= Void
			a_metric_attached: a_metric /= Void
			a_viewer_attached: a_viewer /= Void
			a_tooltip_attached: a_tooltip /= Void
		do
			set_command_name_internal (a_cmd_name)
			set_header_internal (a_header)
			set_temp_header_internal (a_temp_header)
			set_menu_name_internal (a_menu_name)
			set_viewer (a_viewer)
			set_metric (a_metric)
			set_icon_location (a_icon_location)
			set_tooltip (a_tooltip)
			old_make (a_manager)
		end

feature -- Access

	command_name: STRING_GENERAL is
			-- Name of current command throughout the interface (in lower case).
		do
			Result := Interface_names.string_general_as_lower (command_name_internal)
		end

	element_name: STRING is
			-- name of associated element in current formatter.
			-- For exmaple, if a class stone is associated to current, `element_name' would be the class name.
			-- Void if element is not retrievable.
		do
			if stone /= Void and then stone.is_valid then
				Result := stone.stone_name.as_string_8
			end
		end

	tooltip: STRING_GENERAL
			-- Tooltip

	header: STRING_GENERAL is
			-- Text displayed in the ouput_line when current formatter is displayed.
		local
			l_header: STRING_32
		do
			if stone /= Void then
				l_header := header_internal.as_string_32
				check l_header /= Void end
				l_header.replace_substring_all (placeholder, name_of_stone (stone))
				Result := l_header
			else
				Result := Interface_names.l_Not_in_system_no_info
			end
		end

	temp_header: STRING_GENERAL is
			-- Text displayed in the ouput_line when current formatter is working.
		local
			l_temp_header: STRING_32
		do
			if stone /= Void then
				l_temp_header := temp_header_internal.as_string_32
				check l_temp_header /= Void end
				l_temp_header.replace_substring_all (placeholder, name_of_stone (stone))
				Result := l_temp_header
			else
				Result := Interface_names.l_Not_in_system_no_info
			end
		end

	post_fix: STRING is
			-- Postfix name of current format.
			-- Used as an extension while saving.
		do
			Result := "cus"
		end

	menu_name: STRING_GENERAL is
			-- String representation in the associated menu.
		do
			Result := menu_name_internal.twin
		end

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		do
			if (not is_pixmap_loaded) or else symbol_internal = Void then
				if not is_pixmap_loaded then
					load_pixmap
				end
				create symbol_internal.make (1, 2)
				symbol_internal.put (pixmap, 1)
				symbol_internal.put (pixmap, 2)
			end
			Result := symbol_internal
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Graphical representation of the command.
		do
			if not is_pixmap_loaded then
				load_pixmap
			end
			Result := pixel_buffer_internal
		end

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if stone = Void or browser = Void then
				Result := empty_widget
			else
				Result := browser.widget
			end
		end

	metric: STRING
			-- Name of metric which is used to retrieve result for Current formatter

	valid_stone_function: FUNCTION [ANY, TUPLE [STONE], BOOLEAN]
			-- Function to check if given stone is suitable for Current formatter

	name: STRING_GENERAL is
			-- Name of Current formatter
		do
			Result := ("custom_").as_string_32
			Result.append (command_name)
		end

	viewer: STRING
			-- Viewer

	displayer_generator: TUPLE [generator: FUNCTION [ANY, TUPLE, like displayer]; name: STRING] is
			-- Generator to generate proper `displayer' for Current formatter
		do
			Result := [displayer_generators.generator_with_name (viewer), viewer]
		end

	icon_location: STRING
			-- Location of icon file for Current formatter

	sorting_status_preference: STRING_PREFERENCE is
			-- Preference to store last sorting orders of Current formatter
		do
			Result := Void
		end

	descriptor: EB_CUSTOMIZED_FORMATTER_DESP
			-- Descriptor of Current formatter

	sorting_order_getter: FUNCTION [ANY, TUPLE, STRING] is
			-- Getter to retrieve sorting order status
		do
			if descriptor /= Void and then tool /= Void then
				Result := agent (descriptor.sorting_orders).item (tool)
			end
		end

	sorting_order_setter: PROCEDURE [ANY, TUPLE [STRING]] is
			-- Setter to set sorting order given as the only argument
		do
			if descriptor /= Void and then tool /= Void then
				Result := agent descriptor.extend_sorting_order (tool, ?)
			end
		end

	tool: STRING
			-- Name of the tool in which Current formatter is to be displayed

feature -- Status report

	has_breakpoints: BOOLEAN is
			-- Should `Current' display breakpoints?
		do
			Result := False
		end

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET class texts?
		do
			Result := True
		end

	line_numbers_allowed: BOOLEAN is
			-- Does it make sense to show line numbers in Current?
		do
			Result := False
		end

	is_filter_enabled: BOOLEAN
			-- Is filter on domain result enabled?

	is_valid: BOOLEAN is
			-- Is Current formatter valid?
		local
			l_metric_manager: like metric_manager
			l_metric: like metric
		do
			l_metric_manager := metric_manager
			l_metric := metric
			Result := l_metric_manager.is_metric_loaded and then
					  l_metric_manager.has_metric (l_metric) and then
					  l_metric_manager.is_metric_valid (l_metric)
		end

	is_customized_fomatter: BOOLEAN is True
			-- Is Current a customized formatter?

feature -- Setting

	setup_viewpoint is
			-- Setup viewpoint for formatting.
		do
		end

	set_tooltip (a_tooltip: like tooltip) is
			-- Set `tooltip' with `a_tooltip'.
		do
			tooltip := a_tooltip
		ensure
			tooltip_set: tooltip = a_tooltip
		end

	set_metric (a_metric_name: like metric) is
			-- Set `metric' with `a_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			metric := a_metric_name.twin
		ensure
			metric_set: metric.is_equal (a_metric_name)
		end

	set_focus is
			-- Set focus to current formatter.
		do
			if browser /= Void then
				browser.set_focus
			end
		end

	set_pixmap (a_pixmap: like pixmap) is
			-- Set `pixmap' with `a_pixmap'.
		do
			pixmap := a_pixmap
			pixmap.stretch (16, 16)
		end

	set_stone (new_stone: STONE) is
			-- Associate current formatter with stone contained in `new_stone'.
		do
			force_stone (new_stone)
			if valid_stone_function = Void or else valid_stone_function.item ([new_stone]) then
				stone := new_stone
				must_format := True
				format
			else
				stone := Void
				reset_display
			end
			if
				selected and then
				not widget.is_displayed
			then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		end

	reset_display is
			-- Clear all graphical output.
		do
			if browser /= Void then
				browser.reset_display
			end
		end

	set_valid_stone_function (a_valid_stone_function: like valid_stone_function) is
			-- Set `valid_stone_function' with `a_valid_stone_function'.
		require
			a_valid_stone_function_attached: a_valid_stone_function /= Void
		do
			valid_stone_function := a_valid_stone_function
		ensure
			valid_stone_function_set: valid_stone_function = a_valid_stone_function
		end

	format is
			-- Refresh `widget' if `must_format' and `selected'.
		do
			if stone /= Void and then selected and then displayed and then actual_veto_format_result then
				if is_valid then
					retrieve_sorting_order
					display_temp_header
					if not widget.is_displayed then
						widget.show
					end
					setup_viewpoint
					generate_result
					display_header
				end
			end
		end

	generate_result is
			-- Generate result for `stone'.
		local
			l_domain_item: EB_METRIC_DOMAIN_ITEM
			l_retried: BOOLEAN
			l_metric: EB_METRIC
			l_value: DOUBLE
			l_domain: EB_METRIC_DOMAIN
		do
			if not l_retried then
				check metric_manager.is_metric_valid (metric) end
				l_domain_item := metric_domain_item_from_stone (stone)

				if l_domain_item /= Void then
					l_metric := metric_manager.metric_with_name (metric)
					l_metric.enable_fill_domain
					if is_filter_enabled then
						l_metric.enable_filter_result
					else
						l_metric.disable_filter_result
					end
					create l_domain.make
					l_domain.extend (l_domain_item)
					l_value := l_metric.value_item (l_domain)
					browser.set_starting_element (l_domain_item.query_language_item)
					if l_metric.is_basic and then l_metric.unit.scope /= Void then
						browser.update (Void, l_metric.last_result_domain)
					else
						browser.update (Void, l_value)
					end
				else
					browser.reset_display
				end
			else
				browser.set_trace (exception_trace)
				browser.update (Void, Void)
			end
		rescue
			l_retried := True
			retry
		end

	set_is_filter_enabled (b: BOOLEAN) is
			-- Set `is_filter_enabled' with `b'.
		do
			is_filter_enabled := b
		ensure
			is_filter_enabled_set: is_filter_enabled = b
		end

	set_viewer (a_viewer: like viewer) is
			-- Set `viewer' with `a_viewer'.
		require
			a_viewer_attached: a_viewer /= Void
		do
			viewer := a_viewer.twin
		ensure
			viewer_set: viewer /= Void and then viewer.is_equal (a_viewer)
		end

	set_icon_location (a_location: like icon_location) is
			-- Set `icon_location' with `a_location'.
		do
			if a_location = Void then
				icon_location := Void
			else
				create icon_location.make_from_string (a_location)
			end
			set_is_pixmap_loaded (False)
		end

	set_descriptor (a_descriptor: like descriptor) is
			-- Set `descriptor' with `a_descriptor'.
		do
			descriptor := a_descriptor
		ensure
			descriptor_attached: descriptor /= Void
		end

	set_tool (a_tool: like tool) is
			-- Set `tool' with `a_tool'.
		require
			a_tool_attached: a_tool /= Void
		do
			create tool.make_from_string (a_tool)
		ensure
			tool_set: tool.is_equal (a_tool)
		end

	enable_sensitive is
			-- Set both the `associated_button' and
			-- `associated_menu_entry' to be sensitive.
		do
			if is_valid then
				Precursor
			else
				disable_sensitive
			end
		end

feature{NONE} -- Implementation/Data

	command_name_internal: like command_name
			-- Implementation of `command_name'

	header_internal: like header
			-- Implementation of `header'

	temp_header_internal: like header
			-- Implementation of `temp_header'

	menu_name_internal: like menu_name
			-- Implementation of `menu_name'

	pixmap: EV_PIXMAP
			-- Customized pixmap for Current formatter

	placeholder: STRING_GENERAL is
			-- Placeholder for header/temp_header replacement.
		do
			create {STRING_32} Result.make_from_string ("$target")
		ensure
			result_attached: Result /= Void
		end

	symbol_internal: like symbol
			-- Implementation of `symbol'

	viewer_table: HASH_TABLE [FUNCTION [ANY, TUPLE [EB_DEVELOPMENT_WINDOW, EV_PND_ACTION_SEQUENCE], like browser], STRING] is
			-- Table to retrieve builder agents for viewer whose type name is given as argument
		do
			if viewer_table_internal = Void then
				create viewer_table_internal.make (2)
				viewer_table_internal.put (agent new_class_flat_browser, "feature_flat")
			end
			Result := viewer_table_internal
		ensure
			result_attached: Result /= Void
		end

	new_class_flat_browser (a_development_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): like browser is
			--
		do
			create {EB_CLASS_BROWSER_FLAT_VIEW} Result.make (a_development_window, a_drop_actions)
		end

	viewer_table_internal: like viewer_table
			-- Implementation of `viewer_table'

	is_pixmap_loaded: BOOLEAN
			-- Has pixmap been loaded?

	pixel_buffer_internal: like pixel_buffer
			-- Implementation of `pixel_buffer'

feature{NONE} -- Implementation/Setting

	set_command_name_internal (a_name: like command_name_internal) is
			-- Set `command_name_internal' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			command_name_internal := a_name
		ensure
			command_name_internal_set: command_name_internal = a_name
		end

	set_header_internal (a_header: like header_internal) is
			-- Set `header_internal' with` a_header'.
		require
			a_header_attached: a_header /= Void
		do
			header_internal := a_header
		ensure
			header_internal_set: header_internal = a_header
		end

	set_temp_header_internal (a_temp_header: like temp_header_internal) is
			-- Set `temp_header_internal' with` a_temp_header'.
		require
			a_temp_header_attached: a_temp_header /= Void
		do
			temp_header_internal := a_temp_header
		ensure
			temp_header_internal_set: temp_header_internal = a_temp_header
		end

	set_menu_name_internal (a_name: like menu_name_internal) is
			-- Set `menu_name_internal' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			menu_name_internal := a_name
		ensure
			menu_name_internal_set: menu_name_internal = a_name
		end

	load_pixmap is
			-- Load pixmap.
		local
			l_pixmap_loader: EB_PIXMAP_LOAD_HELPER
			l_result: TUPLE [a_pixmap: EV_PIXMAP; a_buffer: EV_PIXEL_BUFFER]
		do
			create l_pixmap_loader
			l_result := l_pixmap_loader.loaded_pixmap_from_file (icon_location, pixmaps.icon_pixmaps.diagram_export_to_png_icon, pixmaps.icon_pixmaps.diagram_export_to_png_icon_buffer)
			l_result.a_pixmap.stretch (16, 16)
			set_pixmap (l_result.a_pixmap)
			pixel_buffer_internal := l_result.a_buffer
			set_is_pixmap_loaded (True)
		ensure
			pixmap_attached: pixmap /= Void
			pixel_buffer_attached: pixel_buffer_internal /= Void
		end

	set_is_pixmap_loaded (b: BOOLEAN) is
			-- Set `is_pixmap_loaded' with `b'.
		do
			is_pixmap_loaded := b
		ensure
			is_pixmap_loaded_set: is_pixmap_loaded = b
		end

invariant
	command_name_internal_attached: command_name_internal /= Void
	header_internal_attached: header_internal /= Void
	temp_header_internal_attached: temp_header_internal /= Void
	menu_name_internal_attached: menu_name_internal /= Void
	browser_attached: browser /= Void

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
