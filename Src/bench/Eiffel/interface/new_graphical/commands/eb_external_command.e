indexing
	description: "A command that calls an external executable"
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

	SHARED_EXEC_ENVIRONMENT
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

	EB_SHARED_PIXMAPS

	SHARED_WORKBENCH

create
	make,
	make_from_string,
	make_from_new_command_line,
	make_and_run_only

feature {NONE} -- Initialization

	make (w: EV_WINDOW) is
			-- Initialize `Current'.
			-- Pop up a dialog modal to `w' to let the user initialize `Current'
		require
			valid_window: w /= Void
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
			dialog.show_modal_to_window (w)

			if is_valid then
					-- Automatically add `Current' to the list of commands.
				commands.put (Current, index)
			end
			enable_sensitive
			external_output_manager.synchronize_command_list (Current)
		end

	make_from_new_command_line (w:EV_WINDOW; cmd_line: STRING) is
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
			write_to_preference
			external_output_manager.synchronize_command_list (Current)
		end

	make_from_string (a_command: STRING) is
			-- Create with `a_command'
		require
			command_not_void: a_command /= Void
		local
			tok: STRING
			i, i1 ,i2: INTEGER
		do
			i := a_command.index_of (separator, 1)
			name := a_command.substring (1, i - 1)
			i1 := a_command.index_of (separator, i + 1)
			tok := a_command.substring (i + 1, i1 - 1)
			if tok.is_integer then
				index := tok.to_integer
			else
				index := -1
			end
			i2 := a_command.index_of (separator, i1 + 1)

			external_command := a_command.substring (i1 + 1, i2 - 1)--a_command.count)
			if i2 = a_command.count then
				working_directory := ""
			else
				working_directory := a_command.substring (i2 + 1, a_command.count)
			end
				-- Check validity before inserting.
				-- This is a bit redundant with the precondition, but
				-- you never know what a David Hollenberg is capable of ^.^;;
			if
				is_valid
			then
				commands.put (Current, index)
				enable_sensitive
			end
		end

	make_and_run_only (cmd: STRING; dir: STRING) is
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

	write_to_preference is
			-- Write `Current' external command to preference.
		local
			i: INTEGER
		do
			from
			until
				i > 9
			loop
				if commands @ i = Current then
					preferences.misc_data.i_th_external_preference (i).set_value ((commands @ i).resource)
--				else
--						-- We use an empty string as value, because this is how the
--						-- preferences are initialized. That way, the entry is actually
--						-- removed from the preferences.
--					preferences.misc_data.i_th_external_preference (i).set_value ("")
				end
				i := i + 1
			end
		end

feature{NONE} -- Command substitution

	substitute_command (cmd: STRING; sub_str: STRING; hdr: PROCEDURE [ANY, TUPLE]) is
			-- if `cmd' has substring `sub_str', call agent handler `hdr'.
		require
			cmd_not_void: cmd /= Void
			sub_str_not_void: sub_str /= Void
			hdr_not_void: hdr /= Void
		local
			l_str: STRING
			l_index: INTEGER
			s_index: INTEGER
		do
			l_str := cmd.as_lower
			s_index := 1
			l_index := l_str.substring_index (sub_str, s_index)
			if l_index > 0 then
				from

				until
					l_index = 0
				loop
					l_str.replace_substring (sub_str, l_index, l_index + sub_str.count - 1)
					cmd.replace_substring (sub_str, l_index, l_index + sub_str.count - 1)
					s_index := l_index + sub_str.count
					l_index := l_str.substring_index (sub_str, s_index)
				end
				hdr.call ([cmd, sub_str])
			end
		end

	sub_string_list: ARRAYED_LIST [STRING] is
			-- List of string used for command substitution.
		once
			create Result.make (5)
			Result.extend ("$class_name")
			Result.extend ("$file_name")
			Result.extend ("$directory_name")
			Result.extend ("$w_code")
			Result.extend ("$f_code")
		end

	sub_action_list: ARRAYED_LIST [ PROCEDURE [ANY, TUPLE]] is
			-- List of actions used for command substitution
		once
			create Result.make (5)
			Result.extend (agent on_substitute_class_name)
			Result.extend (agent on_substitute_file_name)
			Result.extend (agent on_substitute_directory_name)
			Result.extend (agent on_substitute_w_code)
			Result.extend (agent on_substitute_f_code)
		end

	sub_class_name: INTEGER is 1
	sub_file_name: INTEGER is 2
	sub_directory_name: INTEGER is 3
	sub_w_code: INTEGER is 4
	sub_f_code: INTEGER is 5

	show_warning_dialog (msg: STRING) is
			-- Show a warning dialog to display `msg'.
		local
			wdlg: EV_WARNING_DIALOG
		do
			create wdlg.make_with_text (msg)
			wdlg.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	on_substitute_class_name (cmd: STRING; sub_str: STRING) is
			-- If `cmd' has substring (case insensitive) `sub_str',
			-- call an agent to substitute it.
		require
			is_command_ok_is_true: is_command_ok = True
		local
			cn: STRING
			dev: EB_DEVELOPMENT_WINDOW
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				cn := dev.class_name
				if cn = Void or else cn.is_empty then
					set_is_command_ok (False)
					show_warning_dialog (Warning_messages.w_Command_needs_class)
				else
					cmd.replace_substring_all (sub_string_list.i_th (sub_class_name), cn)
				end
			else
				set_is_command_ok (False)
			end
		end

	on_substitute_file_name (cmd: STRING; sub_str: STRING) is
			-- If `cmd' has substring (case insensitive) `sub_str',
			-- call an agent to substitute it.
		require
			is_command_ok_is_true: is_command_ok = True
		local
			cv_cst: CLASSI_STONE
			dev: EB_DEVELOPMENT_WINDOW
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				cv_cst ?= dev.stone
				if cv_cst /= Void then
					cmd.replace_substring_all (sub_string_list.i_th (sub_file_name), cv_cst.class_i.file_name)
				else
					set_is_command_ok (False)
					show_warning_dialog (Warning_messages.w_Command_needs_file)
				end
			else
				set_is_command_ok (False)
			end
		end

	on_substitute_directory_name (cmd: STRING; sub_str: STRING) is
			-- If `cmd' has substring (case insensitive) `sub_str',
			-- call an agent to substitute it.
		require
			is_command_ok_is_true: is_command_ok = True
		local
			cv_cst: CLASSI_STONE
			dev: EB_DEVELOPMENT_WINDOW
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				cv_cst ?= dev.stone
				if cv_cst /= Void then
					cmd.replace_substring_all (sub_string_list.i_th (sub_directory_name), cv_cst.class_i.group.location.evaluated_directory)
				else
					set_is_command_ok (False)
					show_warning_dialog (Warning_messages.w_Command_needs_directory)
				end
			else
				set_is_command_ok (False)
			end
		end

	on_substitute_w_code (cmd: STRING; sub_str: STRING) is
			-- If `cmd' has substring (case insensitive) `sub_str',
			-- call an agent to substitute it.
		require
			is_command_ok_is_true: is_command_ok = True
		do
			if workbench.system_defined then
				cmd.replace_substring_all (sub_string_list.i_th (sub_w_code), workbench_generation_path)
			else
				show_warning_dialog (Warning_messages.w_no_system_defined)
				set_is_command_ok (False)
			end
		end

	on_substitute_f_code (cmd: STRING; sub_str: STRING) is
			-- If `cmd' has substring (case insensitive) `sub_str',
			-- call an agent to substitute it.
		require
			is_command_ok_is_true: is_command_ok = True
		do
			if workbench.system_defined then
				cmd.replace_substring_all (sub_string_list.i_th (sub_f_code), final_generation_path)
			else
				show_warning_dialog (Warning_messages.w_no_system_defined)
				set_is_command_ok (False)
			end
		end

	is_command_ok: BOOLEAN is
			-- Is command valid (when string substitution is needed)?
		do
			Result := command_ok_cell.item
		end

	set_is_command_ok (b: BOOLEAN) is
			-- Set `is_command_ok' with `b'.
		do
			command_ok_cell.put (b)
		end

