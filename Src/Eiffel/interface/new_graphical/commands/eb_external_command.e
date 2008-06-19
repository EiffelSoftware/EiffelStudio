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

	SHARED_WORKBENCH

	EB_CONSTANTS

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
					preferences.external_command_data.i_th_external_preference (i).set_value ((commands @ i).resource)
--				else
--						-- We use an empty string as value, because this is how the
--						-- preferences are initialized. That way, the entry is actually
--						-- removed from the preferences.
--					preferences.external_command_data.i_th_external_preference (i).set_value ("")
				end
				i := i + 1
			end
		end

feature{NONE} -- Command substitution

	show_warning_dialog (msg: STRING_GENERAL) is
			-- Show a warning dialog to display `msg'.
		do
			prompts.show_warning_prompt (msg, Void, Void)
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
			msg: STRING_32
			ok: BOOLEAN

			l_scanner: EB_COMMAND_SCANNER
			l_replacer: EB_TEXT_REPLACER
			l_factory: EB_EXTERNAL_COMMAND_TEXT_FRAGMENT_FACTORY
			l_fragments: LINKED_LIST [EB_TEXT_FRAGMENT]
		do
			if external_launcher.launched and then not external_launcher.has_exited then
				show_warning_dialog (interface_names.e_external_command_is_running)
			else
				ok := True
				create cl.make (external_command.count + 20)
				if working_directory /= Void then
					create wd.make (working_directory.count + 20)
					wd.append (working_directory)
				else
					wd := ""
				end
				cl.append (external_command)
				external_launcher.set_original_command_name (cl)

					-- Substitute placeholders in execute command `cl'.
				create l_factory
				create l_scanner.make (l_factory, create {YY_BUFFER}.make (cl))
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

				create exec
				if working_directory /= Void and then not working_directory.is_empty then
					od := exec.current_working_directory
					exec.change_working_directory (working_directory)
					if exec.return_code /= 0 then
						create msg.make (100)
						msg.append (interface_names.e_working_directory_invalid (working_directory))
						msg.append ("%N")
						msg.append (interface_names.e_external_command_not_launched)
						show_warning_dialog (msg)
						ok := False
					end
					exec.change_working_directory (od)
				end
				if ok then
					if platform_constants.is_windows then
						cmdexe := Execution_environment.get ("COMSPEC")
						if cmdexe /= Void then
								-- This allows the use of `dir' etc.
							external_launcher.prepare_command_line (cmdexe + " /c %""+cl+"%"", Void, wd)
							use_argument := False
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
					external_launcher.finished_actions.extend_kamikaze (agent l_fragments.do_all (agent (a_fragment: EB_TEXT_FRAGMENT) do a_fragment.safe_dispose_after_replacement end))
					external_launcher.launch (True, use_argument)
				end
			end
		end

feature -- Properties

	menu_name: STRING_GENERAL is
			-- Representation of `Current' in menus.
		do
			create {STRING_32}Result.make (name.count + 15)
			Result.append (("&").as_string_32)
			Result.append (index.out.as_string_32)
			Result.append ((" ").as_string_32)
			Result.append (interface_names.escaped_string_for_menu_item (name).as_string_32)
		end

	name: STRING
			-- Name that the user gave to this command.

	index: INTEGER
			-- Index of `Current' in the global list of known external commands.

	external_command: STRING
			-- Command line that is invoked when `Current' is executed.

	working_directory: STRING
			-- Working director where the corresponding external command is invoked.

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

	setup_managed_shortcut (l_accelerators: ARRAY [EV_ACCELERATOR]) is
			-- Setup `accelerator' and `managed_shortcut'
		require
			l_accelerators_not_void: l_accelerators /= Void
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := preferences.external_command_data.shortcuts.item ("shortcut_" + index.out)
			set_referred_shortcut (l_shortcut)
			set_accelerator (l_accelerators.item (index))
		end

feature{ES_CONSOLE_TOOL_PANEL} -- Status setting

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

	set_accelerator (accel: EV_ACCELERATOR) is
			-- Set `accelerator' to `accel'.
		do
			accelerator := accel
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
			create dir_dlg.make_with_title (interface_names.t_select_working_directory)
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
			create nl.make_with_text (Interface_names.l_name_colon)
			create il.make_with_text (Interface_names.l_index)
			create cl.make_with_text (Interface_names.l_Command_line)
			create name_field
			create index_field.make_with_value_range (0 |..| 9)
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

	on_ok is
			-- User pressed OK in `dialog'.
			-- Try to update `Current's status.
		local
			ix: INTEGER
		do
			ix := index_field.value
			if name_field.text.is_empty or command_field.text.is_empty or ix < 0 or ix > 9 then
				prompts.show_error_prompt (Warning_messages.w_Invalid_options, dialog, Void)
			else
				if commands.item (ix) /= Void and then commands.item (ix) /= Current then
					prompts.show_error_prompt (Warning_messages.w_Index_already_taken, dialog, Void)
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
