note
	description: "[
					A command that calls an external executable.
					
					`name', `index', `external_command' and `working_directory'
					are serialized by `resource' query. Each attribute 
					is separated by `separator': '{'. The serialized string is written
					into .ini file later. In order to make it possible to have  
					'{' in the attributes, a `escape_character' is used: '!'.
					
					When reading from .ini file, `parse_command' parses the stored 
					string and set back to above attributes. Those '{' preceded by '!'
					are translated into '{' instead of being treated as separator.
					
					For example, an external command with name "copy unicode", with 1 as index,
					with "copy @{CALCULATOR} c:\work\中文文件夹" as the command and with empty
					working directory are stored as following:
						copy unicode{1{copy @!{CALCULATOR} c:\work\中文文件夹{

					The `parse_command' routine segments it into a list when retrieving:
						- copy unicode
						- 1
						- copy @{CALCULATOR} c:\work\中文文件夹
						- [empty_string]
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_PLATFORM_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS

	SHARED_WORKBENCH

	EB_CONSTANTS

create
	make,
	make_from_string,
	make_from_new_command_line,
	make_and_run_only

feature {NONE} -- Initialization

	make (w: EV_WINDOW; a_editor: EB_EXTERNAL_COMMANDS_EDITOR)
			-- Initialize `Current'.
			-- Pop up a dialog modal to `w' to let the user initialize `Current'
		require
			valid_window: w /= Void
			not_void: attached a_editor
		do
			old_index := -1
			editor := a_editor
			create_dialog

				-- Find first available index for new command.
			index := calculate_next_index

			index_field.set_value (index)
			dialog.show_modal_to_window (w)

			if is_valid then
					-- Automatically add `Current' to the list of commands.
				commands.put (Current, index)
			end

			enable_sensitive
			external_output_manager.synchronize_command_list (Current)
		end

	make_from_new_command_line (w: EV_WINDOW; cmd_line: READABLE_STRING_GENERAL)
			-- Use command line indicated by `cmd_line' to make a new
			-- external command object.
		require
			w_not_null: w /= Void
			cmd_line_not_null: cmd_line /= Void
		do
			old_index := -1
			create_dialog

				-- Find first available index for new command.
			from
				index := 0
			until
				index > 9 or commands.item (index) = Void
			loop
				index := index + 1
			end
			index_field.set_value (index)
			command_field.set_text (cmd_line)
			dialog.show_modal_to_window (w)

			if is_valid then
					-- Automatically add `Current' to the list of commands.
				commands.put (Current, index)
			end

			enable_sensitive
			write_to_ini
			external_output_manager.synchronize_command_list (Current)
		end

	make_from_string (a_editor: like editor; a_command: READABLE_STRING_GENERAL)
			-- Create with `a_command'
		require
			command_not_void: a_command /= Void
		local
			tok: READABLE_STRING_GENERAL
			l_sections: like parse_command
		do
			editor := a_editor

			l_sections := parse_command (a_command)
			if l_sections.count = 4 then
				name := l_sections.i_th (1)
				tok := l_sections.i_th (2)
				if tok.is_integer then
					index := tok.to_integer
				else
					index := -1
				end
				external_command := l_sections.i_th (3)
				create working_directory.make_from_string (l_sections.i_th (4))
			end

				-- Check validity before inserting.
			if is_valid then
				commands.put (Current, index)
				enable_sensitive
			end
		end

	make_and_run_only (cmd: READABLE_STRING_GENERAL; dir: detachable PATH)
			-- Create for running `cmd' in directory `dir'.
			-- Do not save external command and its working directory to preference.
		require
			cmd_not_void: cmd /= Void
			cmd_not_empty: not cmd.is_empty
		do
			set_command (cmd)
			set_working_directory (dir)
			execute
		end

feature -- Basic operations

	write_to_ini
			-- Write `Current' external command to ini file.
		do
			if attached editor as e then
				e.ini_manager.generate_ini
			else
				check has_editor: False end
			end
		end

feature {NONE} -- Command substitution

	show_warning_dialog (msg: READABLE_STRING_GENERAL)
			-- Show a warning dialog to display `msg'.
		do
			prompts.show_warning_prompt (msg, Void, Void)
		end

