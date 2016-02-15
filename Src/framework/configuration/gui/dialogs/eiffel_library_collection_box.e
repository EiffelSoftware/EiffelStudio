note
	description: "[
			Box containing the list of available libraries, 
			with name, void-safety compatibility, location
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LIBRARY_COLLECTION_BOX

inherit
	CONF_GUI_INTERFACE_CONSTANTS

	SHARED_BENCH_NAMES

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_target: like target)
		do
			target := a_target
			create on_library_selected_actions
			create box
			build_interface (box)
		end

	build_interface (b: EV_VERTICAL_BOX)
		local
			g: like libraries_grid
			l_col: EV_GRID_COLUMN
		do
			create g
			libraries_grid := g
--			g.set_minimum_size (400, 200)
			g.enable_always_selected
			g.enable_single_row_selection
			g.set_column_count_to (location_column)
			l_col := g.column (name_column)
			l_col.set_title (conf_interface_names.dialog_create_library_name)
			l_col.set_width (100)
			l_col := g.column (void_safety_column)
			l_col.set_title (conf_interface_names.dialog_create_library_void_safety)
			l_col.set_width (100)
			l_col := g.column (location_column)
			l_col.set_title (conf_interface_names.dialog_create_library_location)
			l_col.set_width (100)
			g.disable_column_separators
			g.disable_row_separators
			g.disable_border

			b.extend (g)
			libraries_grid := g
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget representing Current box.
		do
			Result := box
		end

	target: CONF_TARGET
			-- Target where we add the group.

	configuration_libraries_by_location: detachable STRING_TABLE [CONF_SYSTEM_VIEW] assign set_configuration_libraries
			-- CONF_SYSTEM_VIEW indexed by path.

	libraries_location_by_name: detachable STRING_TABLE [READABLE_STRING_GENERAL]
			-- Path indexed by library target name.

	libraries_sorted_keys: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Sorted library target names.

feature -- Change

	set_configuration_libraries (a_libraries: like configuration_libraries_by_location)
		local
			l_libraries_table: detachable STRING_TABLE [READABLE_STRING_GENERAL] --like libraries_table
			l_libraries_sorted_keys: detachable ARRAYED_LIST [READABLE_STRING_GENERAL] --like libraries_sorted_keys
			l_path: READABLE_STRING_GENERAL
			l_key: STRING_32
			l_sorter: QUICK_SORTER [READABLE_STRING_GENERAL]
			l_target_name: READABLE_STRING_32
		do
			configuration_libraries_by_location := a_libraries
			if a_libraries /= Void then
					-- Create a table of path names indexed by target_name#library_path, used to effectively sort.
				create l_libraries_table.make (a_libraries.count)
				create l_libraries_sorted_keys.make (a_libraries.count)
				from a_libraries.start until a_libraries.after loop
					l_target_name := a_libraries.item_for_iteration.library_target_name

					l_path := a_libraries.key_for_iteration
					create l_key.make (256)
					l_key.append_string_general (l_target_name)
					l_key.append_string_general (once " # ")
					l_key.append_string_general (l_path)
					l_libraries_table.force (l_path, l_key)

					l_libraries_sorted_keys.force (l_key)
					a_libraries.forth
				end

					-- Sort keys
				create l_sorter.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]})
				l_sorter.sort (l_libraries_sorted_keys)

				libraries_location_by_name := l_libraries_table
				libraries_sorted_keys := l_libraries_sorted_keys
			else
				libraries_location_by_name := Void
				libraries_sorted_keys := Void
			end
		end

feature -- Callback

	on_library_selected (a_library: CONF_SYSTEM_VIEW; a_location: READABLE_STRING_GENERAL)
			-- Called when a library is selected
		require
			has_library_target: a_library.has_library_target
		do
			on_library_selected_actions.call ([a_library, a_location])
		end

	on_library_selected_actions: ACTION_SEQUENCE [TUPLE [lib: CONF_SYSTEM_VIEW; location: READABLE_STRING_GENERAL]]
			-- Actions to be triggered when a package is selected.		

