indexing
	description: "Manager that manage all saved layouts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NAMED_LAYOUT_MANAGER

inherit --{NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initlization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		require
			not_void: a_dev_window /= Void
		do
			create interface_names
			create layouts.make (10)
			init_existing_layouts
			development_window := a_dev_window
		ensure
			set: development_window = a_dev_window
		end

	init_existing_layouts is
			-- Initialize `layouts'.
		do
			init_existing_layouts_imp (layout_file_path (is_normal_mode), is_normal_mode)
		end

	init_existing_layouts_imp (a_dir: !DIRECTORY_NAME; a_from_normal_mode: BOOLEAN) is
			-- Used by `init_eixisting_layouts'.
		require
			dir_not_empty: not a_dir.is_empty
		local
			l_dir: DIRECTORY
			l_files: ARRAYED_LIST [STRING]
			l_file: RAW_FILE
			l_config_data: SD_CONFIG_DATA
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_fn: FILE_NAME
		do
			create l_dir.make (a_dir)
			if l_dir.exists then
				from
					l_files := l_dir.linear_representation
					l_files.start
				until
					l_files.after
				loop
					if l_files.item.item (1) /= '.' then
						create l_fn.make_from_string (l_dir.name.twin)
						l_fn.set_file_name (l_files.item)
						create l_file.make_open_read (l_fn)
						check exist: l_file.exists end
						create l_reader.make (l_file)
						l_reader.set_for_reading
						create l_facility
						l_config_data ?= l_facility.retrieved (l_reader, True)

						-- Maybe it's corrupted data, we ignore it.
						if l_config_data /= Void then
							check not_already_has: not layouts.has (l_config_data.name) end
							layouts.force ([l_fn, a_from_normal_mode], l_config_data.name)
						end
						l_file.close
					end
					l_files.forth
				end
			end
		end

feature -- Command

	add_layout (a_name: STRING_GENERAL): BOOLEAN is
			-- Add a new layout which name is `a_name if not exist.
			-- Otherwise overwrite the exsiting one.
		require
			not_void: a_name /= Void
			not_empty: not a_name.as_string_8.is_equal ("")
		local
			l_fn: FILE_NAME
			l_file_utils: FILE_UTILITIES
		do
			if layouts.has (a_name) then
				l_fn := layouts.item (a_name).file_path
			else
				l_fn := layout_file_name (a_name.as_string_8, is_normal_mode)
			end
			create l_file_utils
			l_file_utils.create_directory_for_file (({!STRING_GENERAL}) #? l_fn.string)
			Result := development_window.docking_manager.save_tools_data_with_name (l_fn, a_name)
		end

	open_layout (a_name: STRING_GENERAL) is
			-- Open a named layout
			-- `a_win' is the window which show modal to.
		require
			has: layouts.has (a_name)
		local
			l_fn: FILE_NAME
			l_r: BOOLEAN
			l_pointer_style: EV_POINTER_STYLE
			l_stock_pixmaps: EV_STOCK_PIXMAPS
			l_dialog: ES_ERROR_PROMPT
			l_debugger: EB_SHARED_DEBUGGER_MANAGER
			l_info: TUPLE [file_name: FILE_NAME; is_normal_mode: BOOLEAN]
			l_ok_to_open: BOOLEAN
			l_cmd: EB_COMMAND
		do
			l_info := layouts.item (a_name)

			if l_info.is_normal_mode /= is_normal_mode then
				-- Layout saved in different mode. We need swtich mode now.
				create l_debugger
				if is_normal_mode then
					l_ok_to_open := True
				else
					-- Is debug mode, can we swtich to normal mode now?
					if l_debugger.eb_debugger_manager.is_debugging then
						create l_dialog.make_standard (interface_names.l_open_layout_not_possible)
						l_dialog.show_on_active_window
						l_ok_to_open := False
					else
						l_ok_to_open := True
					end
				end
				if l_ok_to_open then
					l_cmd := l_debugger.eb_debugger_manager.force_debug_mode_cmd
					if l_cmd /= Void and l_cmd.executable then
						l_cmd.execute
					end
				end
			else
				l_ok_to_open := True
			end

			if l_ok_to_open then
				l_pointer_style := development_window.window.pointer_style
				create l_stock_pixmaps
				development_window.window.set_pointer_style (l_stock_pixmaps.busy_cursor)

				l_fn := l_info.file_name
				l_r := development_window.docking_manager.open_tools_config (l_fn)
				if not l_r then
					-- If opening failed, we open orignal layout before opening.
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (interface_names.l_open_layout_error, development_window.window, Void)
					development_window.docking_layout_manager.restore_standard_tools_docking_layout
				end

				development_window.menus.update_menu_lock_items
				development_window.menus.update_show_tool_bar_items

				development_window.window.set_pointer_style (l_pointer_style)
			end

		end

feature -- Query

	layouts: DS_HASH_TABLE [TUPLE [file_path: FILE_NAME; is_normal_mode: BOOLEAN], STRING_GENERAL]
			-- All names of layouts.
			-- Key is name of a layout.

feature {NONE} -- Query

	layout_file_name (a_file_name: STRING; a_normal_mode: BOOLEAN): !FILE_NAME
			-- Retrieve a full path for a docking layout file name
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			create Result.make_from_string (layout_file_path (a_normal_mode).string)
			Result.set_file_name (a_file_name)
			Result.add_extension (eiffel_layout.docking_file_extension)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	layout_file_path (a_normal_mode: BOOLEAN): !DIRECTORY_NAME
			-- Retrieve a full path for a docking layout file name
		do
			Result := eiffel_layout.user_docking_path.twin
			if a_normal_mode then
				Result.extend (user_layout_prefix + eiffel_layout.docking_standard_file)
			else
				Result.extend (user_layout_prefix + eiffel_layout.docking_debug_file)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	is_normal_mode: BOOLEAN is
			-- True means Eiffel Studio is normal mode now.
			-- False means Eiffel Studio is debug mode now.
		local
			l_debugger: EB_SHARED_DEBUGGER_MANAGER
		do
			create l_debugger
			Result := not l_debugger.eb_debugger_manager.raised
		end

	user_layout_prefix: STRING = "user_"
			-- User layout prefix

	interface_names: INTERFACE_NAMES
			-- Interface names.

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development windows related.

invariant
	not_void: layouts /= Void

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

end -- class EB_NAMED_LAYOUT_MANAGER