feature{NONE}

	command_ok_cell: CELL [BOOLEAN] is
			-- Cell to store Value of `is_command_ok'
		once
			create Result.put (False)
		end

	prepare_command (cmd: STRING; dir: STRING) is
			-- Prepare external command `cmd', do stirng substitution if needed.
		do
			from
				set_is_command_ok (True)
				sub_string_list.start
				sub_action_list.start
			until
				sub_string_list.after or sub_action_list.after or not is_command_ok
			loop
				substitute_command (cmd, sub_string_list.item, sub_action_list.item)
				if is_command_ok then
					substitute_command (dir, sub_string_list.item, sub_action_list.item)
				end
				sub_string_list.forth
				sub_action_list.forth
			end
		end

feature -- Execution

	execute is
			-- Launch the external command that is linked to `Current', if possible.
		local
			cl: STRING
			od: STRING
			exec: EXECUTION_ENVIRONMENT
			cmdexe: STRING
			wd: STRING
			args: LIST [STRING]
			use_argument: BOOLEAN
		do
			if external_launcher.launched and then not external_launcher.has_exited then
				show_warning_dialog ("An external command is running now. %NPlease wait until it exits.")
			else
				create cl.make (external_command.count + 20)
				if working_directory /= Void then
					create wd.make (working_directory.count + 20)
					wd.append (working_directory)
				else
					wd := ""
				end
				cl.append (external_command)
				external_launcher.set_original_command_name (cl)

				prepare_command (cl, wd)

				if is_command_ok then
					create exec
					od := exec.current_working_directory

					if platform_constants.is_windows then
						cmdexe := Execution_environment.get ("COMSPEC")
						if cmdexe /= Void then
								-- This allows the use of `dir' etc.
							create {ARRAYED_LIST [STRING]}args.make (1)
							args.extend ("/c%""+cl+"%"")
							external_launcher.prepare_command_line (cmdexe, args, wd)
							use_argument := True
						else
							external_launcher.prepare_command_line (cl, Void, wd)
							use_argument := False
						end
					else
						create {ARRAYED_LIST [STRING]}args.make (2)
						args.extend ("-c")
						args.extend ("%'%'"+cl+"%'%'")
						external_launcher.prepare_command_line ("/bin/sh", args, wd)
						use_argument := True
					end
					external_launcher.set_hidden (True)
					external_launcher.launch (True, use_argument)
					exec.change_working_directory (od)
				end
			end
		end