feature -- Execution

	execute
			-- Launch the external command that is linked to `Current', if possible.
		local
			cl: STRING_32
			od: PATH
			cmdexe: STRING_32
			wd: detachable STRING_32
			wpath: PATH
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
			use_argument: BOOLEAN
			msg: STRING_32
			ok: BOOLEAN

			l_scanner: EB_COMMAND_SCANNER
			l_replacer: EB_TEXT_REPLACER
			l_factory: EB_EXTERNAL_COMMAND_TEXT_FRAGMENT_FACTORY
			l_fragments: LINKED_LIST [EB_TEXT_FRAGMENT]
			u: UTF_CONVERTER
		do
			if external_launcher.launched and then not external_launcher.has_exited then
				show_warning_dialog (interface_names.e_external_command_is_running)
			else
				ok := True
				create cl.make (external_command.count + 20)

				if attached working_directory as wd_path then
					wd := wd_path.name
				else
					create wd.make_empty
				end
				cl.append_string_general (external_command)
				external_launcher.set_original_command_name (cl)

					-- Substitute placeholders in execute command `cl'.
				create l_factory
					-- The scanner convert UTF-8 to UTF-32 when done.
				create l_scanner.make (l_factory, create {YY_BUFFER}.make (u.utf_32_string_to_utf_8_string_8 (cl)))
				create l_replacer
				create l_fragments.make

				l_scanner.scan
				l_fragments.append (l_scanner.text_fragments)
				l_replacer.text_fragments.append (l_scanner.text_fragments)
				l_replacer.prepare_replacement
				cl := l_replacer.new_text (cl)

					-- Substitute placeholders in specified working directory `dir'.
				l_scanner.wipe_text_fragments
				l_scanner.reset
				l_scanner.set_input_buffer (create {YY_BUFFER}.make (wd))
				l_scanner.scan
				l_fragments.append (l_scanner.text_fragments)
				l_replacer.text_fragments.wipe_out
				l_replacer.text_fragments.append (l_scanner.text_fragments)
				l_replacer.prepare_replacement
				wd := l_replacer.new_text (wd)

				if attached working_directory as wd_path and then not wd_path.is_empty then
					od := execution_environment.current_working_path
					execution_environment.change_working_path (wd_path)
					if execution_environment.return_code /= 0 then
						create msg.make (100)
						msg.append (interface_names.e_working_directory_invalid (wd_path.name))
						msg.append ("%N")
						msg.append (interface_names.e_external_command_not_launched)
						show_warning_dialog (msg)
						ok := False
					end
					execution_environment.change_working_path (od)
				end
				if ok then
					create wpath.make_from_string (wd)
					if platform_constants.is_windows then
						cmdexe := Execution_environment.item ("COMSPEC")
						if cmdexe /= Void then
								-- This allows the use of `dir' etc.
							external_launcher.prepare_command_line (cmdexe + {STRING_32} " /c %"" + cl + {STRING_32} "%"", Void, wpath)
							use_argument := False
						else
							external_launcher.prepare_command_line (cl, Void, wpath)
							use_argument := False
						end
					else
						create args.make (2)
						args.extend ("-c")
						args.extend ({STRING_32} "%'%'" + cl + {STRING_32} "%'%'")
						external_launcher.prepare_command_line ({STRING_32} "/bin/sh", args, wpath)
						use_argument := True
					end
					external_launcher.set_hidden (True)
					external_launcher.finished_actions.extend_kamikaze (agent l_fragments.do_all (agent (a_fragment: EB_TEXT_FRAGMENT) do a_fragment.safe_dispose_after_replacement end))
					external_launcher.launch (True, use_argument)
				end
			end
		end

feature -- Properties

	menu_name: STRING_32
			-- Representation of `Current' in menus.
		do
			create Result.make (name.count + 15)
			Result.append_string_general ("&")
			Result.append (index.out)
			Result.append_string_general (" ")
			Result.append_string_general (interface_names.escaped_string_for_menu_item (name))
		end

	name: READABLE_STRING_GENERAL
			-- Name that the user gave to this command.

	index: INTEGER
			-- Index of `Current' in the global list of known external commands.

	external_command: READABLE_STRING_GENERAL
			-- Command line that is invoked when `Current' is executed.

	working_directory: detachable PATH
			-- Working director where the corresponding external command is invoked.

feature -- Status setting

	edit_properties (w: EV_WINDOW)
			-- Pop up a dialog, modal to `w', that lets the user
			-- edit the properties of `Current' (menu name, called command and index)
		require
			w_not_void: w /= Void
		do
			create_dialog
			if name /= Void then
				name_field.set_text (name)
			end
			index_field.set_value (index)
			if external_command /= Void then
				command_field.set_text (external_command)
			end
			if attached working_directory as wd then
				working_directory_field.set_text (wd.name)
			end
			old_index := index
			dialog.show_modal_to_window (w)
			if is_valid then
				if old_index /= index then
					commands.put (Void, old_index)
					commands.put (Current, index)
				end
			end
			old_index := -1
			write_to_ini
			external_output_manager.synchronize_command_list (Current)
		end

	setup_managed_shortcut (l_accelerators: ARRAY [EV_ACCELERATOR])
			-- Setup `accelerator' and `managed_shortcut'
		require
			l_accelerators_not_void: l_accelerators /= Void
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			if index <= 9 then
				l_shortcut := preferences.external_command_data.shortcuts.item ("shortcut_" + index.out)
				set_referred_shortcut (l_shortcut)
				set_accelerator (l_accelerators.item (index))
			end
		end

