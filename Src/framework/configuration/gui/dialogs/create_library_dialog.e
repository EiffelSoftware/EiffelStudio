note
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

	initialize
			-- Initialize.
		local
			l_void_safe_check: EV_CHECK_BUTTON
			l_btn: EV_BUTTON
			vb, vb2, l_padding: EV_VERTICAL_BOX
			hb, hbf, hb1, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_col: EV_GRID_COLUMN
			l_filter: like filter
			l_clear_filter_button: EV_BUTTON
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

			create hb1
			hb1.set_padding (layout_constants.small_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_defaults)
			l_lbl.align_text_left
			hb1.extend (l_lbl)
			hb1.disable_item_expand (l_lbl)

			create hbf
			hb1.extend (create {EV_HORIZONTAL_SEPARATOR})
			hb1.extend (hbf)

			hbf.extend (create {EV_LABEL}.make_with_text (Names.l_filter))
			hbf.disable_item_expand (hbf.last)
			create l_filter
			filter := l_filter
			hbf.extend (l_filter)
			l_filter.change_actions.extend (agent request_update_filter)

			create l_clear_filter_button
			l_clear_filter_button.select_actions.extend (agent l_filter.remove_text)
			l_clear_filter_button.set_pixmap (conf_pixmaps.general_remove_icon)
			l_clear_filter_button.set_tooltip (names.b_reset)
			hbf.extend (l_clear_filter_button)
			hbf.disable_item_expand (l_clear_filter_button)


			vb2.extend (hb1)
			vb2.disable_item_expand (hb1)
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

				-- Void-Safe check
			if target.options.void_safety.index = {CONF_OPTION}.void_safety_index_all then
				create l_void_safe_check.make_with_text ("Show only Void-Safe libraries")
				l_void_safe_check.enable_select
				l_void_safe_check.select_actions.extend (agent on_void_safe_check_selected)
				vb2.extend (l_void_safe_check)
				vb2.disable_item_expand (l_void_safe_check)

				void_safe_check := l_void_safe_check
			end

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
				do
					populate_libraries
					libraries_grid.set_focus
				end)
		end

feature {NONE} -- Update filter

	update_filter_timeout: detachable EV_TIMEOUT

	request_update_filter
		local
			l_update_filter_timeout: like update_filter_timeout
		do
			cancel_delayed_update_filter
			l_update_filter_timeout := update_filter_timeout
			if l_update_filter_timeout = Void then
				create l_update_filter_timeout
				update_filter_timeout := l_update_filter_timeout
				l_update_filter_timeout.actions.extend_kamikaze (agent delayed_update_filter)
			end
			l_update_filter_timeout.set_interval (700)
		end

	cancel_delayed_update_filter
		do
			if attached update_filter_timeout as l_update_filter_timeout then
				l_update_filter_timeout.destroy
				update_filter_timeout := Void
			end
		end

	delayed_update_filter
		do
			cancel_delayed_update_filter
			update_filter
		end

	update_filter
		local
			l_style: EV_POINTER_STYLE
		do
			l_style := pointer_style
			set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))
			update_grid
			set_pointer_style (l_style)
		end