feature -- Properties

	menu_name: STRING is
			-- Representation of `Current' in menus.
		do
			create Result.make (name.count + 15)
			Result.append_character ('&')
			Result.append (index.out)
			Result.append_character (' ')
			Result.append (name)
		end

	name: STRING
			-- Name that the user gave to this command.

	index: INTEGER
			-- Index of `Current' in the global list of known external commands.

	external_command: STRING
			-- Command line that is invoked when `Current' is executed.

	working_directory: STRING
			-- Working director where the corresponding external command is invoked.

	last_call_output: STRING
			-- Output of the last invocation of command.

feature -- Status setting

	edit_properties (w: EV_WINDOW) is
			-- Pop up a dialog, modal to `w', that lets the user
			-- edit the properties of `Current' (menu name, called command and index)
		require
			w_not_void: w /= void
		do
			create_dialog
			if name /= Void then
				name_field.set_text (name)
			end
			index_field.set_value (index)
			if external_command /= Void then
				command_field.set_text (external_command)
			end
			if working_directory /= Void then
				working_directory_field.set_text (working_directory)
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
			write_to_preference
			external_output_manager.synchronize_command_list (Current)
		end

feature{EB_EXTERNAL_OUTPUT_TOOL} -- Status setting

	set_command (cmd: STRING) is
			-- Set `external_command' with `cmd'.
		require
			cmd_not_void: cmd /= Void
			cmd_not_empty: not cmd.is_empty
		do
			create external_command.make_from_string (cmd)
		ensure
			external_command_set: external_command.is_equal (cmd)
		end

	set_working_directory (dir: STRING) is
			-- Set `working_directory' with `dir'.
		do
			if dir /= Void then
				create working_directory.make_from_string (dir)
			else
				working_directory := Void
			end
		ensure
			working_directory_set:
				((dir /= Void) implies working_directory.is_equal (dir)) and
				((dir = Void) implies working_directory = Void)
		end

