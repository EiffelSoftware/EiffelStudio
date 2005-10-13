indexing
	description: "A command that calls an external executable"
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
		
	-- Jason Wei on Sep 2 2005
	EB_SHARED_MANAGERS
	
	EB_SHARED_PIXMAPS
	-- Jason Wei on Sep 2 2005


create
	make,
	make_from_string,
	make_from_new_command_line

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
			-- Jason Wei
			external_output_manager.synchronize_command_list (Current)
			-- Jason Wei			
		end
		
	-- Jason Wei
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
	-- Jason Wei	

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
			-- Jason Wei
			i2 := a_command.index_of (separator, i1 + 1)
			
			external_command := a_command.substring (i1 + 1, i2 - 1)--a_command.count)
			if i2 = a_command.count then
				working_directory := ""
			else
				working_directory := a_command.substring (i2 + 1, a_command.count)
			end
			-- Jason Wei
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

feature -- Basic operations
	
	-- Jason Wei
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
	-- Jason Wei
			
	-- Jason Wei on Sep 2 2005
	execute is
			-- Launch the external command that is linked to `Current', if possible.
		local
			cl: STRING
			wd: EV_WARNING_DIALOG
			cn: STRING
			dev: EB_DEVELOPMENT_WINDOW
			ok: BOOLEAN
			cv_cst: CLASSI_STONE
			od: STRING
			exec: EXECUTION_ENVIRONMENT
			dlg: EV_WARNING_DIALOG
		do
			create exec
			od := exec.current_working_directory
			create cl.make (external_command.count + 20)
			cl.append (external_command)
			dev := Window_manager.last_focused_development_window
			cv_cst ?= dev.stone
			ok := True
			if ok and cl.has_substring ("$class_name") then
				cn := dev.class_name
				if cn = Void or else cn.is_empty then
					create wd.make_with_text (Warning_messages.w_Command_needs_class)
					ok := False
					wd.show_modal_to_window (dev.window)
				else
					cl.replace_substring_all ("$class_name", cn)
				end
			end
			if ok and (cl.has_substring ("$file_name") or cl.has_substring ("$directory_name")) then
				if cv_cst = Void then
					ok := False
					create wd.make_with_text (Warning_messages.w_Command_needs_file)
					wd.show_modal_to_window (dev.window)
				else
					cl.replace_substring_all ("$file_name", cv_cst.class_i.file_name)
					cl.replace_substring_all ("$directory_name", cv_cst.class_i.cluster.path)
					exec.change_working_directory (cv_cst.class_i.cluster.path)
				end
			end
			if ok then
				-- Jason Wei on Sep 2 2005
				if external_launcher.launched and then not external_launcher.has_exited then
					create dlg.make_with_text ("An external command is running now. %NPlease wait until it exits.")
					dlg.show_modal_to_window (dev.window)
				else		
					if working_directory /= Void then
						external_launcher.prepare_command_line (cl,working_directory)
					else
						external_launcher.prepare_command_line (cl,"")
					end			
					external_launcher.set_hidden (False)
					external_launcher.launch (True)				
				end
				-- Jason Wei on Sep 2 2005				
			end
			exec.change_working_directory (od)
		end
	-- Jason Wei on Sep 2 2005


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
	
	-- Jason Wei
	working_directory: STRING
			-- Working director where the corresponding external command is invoked.
	-- Jason Wei

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
			-- Jason Wei
			if working_directory /= Void then
				working_directory_field.set_text (working_directory)
			end
			-- Jason Wei
			old_index := index
			dialog.show_modal_to_window (w)
			if is_valid then
				if old_index /= index then
					commands.put (Void, old_index)
					commands.put (Current, index)
				end
			end
			old_index := -1
			-- Jason Wei
			write_to_preference
			external_output_manager.synchronize_command_list (Current)
			-- Jason Wei			
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
			-- Jason Wei
				-- Store `working_directory' to preference.
			Result.append_character (separator)
			if working_directory /= Void then
				Result.append (working_directory)
			else	
				Result.append ("")
			end
			
			-- Jason Wei
		ensure
			not_void: Result /= Void
			valid: valid_resource (Result)
		end

	valid_resource (r: STRING): BOOLEAN is
			-- Is `r' a valid resource representation of an external command?
		require
			not_void_resource: r /= Void
		do
			-- Jason Wei
			Result := r.occurrences (separator) = 3
			-- Jason Wei
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
			
	-- Jason Wei
	working_directory_field: EV_TEXT_FIELD
			-- Text field where the user can enter `working_directory'
	-- Jason Wei

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
			
			-- Jason Wei
			create hb1.default_create
			create working_directory_field
			create wd.make_with_text ("Working directory:")
			wd.align_text_left
			create dir_btn.default_create
			dir_btn.set_pixmap (Icon_open_file.item (1))
			dir_btn.select_actions.extend (agent create_directory_dialog)
			hb1.extend (working_directory_field)
			hb1.extend (dir_btn)
			hb1.disable_item_expand (dir_btn)
			-- Jason Wei
			
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
			
			-- Jason Wei
			vb.extend (wd)
			vb.extend (hb1)
