indexing
	description: "Dialog that displays the printer choices."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINT_DIALOG

inherit
	EB_GENERAL_DATA
	NEW_EB_CONSTANTS
	EV_DIALOG
		redefine
			make
		end
	EB_TEXT_TOOL_CMD
		rename
			make as editor_make
		end
	EIFFEL_ENV

creation
	make, make_default

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create the dialog with parent `par'.
		local	
			p_label: EV_LABEL
--			sep: EV_HORIZONTAL_SEPARATOR
			hb: EV_HORIZONTAL_BOX
			b: EV_BUTTON
		do
			Precursor (par)

			create hb.make (display_area)
			create p_label.make_with_text (hb, Interface_names.t_Shell_command)
			create shell_cmd_field.make (hb)
			create print_to_file_t.make_with_text (display_area, Interface_names.t_Print_to_file)
			create postscript_t.make_with_text (display_area, Interface_names.t_Postscript)
			postscript_t.set_state (True)

--			create sep.make (display_area)
			create ok_b.make_with_text (action_area, Interface_names.b_Ok)
			ok_b.add_click_command (Current, ok_it)

			create cancel_b.make_with_text (action_area, Interface_names.b_Cancel)
			cancel_b.add_click_command (Current, cancel_it)
--			ok_b.set_width (cancel_b.width)

--			shell_cmd_field.set_width (150)
			shell_cmd_field.add_return_command (Current, ok_it)

			set_modal (true)
--			set_composite_attributes (Current)
		end

	make_default (a_tool: like tool) is
			-- Popup the dialog for command `a_cmd'.
		local
			shell_command: STRING
		do
			editor_make (a_tool)
			make (tool.parent_window)
			shell_command := clone (print_shell_command)
			shell_cmd_field.set_text (shell_command)
			set_title (tool.title)
			postscript_t.set_insensitive (filterable_format = Void)
			show
		end

feature {NONE} -- Implementation

	shell_cmd_field: EV_TEXT_FIELD
			-- Shell command field

	print_to_file_t, postscript_t: EV_CHECK_BUTTON

	ok_b, cancel_b: EV_BUTTON
			-- Push buttons

	ok_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	cancel_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	callback: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	file_save_d: EV_FILE_SAVE_DIALOG

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute the actions of the button.
		local
--			mp: MOUSE_PTR
			file_name: FILE_NAME
		do
			if arg = ok_it then
--				General_resources.print_shell_command.set_value 
--					(clone (shell_cmd_field.text))
--				create mp.set_watch_cursor
				if print_to_file_t.state then
					create file_save_d.make (tool.parent)
					file_save_d.add_ok_command (Current, Callback)
--					mp.restore
					file_save_d.show
					hide
				else
					create file_name.make_from_string (generate_temp_name)
					print_file (file_name, True)
--					mp.restore
					destroy
				end
			elseif arg = ok_it then
				destroy
			elseif arg = callback then
--				create mp.set_watch_cursor
				create file_name.make_from_string (file_save_d.file)
				print_file (file_name, False)
--				mp.restore
				destroy
			end
		end

feature {NONE} -- Implementation

	filterable_format: EB_FILTERABLE is
			-- returns the current format of `t',
			-- if `t' has a current format, and if
			-- this format is filterable.
		local
			mft: EB_MULTIFORMAT_TOOL
		do
			mft ?= tool
			if mft /= Void then
				Result ?= mft.last_format
			end
		end

	print_file (file_name: FILE_NAME; delete_after: BOOLEAN) is
			-- Print a file name.
		local
			cmd_string: STRING
			shell_request: EXTERNAL_COMMAND_EXECUTOR
			new_text: STRING
			file: PLAIN_TEXT_FILE
		do
			cmd_string := clone (shell_cmd_field.text)
			if not cmd_string.empty then
				cmd_string.replace_substring_all ("$target", file_name)
			end
			if filterable_format = Void or else not postscript_t.state then
				new_text := tool.text_area.text
			else
				new_text := filterable_format.filtered_text 
					(tool.stone, "PostScript")
			end
			if new_text /= Void then
				save_to_file (new_text, file_name)
				if not print_to_file_t.state then
					create shell_request
					shell_request.execute (cmd_string)
					if delete_after then
						create file.make (file_name)
						file.delete
					end
				end
			end
		end

	save_to_file (a_text: STRING; a_filename: STRING) is
			-- Save `a_text' in `a_filename'.
		require
			a_text_not_void: a_text /= Void
			a_filename_not_void: a_filename /= Void
		local
			char: CHARACTER
			new_file: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
		do
			if not a_filename.empty then
				create new_file.make (a_filename)
				if new_file.exists and then not new_file.is_plain then
					create wd.make_default (parent, Interface_names.t_Warning,
						Warning_messages.w_Not_a_plain_file (new_file.name))
				elseif new_file.exists and then not new_file.is_writable then
					create wd.make_default (parent, Interface_names.t_Warning,
						Warning_messages.w_Not_writable (new_file.name))
				elseif not new_file.exists and then not new_file.is_creatable then
					create wd.make_default (parent, Interface_names.t_Warning,
						Warning_messages.w_Not_creatable (new_file.name))
				else
					new_file.open_write
					if not a_text.empty then
						new_file.putstring (a_text)
						char := a_text.item (a_text.count)
						if char /= '%N' and then char /= '%R' then
								-- Add a carriage return like vi
								-- if there's none at the end
							new_file.new_line
						end
					end
					new_file.close
				end
			end
		end

feature {NONE} -- Externals

	generate_temp_name: STRING is
			-- Generate a temporary file name.
		local
			prefix_name: STRING
			a: ANY
			p: POINTER
		do
			prefix_name := "bench_"
			a := prefix_name.to_c
			p := tempnam (default_pointer, $a)

			create Result.make (0)
			Result.from_c (p)
		end

	tempnam (d,p: POINTER): POINTER is
		external
			"C | <stdio.h>"
		end

end -- class EB_PRINT_DIALOG