feature -- Status report

	resource: STRING is
			-- Save `Current's information to a string representation.
		do
			create Result.make (menu_name.count + external_command.count + 10)
			Result.append (name)
			Result.append_character (separator)
			Result.append (index.out)
			Result.append_character (separator)
			Result.append (external_command)
				-- Store `working_directory' to preference.
			Result.append_character (separator)
			if working_directory /= Void then
				Result.append (working_directory)
			else
				Result.append ("")
			end
		ensure
			not_void: Result /= Void
			valid: valid_resource (Result)
		end

	valid_resource (r: STRING): BOOLEAN is
			-- Is `r' a valid resource representation of an external command?
		require
			not_void_resource: r /= Void
		do
			Result := r.occurrences (separator) = 3
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid command?
		do
			Result := index >= 0 and
						index < 10 and
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

	separator: CHARACTER is '['
			-- Separator in resource representation.

	commands: ARRAY [EB_EXTERNAL_COMMAND] is
			-- Abstract representation of external commands.
		do
			Result := (create {EB_EXTERNAL_COMMANDS_EDITOR}.make).commands
		end

	dir_dlg: EV_DIRECTORY_DIALOG

	create_directory_dialog is
			--
		do
			create dir_dlg.make_with_title ("Select working directory")
			dir_dlg.ok_actions.extend (agent on_directory_dialog_ok)
			dir_dlg.show_modal_to_window (dialog)
		end

	on_directory_dialog_ok is
			--
		do
			if dir_dlg /= Void then
				working_directory := dir_dlg.directory
				working_directory_field.set_text (working_directory)
				dir_dlg.destroy
			end

		end

	create_dialog is
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
			create nl.make_with_text (Interface_names.l_name)
			create il.make_with_text (Interface_names.l_index)
			create cl.make_with_text (Interface_names.l_Command_line)
			create name_field
			create index_field.make_with_value_range (0 |..| 9)
			create command_field

			create hb1.default_create
			create working_directory_field
			create wd.make_with_text ("Working directory:")
			wd.align_text_left
			create dir_btn.default_create
			dir_btn.set_pixmap (Icon_open_file)
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
			Layout_constants.set_default_size_for_button (okb)
			Layout_constants.set_default_size_for_button (cb)
			dialog.set_title (Interface_names.t_External_command)
			dialog.set_icon_pixmap (pixmaps.icon_dialog_window)
			dialog.set_maximum_height (dialog.minimum_height)
			dialog.set_default_push_button (okb)
			dialog.set_default_cancel_button (cb)

				-- Set up events.
			okb.select_actions.extend (agent on_ok)
			cb.select_actions.extend (agent destroy_dialog)

				-- Ensure that `name_field' gets focus when dialog is displayed
			dialog.show_actions.extend (agent name_field.set_focus)
		end

	on_ok is
			-- User pressed OK in `dialog'.
			-- Try to update `Current's status.
		local
			wd: EV_WARNING_DIALOG
			ix: INTEGER
		do
			ix := index_field.value
			if name_field.text.is_empty or command_field.text.is_empty or ix < 0 or ix > 9 then
				create wd.make_with_text (Warning_messages.w_Invalid_options)
				wd.show_modal_to_window (dialog)
			else
				if commands.item (ix) /= Void and then commands.item (ix) /= Current then
					create wd.make_with_text (Warning_messages.w_Index_already_taken)
					wd.show_modal_to_window (dialog)
				else
					name := name_field.text
					external_command := command_field.text
					working_directory := working_directory_field.text
					index := index_field.value
					destroy_dialog
				end
			end
		end

	destroy_dialog is
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

	old_index: INTEGER;
			-- Index of `Current' before we edited its properties.

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

end -- class EB_EXTERNAL_COMMAND
