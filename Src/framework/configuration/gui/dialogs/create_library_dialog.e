indexing
	description: "Dialog to add a library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_LIBRARY_DIALOG

inherit
	CREATE_GROUP_DIALOG
		redefine
			initialize,
			last_group
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_VALIDITY
		undefine
			copy,
			default_create
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			l_btn: EV_BUTTON
			vb, vb2, l_padding: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_col: EV_GRID_COLUMN
		do
			Precursor

			set_title (conf_interface_names.dialog_create_library_title)
			set_icon_pixmap (conf_pixmaps.new_library_icon)

			create vb
			extend (vb)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

				-- default libraries
			create vb2
			vb.extend (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_defaults)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

				-- Create grid
			create libraries_grid
			libraries_grid.set_minimum_size (400, 200)
			libraries_grid.enable_always_selected
			libraries_grid.enable_single_row_selection
			libraries_grid.set_column_count_to (location_column)
			l_col := libraries_grid.column (name_column)
			l_col.set_title ("Name")
			l_col.set_width (100)
			l_col := libraries_grid.column (location_column)
			l_col.set_title ("Location")
			l_col.set_width (100)
			libraries_grid.disable_column_separators
			libraries_grid.disable_row_separators
			libraries_grid.disable_border

				-- Create border for the grid
			create l_padding
			l_padding.set_border_width (1)
			l_padding.set_background_color ((create {EV_STOCK_COLORS}).color_3d_shadow)
			l_padding.extend (libraries_grid)

			vb2.extend (l_padding)

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb2.extend (name)
			vb2.disable_item_expand (name)

				-- location
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_location)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb2.extend (hb2)
			vb2.disable_item_expand (hb2)
			hb2.set_padding (layout_constants.small_padding_size)

			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (conf_interface_names.browse, agent browse)
			l_btn.set_pixmap (conf_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create l_btn.make_with_text (names.b_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			layout_constants.set_default_width_for_button (l_btn)

			create l_btn.make_with_text (names.b_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)

			show_actions.extend_kamikaze (agent
				local
					l_style: EV_POINTER_STYLE
				do
					l_style := pointer_style
					set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))
					populate_libraries
					set_pointer_style (l_style)

					libraries_grid.set_focus
				end)
		end

feature {NONE} -- GUI elements

	libraries_grid: ES_GRID
			-- Libraries grid

	name: EV_TEXT_FIELD
			-- Name of the library.

	location: EV_TEXT_FIELD
			-- Location of the library configuration file, choosen by the user.

	browse_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a library
		local
			l_dir: KL_DIRECTORY
		once
			create Result
			create l_dir.make (target.system.directory)
			if l_dir.is_readable then
				Result.set_start_directory (l_dir.name)
			end
			Result.filters.extend ([config_files_filter, config_files_description])
			Result.filters.extend ([all_files_filter, all_files_description])
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access

	last_group: CONF_LIBRARY
			-- Last created group.

