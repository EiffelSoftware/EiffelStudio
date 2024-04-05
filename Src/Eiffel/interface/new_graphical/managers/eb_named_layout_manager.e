note
	description: "Manager that manage all saved layouts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NAMED_LAYOUT_MANAGER

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initlization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW)
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

	init_existing_layouts
			-- Initialize `layouts'.
		do
			init_existing_layouts_imp (layout_file_path (is_normal_mode), is_normal_mode)
		end

	init_existing_layouts_imp (a_dir: PATH; a_from_normal_mode: BOOLEAN)
			-- Used by `init_eixisting_layouts'.
		require
			a_dir_not_void: a_dir /= Void
			dir_not_empty: not a_dir.is_empty
		local
			l_dir: DIRECTORY
			l_files: ARRAYED_LIST [PATH]
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_fn: PATH
		do
			create l_dir.make_with_path (a_dir)
			if l_dir.exists then
				from
					l_files := l_dir.entries
					l_files.start
				until
					l_files.after
				loop
					l_fn := l_files.item
					if not l_fn.is_current_symbol and then not l_fn.is_parent_symbol then
						l_fn := a_dir.extended_path (l_fn)
						create l_file.make_with_path (l_fn)
						if l_file.exists and then l_file.is_plain then
							l_file.open_read
							create l_reader.make (l_file)
							l_reader.set_for_reading
							create l_facility

							-- Maybe it's corrupted data, we ignore it.
							if attached {SD_CONFIG_DATA} l_facility.retrieved (l_reader, True) as l_config_data then
								check not_already_has: not layouts.has (l_config_data.name) end
								layouts.force ([l_fn, a_from_normal_mode], l_config_data.name)
							end
							l_file.close
						end
					end
					l_files.forth
				end
			end
		end

feature -- Command

	add_layout (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Add a new layout which name is `a_name if not exist.
			-- Otherwise overwrite the exsiting one.
		require
			not_void: a_name /= Void
			not_empty: not a_name.is_empty
		local
			l_fn: PATH
			l_file_utils: GOBO_FILE_UTILITIES
			l_name: READABLE_STRING_32
		do
			l_name := a_name.as_string_32
			if layouts.has (l_name) then
				l_fn := layouts.item (l_name).file_path
			else
				l_fn := layout_file_name (l_name, is_normal_mode)
			end
			if attached l_fn.parent as l_p then
				l_file_utils.create_directory_path (l_p)
			end
			Result := development_window.docking_manager.save_tools_data_with_name_and_path (l_fn, l_name)
		end

	delete_layout (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Delete a layout which name is `a_name'
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		local
			retried: BOOLEAN
			l_item: TUPLE [file_path: PATH; is_normal_mode: BOOLEAN]
			l_file: RAW_FILE
		do
			if not retried then
				l_item := layouts.item (a_name.as_string_32)
				if l_item /= Void then
					create l_file.make_with_path (l_item.file_path)
					if l_file.exists then
						l_file.delete
					end
					layouts.remove (a_name.as_string_32)

					Result := True
				end
			end
		rescue
			retried := True
			retry
		end

	open_layout (a_name: READABLE_STRING_GENERAL)
			-- Open a named layout
			-- `a_win' is the window which show modal to.
		require
			a_name_not_void: a_name /= Void
			has: layouts.has (a_name.as_string_32)
		local
			l_fn: PATH
			l_r: BOOLEAN
			l_pointer_style: EV_POINTER_STYLE
			l_stock_pixmaps: EV_STOCK_PIXMAPS
			l_dialog: ES_ERROR_PROMPT
			l_debugger: EB_SHARED_DEBUGGER_MANAGER
			l_info: TUPLE [file_name: PATH; is_normal_mode: BOOLEAN]
			l_ok_to_open: BOOLEAN
			l_cmd: EB_COMMAND
		do
			l_info := layouts.item (a_name.as_string_32)

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
				l_r := development_window.docking_manager.open_tools_config_with_path (l_fn)
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

	layouts: HASH_TABLE [TUPLE [file_path: PATH; is_normal_mode: BOOLEAN], READABLE_STRING_32]
			-- All names of layouts.
			-- Key is name of a layout.

feature {NONE} -- Query

	layout_file_name (a_file_name: READABLE_STRING_32; a_normal_mode: BOOLEAN): PATH
			-- Retrieve a full path for a docking layout file name
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			Result := layout_file_path (a_normal_mode)
			Result := Result.extended (a_file_name + {STRING_32} "." + eiffel_layout.docking_file_extension)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	layout_file_path (a_normal_mode: BOOLEAN): PATH
			-- Retrieve a full path for a docking layout file name
		do
			Result := eiffel_layout.docking_data_path
			if a_normal_mode then
				Result := Result.extended (user_layout_prefix + eiffel_layout.docking_standard_file)
			else
				Result := Result.extended (user_layout_prefix + eiffel_layout.docking_debug_file)
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	is_normal_mode: BOOLEAN
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

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

end -- class EB_NAMED_LAYOUT_MANAGER