feature{ES_CONSOLE_TOOL_PANEL} -- Status setting

	set_command (cmd: READABLE_STRING_GENERAL)
			-- Set `external_command' with `cmd'.
		require
			cmd_not_void: cmd /= Void
			cmd_not_empty: not cmd.is_empty
		do
			external_command := cmd.twin
		ensure
			external_command_set: external_command.same_string (cmd)
		end

	set_working_directory (dir: detachable PATH)
			-- Set `working_directory' with `dir'.
		do
			working_directory := dir
		ensure
			working_directory_set: working_directory = dir
		end

	set_accelerator (accel: EV_ACCELERATOR)
			-- Set `accelerator' to `accel'.
		do
			accelerator := accel
		end

feature -- Status report

	resource: STRING
			-- Save `Current's information to a string representation.
			-- In UTF-8
		local
			l_result: STRING_32
			u: UTF_CONVERTER
		do
			create l_result.make (menu_name.count + external_command.count + 10)
			l_result.append (escape (name))
			l_result.append_character (separator)
			l_result.append (escape (index.out))
			l_result.append_character (separator)
			l_result.append (escape (external_command))
				-- Store `working_directory' to preference.
			l_result.append_character (separator)
			if attached working_directory as wd then
				l_result.append (escape (wd.name))
			end
			Result := u.string_32_to_utf_8_string_8 (l_result)
		ensure
			not_void: Result /= Void
			valid: valid_resource (Result)
		end

	valid_resource (r: STRING): BOOLEAN
			-- Is `r' a valid resource representation of an external command?
			-- `r' is in UTF-8.
		require
			not_void_resource: r /= Void
		local
			l_str: STRING_32
			u: UTF_CONVERTER
		do
			l_str := u.utf_8_string_8_to_string_32 (r)
			Result := parse_command (l_str).count = 4
		end

	is_valid: BOOLEAN
			-- Is `Current' a valid command?
		do
			Result := index >= 0 and
						name /= Void and
						external_command /= Void and then
						(not name.is_empty and not external_command.is_empty)
		end

feature {NONE} -- Widgets

	dialog: EV_DIALOG
			-- Dialog that lets the user edit `Current's properties.

	name_field: EV_TEXT_FIELD
			-- Text field where the user can enter `name'.

	index_field: EV_SPIN_BUTTON
			-- Text field where the user can enter `index'.

	command_field: EV_TEXT_FIELD
			-- Text field where the user can enter `external_command'.

	working_directory_field: EV_TEXT_FIELD
			-- Text field where the user can enter `working_directory'