feature -- Event

	hide
		do
			widget.hide
		end

	show
		do
			widget.show
		end

	set_focus
		do
			libraries_grid.set_focus
		end

	set_minimum_size (w,h: INTEGER)
		do
			libraries_grid.set_minimum_size (w, h)
		end

	update_grid
			-- Update grid
		require
			libraries_table_attached: libraries_location_by_name /= Void
			libraries_sorted_keys_attached: libraries_sorted_keys /= Void
			populated_configuration_libraries_attached: configuration_libraries_by_location /= Void
		local
			l_libraries_sorted_keys: like libraries_sorted_keys
			l_libraries_table: like libraries_location_by_name
			l_libraries: like configuration_libraries_by_location
			l_libraries_grid: like libraries_grid
			l_row: EV_GRID_ROW
			l_item: EV_GRID_LABEL_ITEM
			l_col: EV_GRID_COLUMN
			l_name_width: INTEGER
			l_void_safety_width: INTEGER
			l_path: READABLE_STRING_GENERAL
			l_description: READABLE_STRING_32
		do
			l_libraries_grid := libraries_grid
			l_libraries_grid.remove_and_clear_all_rows

			l_libraries_table := libraries_location_by_name
			l_libraries_sorted_keys := libraries_sorted_keys
			if
				l_libraries_table /= Void and
				l_libraries_sorted_keys /= Void and then
				l_libraries_sorted_keys.count > 0
			then

				l_libraries := configuration_libraries_by_location

					-- Build libraries list
				l_libraries_grid.set_row_count_to (l_libraries_sorted_keys.count)
				from l_libraries_sorted_keys.start until l_libraries_sorted_keys.after loop
					l_row := l_libraries_grid.row (l_libraries_sorted_keys.index)

						-- Fetch path from sortable key name
					l_path :=  l_libraries_table.item (l_libraries_sorted_keys.item_for_iteration)
					check
						l_path_attached: l_path /= Void
						l_libraries_has_l_path: l_libraries.has (l_path)
					end

					if attached l_libraries.item (l_path) as l_cfg_data then

							-- Extract description
						l_description := l_cfg_data.description
						if l_description = Void or else l_description.is_empty then
							l_description := once "No description available for library"
						end

							-- Library name
--						create l_item.make_with_text (l_cfg_data.library_target_name)
						create l_item.make_with_text (l_cfg_data.system_name)
						l_item.set_tooltip (l_description)
						l_row.set_item (name_column, l_item)
						l_name_width := l_name_width.max (l_item.required_width + 10)

							-- Void safety status.
						if attached l_cfg_data.conf_option as l_options then
							create l_item.make_with_text (conf_interface_names.option_void_safety_value [l_options.void_safety.index])
							l_item.set_tooltip (conf_interface_names.option_void_safety_value_description [l_options.void_safety.index])
							if l_options.is_void_safety_supported (target.options) then
									-- Library void-safety setting perfectly matches the one used by the target.
								l_item.set_pixmap (conf_pixmaps.general_tick_icon)
							elseif l_options.is_void_safety_sufficient (target.options) then
									-- Library void-safety setting is usable by the target with a warning.
								l_item.set_pixmap (conf_pixmaps.general_warning_icon)
							else
									-- Library void-safety setting is too weak for the target.
								l_row.hide
							end
							l_row.set_item (void_safety_column, l_item)
							l_void_safety_width := l_void_safety_width.max (l_item.required_width + 10)
						else
							l_row.hide
						end

							-- Location
						create l_item.make_with_text (l_path)
						l_item.set_tooltip (l_path)
						l_row.set_item (location_column, l_item)

						l_row.select_actions.extend (agent on_library_selected (l_cfg_data, l_path))
						l_row.set_data (l_cfg_data)
					else
						check has_library_target: False end
					end

					l_libraries_sorted_keys.forth
				end

				l_col := l_libraries_grid.column (name_column)
				if l_col.width < l_name_width then
					l_col.set_width (l_name_width)
				end
			end
		end

feature -- Widgets		

	box: EV_VERTICAL_BOX

	libraries_grid: ES_GRID

feature {NONE} -- Constants

	name_column: INTEGER = 1
			-- Index of a column with a library name.

	void_safety_column: INTEGER = 2
			-- Index of a column with void-safety status.

	location_column: INTEGER = 3
			-- Index of a column with a library location.

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