--			vb.extend (working_directory_field)
--			vb.extend (dir_btn)
			-- Jason Wei
			
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
					-- Jason Wei
					working_directory := working_directory_field.text
					-- Jason Wei
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

	launch_command (cl: STRING) is
			-- Execute command line `cl',
			-- wait for it to complete,
			-- display the output in the output tools.
		require
			valid_cl: cl /= Void
		local
			timer: EV_TIMEOUT
			cmdexe: STRING
		do
			Window_manager.for_all_development_windows (agent {EB_DEVELOPMENT_WINDOW}.disable_sensitive)
			create output_file_name.make_temporary_name
			create error_output_file_name.make_temporary_name
			if platform_constants.is_windows then
				cmdexe := Execution_environment.get ("COMSPEC")
				if cmdexe /= Void then
						-- This allows the use of `dir' etc.
					cl.prepend (cmdexe + " /c")
				end
				cl.append (" 2> ")
				cl.append (error_output_file_name)
				cl.append (" >> ")
				cl.append (output_file_name)
			else
				create finished_file_name.make_temporary_name
				cl.prepend ("sh -c ")
				cl.append (" > ")
				cl.append (output_file_name)
				cl.append (" 2> ")
				cl.append (error_output_file_name)
				cl.append (" ; echo finished > ")
				cl.append (finished_file_name)
			end
			create timer.make_with_interval (500)
			timer.actions.extend (agent check_not_finished)
			execution_environment.launch (cl)
			create running_dialog.make_initialized (1, preferences.dialog_data.executing_command_string, Interface_names.l_Executing_command, Interface_names.L_do_not_show_again, preferences.preferences)
			running_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
			timer.destroy
			Window_manager.for_all_development_windows (agent {EB_DEVELOPMENT_WINDOW}.enable_sensitive)
		end

	running_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			-- Dialog that is displayed while we wait for the output of the command.

	check_not_finished is
			-- Check that the current command is not finished, by checking
			-- for the presence of an output file.
		local
			f: PLAIN_TEXT_FILE
			retried: INTEGER
		do
			if Platform_constants.is_windows then
				if retried = 0 then
						--| We open in read/write mode to make sure the application
						--| has finished writing in it.
					create f.make_open_read_write (output_file_name)
					output_manager.clear
					running_dialog.destroy
					display_file_contents (f, Interface_names.l_Command_normal_output)
					retried := 2
					create f.make_open_read_write (error_output_file_name)
					display_file_contents (f, Interface_names.l_Command_error_output)
				elseif retried = 1 then
					create f.make_open_read_write (error_output_file_name)
					output_manager.clear
					running_dialog.destroy
					display_file_contents (f, Interface_names.l_Command_error_output)
				end
			else
				if retried = 0 then
					create f.make (finished_file_name)
					if f.exists then
						output_manager.clear
						running_dialog.destroy
						create f.make_open_read (output_file_name)
						display_file_contents (f, Interface_names.l_Command_normal_output)
						create f.make_open_read (error_output_file_name)
						display_file_contents (f, Interface_names.l_Command_error_output)
					end
				end
			end
		rescue
			retried := retried + 1
			retry
		end
		
	display_file_contents (f: PLAIN_TEXT_FILE; pref: STRING) is
			-- Read and display the contents of file `f' in the output tools.
			-- Prepend `pref' to the contents of the file.
		require
			f_readable: f /= Void and then f.is_open_read
		local
			retried: BOOLEAN
			st: STRUCTURED_TEXT
			i1, i2: INTEGER
			output: STRING
		do
			if not retried then
				if f.count > 0 then
					create output.make (pref.count + f.count)
					output.append (pref)
					f.read_stream (f.count)
					create st.make
					output.append (f.last_string)
					output.prune_all ('%R')
					from
						i2 := output.index_of ('%N', i1 + 1)
					until
						i2 = 0
					loop
						if i2 > i1 then
							st.extend (create {BASIC_TEXT}.make (output.substring (i1 + 1, i2 - 1)))
						end
						st.extend (create {NEW_LINE_ITEM}.make)
						i1 := i2
						i2 := output.index_of ('%N', i1 + 1)
					end
						-- Don't forget the last line...
					if i1 + 1 < output.count then
						st.extend (create {BASIC_TEXT}.make (output.substring (i1 + 1, output.count)))
					end
					output_manager.force_display
					output_manager.process_text (st)
				end
				f.close
				f.delete
			end
		rescue
			retried := True
			retry
		end

	output_file_name: FILE_NAME
			-- Name of the file where we expect to find an output.

	error_output_file_name: FILE_NAME
			-- Name of the file where we expect to find an error output.

	finished_file_name: FILE_NAME
			-- Name of the file that tells that execution completed (non Windows platforms).

	old_index: INTEGER
			-- Index of `Current' before we edited its properties.

end -- class EB_EXTERNAL_COMMAND