feature {NONE} -- Implementation

	separator: CHARACTER_32 = '{'
			-- Separator in resource representation.

	escape_character: CHARACTER_32 = '!'
			-- Escape character. "!{" represents `{'

	commands: HASH_TABLE [EB_EXTERNAL_COMMAND, INTEGER]
			-- Abstract representation of external commands.
		do
			Result := (create {EB_EXTERNAL_COMMANDS_EDITOR}.make).commands
		end

	dir_dlg: EV_DIRECTORY_DIALOG

	create_directory_dialog
			--
		do
			create dir_dlg.make_with_title (interface_names.t_select_working_directory)
			dir_dlg.ok_actions.extend (agent on_directory_dialog_ok)
			dir_dlg.show_modal_to_window (dialog)
		end

	on_directory_dialog_ok
		local
			l_path: PATH
		do
			if dir_dlg /= Void then
				l_path := dir_dlg.path
				working_directory := l_path
				working_directory_field.set_text (l_path.name)
				dir_dlg.destroy
			end
		end

	create_dialog
			-- Initialize `dialog' and all widgets.
		local
			hb, hb1: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			f: EV_FRAME
			okb, cb: EV_BUTTON
			nl, il, cl, wd: EV_LABEL
			sz: INTEGER
			dir_btn: EV_BUTTON
		do
				-- Create widgets.
			create dialog
			create okb.make_with_text (Interface_names.B_ok)
			create cb.make_with_text (Interface_names.B_cancel)
			create nl.make_with_text (Interface_names.l_name_colon)
			create il.make_with_text (Interface_names.l_index)
			create cl.make_with_text (Interface_names.l_Command_line)
			create name_field
			create index_field.make_with_value_range (0 |..| 999)
			create command_field

			create hb1.default_create
			create working_directory_field
			create wd.make_with_text (interface_names.l_working_directory.as_string_32 + ": ")
			wd.align_text_left
			create dir_btn.default_create
			dir_btn.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)
			dir_btn.select_actions.extend (agent create_directory_dialog)
			hb1.extend (working_directory_field)
			hb1.extend (dir_btn)
			hb1.disable_item_expand (dir_btn)

				-- Organize widgets.
			sz := nl.minimum_width.max (il.minimum_width)
			nl.set_minimum_width (sz)
			il.set_minimum_width (sz)
			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (nl)
			hb.disable_item_expand (nl)
			hb.extend (name_field)
			vb.extend (hb)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (il)
			hb.disable_item_expand (il)
			hb.extend (index_field)
			vb.extend (hb)
			vb.extend (cl)
			vb.extend (command_field)
			vb.extend (wd)
			vb.extend (hb1)

			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_etched_in)
			f.extend (vb)

			create hb
			hb.set_padding (Layout_constants.Default_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cb)
			hb.disable_item_expand (cb)
			hb.extend (create {EV_CELL})

			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			vb.extend (f)
			vb.extend (hb)
			dialog.extend (vb)

				-- Set widget properties.
			nl.align_text_left
			il.align_text_left
			cl.align_text_left
			Layout_constants.set_default_width_for_button (okb)
			Layout_constants.set_default_width_for_button (cb)
			dialog.set_title (Interface_names.t_External_command)
			dialog.set_icon_pixmap (pixmaps.icon_pixmaps.tool_external_commands_icon)
			dialog.set_maximum_height (dialog.minimum_height)
			dialog.set_default_push_button (okb)
			dialog.set_default_cancel_button (cb)

				-- Set up events.
			okb.select_actions.extend (agent on_ok)
			cb.select_actions.extend (agent destroy_dialog)

				-- Ensure that `name_field' gets focus when dialog is displayed
			dialog.show_actions.extend (agent name_field.set_focus)
		end

	on_ok
			-- User pressed OK in `dialog'.
			-- Try to update `Current's status.
		local
			ix: INTEGER
		do
			ix := index_field.value
			if name_field.text.is_empty or command_field.text.is_empty or ix < 0 then
				prompts.show_error_prompt (Warning_messages.w_Invalid_options, dialog, Void)
			else
				if commands.item (ix) /= Void and then commands.item (ix) /= Current then
					prompts.show_error_prompt (Warning_messages.w_Index_already_taken, dialog, Void)
				else
					name := name_field.text
					external_command := command_field.text
					create working_directory.make_from_string (working_directory_field.text)
					index := index_field.value
					destroy_dialog
				end
			end
		end

	destroy_dialog
			-- Destroy all widgets.
		do
			check
				dialog /= Void
				--| FIXME XR: We shouldn't be able to call destroy_dialog more than once, but it occurred...
			end
			if dialog /= Void then
				dialog.destroy
			end
			dialog := Void
			name_field := Void
			index_field := Void
			command_field := Void
		end

	old_index: INTEGER
			-- Index of `Current' before we edited its properties.

	calculate_next_index: INTEGER
			-- Calculate next minimum index
		local
			l_sort_arrary: SORTED_TWO_WAY_LIST [INTEGER]
			l_commands: like commands
			l_stop: BOOLEAN
		do
			from
				create l_sort_arrary.make
				l_commands := commands
				l_commands.start
			until
				l_commands.after
			loop
				l_sort_arrary.extend (l_commands.key_for_iteration)
				l_commands.forth
			end

			from
				l_sort_arrary.start
				Result := 0
			until
				l_sort_arrary.after or l_stop
			loop
				if Result /= l_sort_arrary.item then
					l_stop := True
				else
					Result := Result + 1
					l_sort_arrary.forth
				end
			end
		end

	parse_command (a_str: READABLE_STRING_GENERAL): ARRAYED_LIST [STRING_32]
			-- Parse the command from stored string
		local
			i, l_count: INTEGER
			l_str: STRING_32
			l_item: CHARACTER_32
		do
			from
				i := 1
				create Result.make (4)
				create l_str.make (a_str.count)
				l_count := a_str.count
			until
				i > l_count
			loop
				l_item := a_str.item (i)
				if l_item = separator then
					if a_str.valid_index (i - 1) and then a_str.item (i - 1) = escape_character then
						l_str.put (separator, l_str.count)
					else
						Result.extend (l_str)
						create l_str.make (a_str.count)
					end
				else
					l_str.append_character (l_item)
				end
				i := i + 1
			end
			Result.extend (l_str)
		end

	escape (a_str: READABLE_STRING_GENERAL): STRING_32
			-- Escape the separater character
		do
			create Result.make_from_string_general (a_str)
			Result.replace_substring_all (create {STRING_32}.make_filled (Separator, 1), escaped_string)
		end

	escaped_string: STRING_32
			-- Escaped string
		once
			create Result.make (2)
			Result.append_character (escape_character)
			Result.append_character (separator)
		end

	editor: EB_EXTERNAL_COMMANDS_EDITOR
			-- External commands edtitor

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class EB_EXTERNAL_COMMAND
