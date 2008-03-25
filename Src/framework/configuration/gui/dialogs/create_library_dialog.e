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
			vb, vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
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

			create default_libraries
			vb2.extend (default_libraries)
			default_libraries.set_minimum_height (200)

			fill_default_libraries

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

			set_minimum_width (minimum_width.max (300))

			show_actions.extend (agent default_libraries.set_focus)
		end

feature {NONE} -- GUI elements

	default_libraries: EV_LIST
			-- Libraries provided by ISE.

	location: EV_TEXT_FIELD
			-- Location of the library configuration file, choosen by the user.

	name: EV_TEXT_FIELD
			-- Name of the library.

feature -- Access

	last_group: CONF_LIBRARY
			-- Last created group.

feature {NONE} -- Actions

	browse is
			-- Browse for a location.
		local
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

			browse_dialog.open_actions.extend (agent fill_fields)
			browse_dialog.show_modal_to_window (Current)
		end

	fill_fields is
			-- Set location from `browse_dialog'.
		do
			location.set_text (browse_dialog.file_name)
			if name.text.is_empty then
				name.set_text (name_from_location (browse_dialog.file_name))
			end
		end

	fill_library (a_name, a_subdir, a_file: STRING) is
			-- Fill in library informations.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_subdir_ok: a_subdir /= Void and then not a_subdir.is_empty
			a_file_ok: a_file /= Void and then not a_file.is_empty
		do
			name.set_text (a_name)
			location.set_text ("$ISE_LIBRARY\"+a_subdir+"\"+a_file)
		end

	on_cancel is
			-- Close the dialog.
		do
			destroy
		end

	on_ok is
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

feature {NONE} -- Implementation

	name_from_location (a_location: STRING_8): STRING_8 is
			-- Get a name out of a_directory.
		require
			a_location_not_void: a_location /= Void
		local
			l_cnt, i, j: INTEGER_32
		do
			l_cnt := a_location.count
			i := a_location.last_index_of (operating_environment.directory_separator, l_cnt)
			j := a_location.last_index_of ('.', l_cnt)
			if i > 0 and j > 0 then
				Result := a_location.substring (i + 1, j - 1)
			else
				Result := a_location
			end
		ensure
			result_not_void: Result /= Void
		end

	browse_dialog: EV_FILE_OPEN_DIALOG is
			-- Dialog to browse to a library
		local
			l_dir: DIRECTORY
		once
			create Result
			create l_dir.make (target.system.directory)
			if l_dir.exists then
				Result.set_start_directory (l_dir.name)
			end
			Result.filters.extend ([config_files_filter, config_files_description])
			Result.filters.extend ([all_files_filter, all_files_description])
		ensure
			Result_not_void: Result /= Void
		end

	fill_default_libraries is
			-- Fill in the default libraries.
		require
			default_libraries_not_void: default_libraries /= Void
		local
			l_dir: KL_DIRECTORY
			l_subdirs: ARRAY [STRING]
			i, cnt: INTEGER
			l_lib_name: STRING
		do
				-- look for configuration files under $ISE_LIBRARY/library or $ISE_LIBRARY/library/somedirectory
			create l_dir.make (eiffel_layout.Library_path)
			if l_dir.is_readable then
				add_configs_in_dir (eiffel_layout.library_path.string, {EIFFEL_ENV}.library_name)
				l_subdirs := l_dir.directory_names
				if l_subdirs /= Void then
					from
						i := 1
						cnt := l_subdirs.count
					until
						i > cnt
					loop
						l_lib_name := eiffel_layout.library_path.twin
						l_lib_name.append_character (operating_environment.directory_separator)
						l_lib_name.append (l_subdirs.item (i))
						add_configs_in_dir (l_lib_name, {EIFFEL_ENV}.library_name + "\" + l_subdirs.item (i))
						i := i +1
					end
				end
			end
		end

	add_configs_in_dir (a_path, a_subdir: STRING) is
			-- Add config files in `a_path' to `default_libraries'.
		require
			a_path_not_void: a_path /= Void
			default_libraries_not_void: default_libraries /= Void
		local
			l_dir: KL_DIRECTORY
			l_files: ARRAY [STRING]
			i, cnt: INTEGER
			l_lib_file_name, l_lib_name: STRING
			l_item: EV_LIST_ITEM
		do
			create l_dir.make (a_path)
			if l_dir.is_readable then
				l_files := l_dir.filenames
				if l_files /= Void then
					from
						i := l_files.lower
						cnt := l_files.upper
					until
						i > cnt
					loop
						l_lib_file_name := l_files.item (i)
						if valid_config_extension (l_lib_file_name) then
							l_lib_name := l_lib_file_name.substring (1, l_lib_file_name.last_index_of ('.', l_lib_file_name.count)-1)
							create l_item.make_with_text (l_lib_name)
							l_item.select_actions.extend (agent fill_library (l_lib_name, a_subdir, l_lib_file_name))
							default_libraries.extend (l_item)
						end
						i := i + 1
					end
				end
			end
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