feature {NONE} -- Access

	libraries: !DS_HASH_SET [!STRING]
			-- A set of libraries to display in the dialog
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_dirs: !like lookup_directories
			l_libraries: !DS_HASH_SET [!STRING]
			l_dir: !KL_DIRECTORY
			l_path: !STRING
			l_location: !CONF_DIRECTORY_LOCATION
		do
			create Result.make_default
			l_dirs := lookup_directories
			from l_dirs.start until l_dirs.after loop
				create l_location.make (l_dirs.item_for_iteration.path, target)
				l_path ?= l_location.evaluated_path.as_string_8
				create l_dir.make (l_path)
				if l_dir.is_readable then
					create l_libraries.make_default
					add_configs_in_directory (l_dir, l_dirs.item_for_iteration.depth, l_libraries)
					from l_libraries.start until l_libraries.after loop
						l_libraries.item_for_iteration.replace_substring (l_dirs.item_for_iteration.path, 1, l_path.count)
						l_libraries.forth
					end
					Result.merge (l_libraries)
				end
				l_dirs.forth
			end
		end

	configuration_libraries: !DS_HASH_TABLE [!CONF_SYSTEM, !STRING]
			-- A set of libraries configurations to display in the dialog
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_libs: !like libraries
			l_loader: CONF_LOAD
			l_factory: CONF_PARSE_FACTORY
			l_location: !CONF_DIRECTORY_LOCATION
		do
			l_libs := libraries
			create Result.make (l_libs.count)

			create l_factory
			from l_libs.start until l_libs.after loop
				create l_loader.make (l_factory)
				create l_location.make (l_libs.item_for_iteration, target)
				l_loader.retrieve_configuration (l_location.evaluated_path)
				if not l_loader.is_error and then {l_system: CONF_SYSTEM} l_loader.last_system and then {l_target: CONF_TARGET} l_system.library_target then
					Result.put_last (l_system, l_libs.item_for_iteration)
				end
				l_libs.forth
			end
		end

	lookup_directories: !DS_ARRAYED_LIST [!TUPLE [path: !STRING; depth: INTEGER]]
			-- A list of lookup directories
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_file: !FILE_NAME
		do
			create Result.make_default

			l_file := eiffel_layout.libraries_config_name
			if file_system.file_exists (l_file) then
				add_lookup_directories (l_file, Result)
			end
			if eiffel_layout.is_user_files_supported then
				if {l_user_file: FILE_NAME} eiffel_layout.user_priority_file_name (l_file.string, True) and then file_system.file_exists (l_user_file) then
					add_lookup_directories (l_user_file, Result)
				end
			end

			if Result.is_empty then
					-- Extend the default library path
				Result.force_last ([eiffel_layout.library_path.string.as_attached, 2])
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Actions

	browse
			-- Browse for a location.
		local
			l_loader: CONF_LOAD
			l_factory: CONF_PARSE_FACTORY
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
		do
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make (l_loc.evaluated_directory)
			end
			if l_dir /= Void and then l_dir.exists then
				browse_dialog.set_start_directory (l_dir.name)
			end

			browse_dialog.show_modal_to_window (Current)
			if {l_fn: STRING_32} browse_dialog.file_name and then not l_fn.is_empty then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (l_fn)
				if not l_loader.is_error and then {l_system: CONF_SYSTEM} l_loader.last_system and then {l_target: CONF_TARGET} l_system.library_target then
					on_library_selected (l_system, l_fn.as_string_8.as_attached)
				end
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: !CONF_SYSTEM; a_location: !STRING)
			-- Called when a library is selected
		require
			has_library_target: a_library.library_target /= Void
		do
			name.set_text (a_library.library_target.name)
			location.set_text (a_location)
		end

	on_ok
			-- Add library and close the dialog.
		local
			l_loc: CONF_FILE_LOCATION
			l_sys: CONF_SYSTEM
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_group_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					l_loc := factory.new_location_from_full_path (location.text, target)
					last_group := factory.new_library (name.text, l_loc, target)
						-- add an empty classes list that it get's displayed in the classes tree
					last_group.set_classes (create {HASH_TABLE [CONF_CLASS, STRING]}.make (0))
					l_sys := factory.new_system_generate_uuid ("dummy")
					l_sys.set_application_target (target)
					last_group.set_library_target (factory.new_target ("dummy", l_sys))
					target.add_library (last_group)
					is_ok := True
					destroy
				end
			end
		ensure
			is_ok_last_library: is_ok implies last_group /= Void
		end

	on_cancel
			-- Close the dialog.
		do
			destroy
		end