feature {NONE} -- GUI elements

	void_safe_check: detachable EV_CHECK_BUTTON
			-- Void-safe check button

	libraries_grid: ES_GRID
			-- Libraries grid

	filter: EV_TEXT_FIELD
			-- Filter

	name: EV_TEXT_FIELD
			-- Name of the library.

	location: EV_TEXT_FIELD
			-- Location of the library configuration file, choosen by the user.

	browse_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a library
		local
			l_dir: DIRECTORY_32
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

	libraries: SEARCH_TABLE [STRING]
			-- A set of libraries to display in the dialog
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_dirs: like lookup_directories
			l_libraries: SEARCH_TABLE [STRING]
			l_dir: DIRECTORY
			l_path: STRING
			l_location: CONF_DIRECTORY_LOCATION
		do
			l_dirs := lookup_directories
			create Result.make (l_dirs.count)
			from l_dirs.start until l_dirs.after loop
				create l_location.make (l_dirs.item_for_iteration.path, target)
				l_path := l_location.evaluated_path.as_string_8
				create l_dir.make (l_path)
				if l_dir.is_readable then
					create l_libraries.make (10)
					add_configs_in_directory (l_dir, l_dirs.item_for_iteration.depth, l_libraries)
					from l_libraries.start until l_libraries.after loop
						l_libraries.item_for_iteration.replace_substring (l_dirs.item_for_iteration.path, 1, l_path.count)
						l_libraries.forth
					end
					Result.merge (l_libraries)
				end
				l_dirs.forth
			end
		ensure
			result_attached: attached Result
		end

	configuration_libraries: HASH_TABLE [CONF_SYSTEM, STRING]
			-- A set of libraries configurations to display in the dialog
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_libs: like libraries
			l_loader: CONF_LOAD
			l_factory: CONF_PARSE_FACTORY
			l_location: CONF_DIRECTORY_LOCATION
		do
			l_libs := libraries
			create Result.make (l_libs.count)

			create l_factory
			from l_libs.start until l_libs.after loop
				create l_loader.make (l_factory)
				create l_location.make (l_libs.item_for_iteration, target)
				l_loader.retrieve_configuration (l_location.evaluated_path)
				if
					not l_loader.is_error and then
					attached l_loader.last_system as l_system and then
					attached l_system.library_target as l_target
				then
					Result.force (l_system, l_libs.item_for_iteration)
				end
				l_libs.forth
			end
		ensure
			result_attached: attached Result
		end

	lookup_directories: ARRAYED_LIST [TUPLE [path: STRING; depth: INTEGER]]
			-- A list of lookup directories
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_filename: FILE_NAME
			l_file: RAW_FILE
		do
			create Result.make (10)

			l_filename := eiffel_layout.libraries_config_name
			create l_file.make (l_filename)
			if l_file.exists then
				add_lookup_directories (l_filename, Result)
			end
			if eiffel_layout.is_user_files_supported then
				l_filename := eiffel_layout.user_priority_file_name (l_filename.string, True)
				if l_filename /= Void then
					l_file.reset (l_filename)
					if l_file.exists then
						add_lookup_directories (l_filename, Result)
					end
				end
			end

			if Result.is_empty then
					-- Extend the default library path
				Result.extend ([eiffel_layout.library_path.string.as_attached, 2])
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Actions

	browse
			-- Browse for a location.
		local
			l_loader: CONF_LOAD
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
			if attached browse_dialog.file_name as l_fn and then not l_fn.is_empty then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (l_fn)
				if not l_loader.is_error and then attached l_loader.last_system as l_system then
					if not attached l_system.library_target as l_target then
						prompts.show_error_prompt (conf_interface_names.file_is_not_a_library, Current, Void)
					elseif (not attached void_safe_check as l_check) or else (not l_check.is_selected or else l_target.options.void_safety.index = {CONF_OPTION}.void_safety_index_all) then
						on_library_selected (l_system, l_fn.as_string_8)
					else
						prompts.show_question_prompt (conf_interface_names.add_non_void_safe_library, Current, agent on_library_selected (l_system, l_fn.as_string_8.as_attached), Void)
					end
				end
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: CONF_SYSTEM; a_location: STRING)
			-- Called when a library is selected
		require
			has_library_target: a_library.library_target /= Void
		do
			name.set_text (a_library.library_target.name)
			location.set_text (a_location)
		end

	on_void_safe_check_selected
			-- Called when the Void-Safe option is selected
		require
			void_safe_check_attached: void_safe_check /= Void
			libraries_grid_attached: libraries_grid /= Void
		local
			l_grid: like libraries_grid
			l_row: EV_GRID_ROW
			l_show_all: BOOLEAN
			i, nb: INTEGER
		do
			l_grid := libraries_grid

			l_grid.lock_update
			l_show_all := not void_safe_check.is_selected
			from
				i := 1
				nb := l_grid.row_count
			until
				i > nb
			loop
				l_row := l_grid.row (i)
				if
					l_show_all or else (
						attached {CONF_TARGET} l_row.data as l_target and then
						l_target.options.void_safety.index = {CONF_OPTION}.void_safety_index_all
					)
				then
					l_row.show
				else
					l_row.hide
				end
				i := i + 1
			end
			l_grid.unlock_update
		end

	on_ok
			-- Add library and close the dialog.
		local
			l_sys: CONF_SYSTEM
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_library_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					last_group := factory.new_library (name.text, location.text, target)
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

	populated_configuration_libraries: detachable like configuration_libraries
	libraries_table: detachable HASH_TABLE [STRING, STRING]
	libraries_sorted_keys: detachable ARRAYED_LIST [STRING]

	populate_libraries
			-- Populates the list of libraries in the UI
		local
			l_libraries: like configuration_libraries
			l_libraries_table: like libraries_table
			l_libraries_sorted_keys: like libraries_sorted_keys
			l_target: CONF_TARGET
			l_path: STRING
			l_key: STRING
			l_style: EV_POINTER_STYLE
			l_sorter: QUICK_SORTER [STRING]
		do
			l_style := pointer_style
			set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

			l_libraries := configuration_libraries
			populated_configuration_libraries := l_libraries

				-- Create a table of path names indexed by target_name#library_path, used to effectively sort.
			create l_libraries_table.make (l_libraries.count)
			from l_libraries.start until l_libraries.after loop
				l_target := l_libraries.item_for_iteration.library_target
				if l_target /= Void then
					l_path := l_libraries.key_for_iteration
					create l_key.make (256)
					l_key.append_string (l_target.name)
					l_key.append_string (once " # ")
					l_key.append_string (l_path)
					l_libraries_table.force (l_path, l_key)
				end
				l_libraries.forth
			end

				-- Sort keys
			create l_libraries_sorted_keys.make_from_array (l_libraries_table.current_keys)
			create l_sorter.make (create {COMPARABLE_COMPARATOR [STRING]})
			l_sorter.sort (l_libraries_sorted_keys)

			libraries_table := l_libraries_table
			libraries_sorted_keys := l_libraries_sorted_keys

			update_grid
			set_pointer_style (l_style)
		end

	update_grid
			-- Update grid
		require
			libraries_table_attached: libraries_table /= Void
			libraries_sorted_keys_attached: libraries_sorted_keys /= Void
			populated_configuration_libraries_attached: populated_configuration_libraries /= Void
		local
			l_libraries_sorted_keys: like libraries_sorted_keys
			l_libraries_table: like libraries_table
			l_libraries: like populated_configuration_libraries
			l_libraries_grid: like libraries_grid
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			l_row: EV_GRID_ROW
			l_item: EV_GRID_LABEL_ITEM
			l_col: EV_GRID_COLUMN
			l_name_width: INTEGER
			l_path: STRING
			l_key: STRING
			l_description: STRING
			l_void_safe_check: like void_safe_check
			l_show_void_safe_only: BOOLEAN
			l_filter: detachable STRING
			l_filter_engine: detachable KMP_WILD
			l_matched: BOOLEAN
		do
			l_libraries_grid := libraries_grid
			l_libraries_grid.remove_and_clear_all_rows

			l_libraries_table := libraries_table
			l_libraries_sorted_keys := libraries_sorted_keys
			if l_libraries_table /= Void and l_libraries_sorted_keys /= Void and then l_libraries_sorted_keys.count > 0 then
				l_void_safe_check := void_safe_check
				l_show_void_safe_only := l_void_safe_check /= Void and then l_void_safe_check.is_selected

				l_libraries := populated_configuration_libraries

					-- And filter if pattern specified
				l_filter := filter.text
				l_filter.left_adjust
				l_filter.right_adjust
				if l_filter.is_empty then
					l_filter := Void
				else
					if l_filter.item (1) /= '*' then
						l_filter.prepend_character ('*')
					end
					if l_filter.item (l_filter.count) /= '*' then
						l_filter.append_character ('*')
					end
					create l_filter_engine.make_empty
					l_filter_engine.set_pattern (l_filter)
					l_filter_engine.disable_case_sensitive
				end

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

					l_system := l_libraries.item (l_path)
					l_target := l_system.library_target
					check l_target_attached: l_target /= Void end

						-- Extract description
					l_description := l_system.description
					if l_description = Void or else l_description.is_empty then
						l_description := l_target.description
						if l_description = Void or else l_description.is_empty then
							l_description := once "No description available for library"
						end
					end

					if l_show_void_safe_only and then l_target.options.void_safety.index /= {CONF_OPTION}.void_safety_index_all then
							-- The library is not Void-Safe, hide it if showing only Void-Safe libraries.
						l_row.hide
					else
						if l_filter_engine /= Void then
							l_filter_engine.set_text (l_target.name)
							if not l_filter_engine.pattern_matches then
								l_row.hide
							end
						else
							l_row.show
						end
					end

						-- Library name
					create l_item.make_with_text (l_system.name)
					l_item.set_tooltip (l_description)
					l_row.set_item (name_column, l_item)
					l_name_width := l_name_width.max (l_item.required_width + 10)

						-- Location
					create l_item.make_with_text (l_path)
					l_item.set_tooltip (l_path)
					l_row.set_item (location_column, l_item)

					l_row.select_actions.extend (agent on_library_selected (l_system, l_path))
					l_row.set_data (l_target)

					l_libraries_sorted_keys.forth
				end

				l_col := l_libraries_grid.column (name_column)
				if l_col.width < l_name_width then
					l_col.set_width (l_name_width)
				end
			end
		end

	add_configs_in_directory (a_dir: DIRECTORY; a_depth: INTEGER; a_libraries: SEARCH_TABLE [STRING])
			-- Add config files in `a_path' to `a_libraries'.
		require
			a_dir_attached: attached a_dir
			a_dir_is_readable: a_dir.is_readable
			a_depth_big_enough: a_depth >= -1
			a_libraries_attached: attached a_libraries
		local
			l_dir_name: DIRECTORY_NAME
			l_count, i: INTEGER
			l_lib_file: STRING
			l_file_name: FILE_NAME
			l_file_string: STRING
			l_file: RAW_FILE
		do
			if attached a_dir.linear_representation as l_items then
				across l_items as l_files loop
					l_lib_file := l_files.item
					if valid_config_extension (l_lib_file) then
						create l_file_name.make_from_string (a_dir.name)
						l_file_name.extend (l_lib_file)
						create l_file.make (l_file_name)
						if l_file.exists and then l_file.is_plain then
							if {PLATFORM_CONSTANTS}.is_windows then
								l_file_string := l_file_name.string.as_lower
							else
								l_file_string := l_file_name.string
							end
							if not a_libraries.has (l_file_string) then
								a_libraries.force (l_file_string)
							end
						end
					end
				end

				if (a_depth = -1 or a_depth > 0) and then attached a_dir.linear_representation as l_subdirs then
						-- Perform recursion
					across l_subdirs as l_dirs loop
						if l_dirs.item /~ "." and l_dirs.item /~ ".." then
							create l_dir_name.make_from_string (a_dir.name)
							l_dir_name.extend (l_dirs.item)
							create l_file.make (l_dir_name)
							if l_file.exists and then l_file.is_directory then
								add_configs_in_directory (create {DIRECTORY}.make (l_dir_name), (a_depth - 1).max (-1), a_libraries)
							end
						end
					end
				end
			end
		end

	add_lookup_directories (a_path: FILE_NAME; a_list: ARRAYED_LIST [TUPLE [path: STRING; depth: INTEGER]])
			-- Adds look up directories from a file located at `a_path' into `a_list'
		require
			a_path_attached: attached a_path
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
			a_list_attached: attached a_list
		local
			l_file: RAW_FILE
			l_line: STRING
			l_pos: INTEGER
			l_location: STRING
			l_depth_string: STRING
			l_depth: INTEGER
		do
			create l_file.make (a_path)

			if l_file /= Void and then l_file.is_readable then
				from l_file.open_read until l_file.end_of_file loop
					l_file.read_line
					l_line := l_file.last_string
					if not l_line.is_empty then
						l_line.left_adjust
						l_line.right_adjust
						l_pos := l_line.last_index_of ('%T', l_line.count)
						if l_pos > 1 then
							l_location := l_line.substring (1, l_pos - 1)
							l_location.right_adjust
							if l_pos < l_line.count then
								l_depth_string := l_line.substring (l_pos + 1, l_line.count)
								l_depth_string.left_adjust
							end
						else
							l_location := l_line
						end
						if l_depth_string /= Void and then l_depth_string.is_integer then
							l_depth := l_depth_string.to_integer
						else
							l_depth := 1
						end
						a_list.extend ([l_location.as_attached, l_depth])
					end
				end
			end
		end

feature {NONE} -- Constants

	name_column: INTEGER = 1
	location_column: INTEGER = 2

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