feature {NONE} -- Basic operation

	populate_libraries
			-- Populates the list of libraries in the UI
		local
			l_libraries: !like configuration_libraries
			l_list: !DS_ARRAYED_LIST [!STRING]
			l_system: !CONF_SYSTEM
			l_target: CONF_TARGET
			l_row: EV_GRID_ROW
			l_item: EV_GRID_LABEL_ITEM
			l_col: EV_GRID_COLUMN
			l_name_width: INTEGER
			l_description: STRING
		do
			libraries_grid.remove_and_clear_all_rows
			l_libraries := configuration_libraries

			create l_list.make_from_linear (l_libraries.keys)
			l_list.sort (create {DS_QUICK_SORTER [!STRING]}.make (create {KL_COMPARABLE_COMPARATOR [!STRING]}.make))
			libraries_grid.set_row_count_to (l_list.count)
			from l_list.start until l_list.after loop
				l_row := libraries_grid.row (l_list.index)

				l_system := l_libraries.item (l_list.item_for_iteration)
				l_target := l_system.library_target
				if l_target /= Void then
						-- Extract description
					l_description := l_system.description
					if l_description = Void or else l_description.is_empty then
						l_description := l_target.description
						if l_description = Void or else l_description.is_empty then
							l_description := once "No description available"
						end
					end

						-- Library name
					create l_item.make_with_text (l_system.name)
					l_item.set_tooltip (l_description)
					l_row.set_item (name_column, l_item)
					l_name_width := l_name_width.max (l_item.required_width + 10)

						-- Location
					create l_item.make_with_text (l_list.item_for_iteration)
					l_item.set_tooltip (l_list.item_for_iteration)
					l_row.set_item (location_column, l_item)

					l_row.select_actions.extend (agent on_library_selected (l_system, l_list.item_for_iteration))
				end

				l_list.forth
			end

			l_col := libraries_grid.column (name_column)
			if l_col.width < l_name_width then
				l_col.set_width (l_name_width)
			end
		end

	add_configs_in_directory (a_dir: !KL_DIRECTORY; a_depth: INTEGER; a_libraries: !DS_HASH_SET [!STRING])
			-- Add config files in `a_path' to `a_libraries'.
		require
			a_dir_is_readable: a_dir.is_readable
			a_depth_big_enough: a_depth >= -1
		local
			l_dir_name: !DIRECTORY_NAME
			l_items: ARRAY [STRING]
			l_count, i: INTEGER
			l_lib_file: STRING
			l_file_name: !FILE_NAME
			l_file_string: !STRING
		do
			l_items := a_dir.filenames
			if l_items /= Void then
				from
					i := l_items.lower
					l_count := l_items.upper
				until
					i > l_count
				loop
					l_lib_file := l_items.item (i)
					if valid_config_extension (l_lib_file) then
						create l_file_name.make_from_string (a_dir.name)
						l_file_name.extend (l_lib_file)
						if {PLATFORM_CONSTANTS}.is_windows then
							l_file_string ?= l_file_name.string.as_lower
						else
							l_file_string ?= l_file_name.string
						end
						if not a_libraries.has (l_file_string) then
							a_libraries.force_last (l_file_string)
						end
					end
					i := i + 1
				end

				if a_depth = -1 or a_depth > 0 then
						-- Perform recursion
					l_items := a_dir.directory_names
					from
						i := l_items.lower
						l_count := l_items.upper
					until
						i > l_count
					loop
						create l_dir_name.make_from_string (a_dir.name)
						l_dir_name.extend (l_items.item (i))
						if file_system.directory_exists (l_dir_name) then
							add_configs_in_directory (create {KL_DIRECTORY}.make (l_dir_name), (a_depth - 1).max (-1), a_libraries)
						end
						i := i + 1
					end
				end
			end
		end

	add_lookup_directories (a_path: !FILE_NAME; a_list: !DS_ARRAYED_LIST [!TUPLE [path: !STRING; depth: INTEGER]])
			-- Adds look up directories from a file located at `a_path' into `a_list'
		require
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: file_system.file_exists (a_path)
		local
			l_file: KI_TEXT_INPUT_FILE
			l_line: STRING
			l_pos: INTEGER
			l_location: !STRING
			l_depth_string: STRING
			l_depth: INTEGER
		do
			l_file := file_system.new_input_file (a_path)
			if l_file /= Void and then l_file.is_readable then
				from l_file.open_read until l_file.end_of_file loop
					l_file.read_line
					l_line := l_file.last_string
					if not l_line.is_empty then
						l_line.left_adjust
						l_line.right_adjust
						l_pos := l_line.last_index_of ('%T', l_line.count)
						if l_pos > 1 then
							l_location ?= l_line.substring (1, l_pos - 1)
							l_location.right_adjust
							if l_pos < l_line.count then
								l_depth_string := l_line.substring (l_pos + 1, l_line.count)
								l_depth_string.left_adjust
							end
						else
							l_location ?= l_line
						end
						if l_depth_string /= Void and then l_depth_string.is_integer then
							l_depth := l_depth_string.to_integer
						else
							l_depth := 1
						end
						a_list.force_last ([l_location, l_depth])
					end
				end
			end
		end

feature {NONE} -- Constants

	name_column: INTEGER = 1
	location_column: INTEGER = 2

;indexing
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
