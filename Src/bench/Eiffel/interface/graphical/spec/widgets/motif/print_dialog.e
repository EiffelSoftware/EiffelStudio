indexing

	description:
		"Dialog that displays the printer choices."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_DIALOG

inherit

	CLOSEABLE;
	EB_CONSTANTS;
	EB_FORM_DIALOG
		rename
			make as eb_form_make,
			popup as eb_form_popup
		end;
	COMMAND;
	WINDOW_ATTRIBUTES;
	EIFFEL_ENV

feature {NONE} -- Initialization

	make (a_parent: COMPOSITE) is
			-- Create the dialog.
		local	
			sep: THREE_D_SEPARATOR;
			rc, p_row, t_row: ROW_COLUMN;
			p_label: LABEL;
			form: FORM;
			mb: MEL_PUSH_BUTTON
		do
			eb_form_make (Interface_names.t_Empty, a_parent);
			create rc.make (Interface_names.t_empty, Current);
			attach_left (rc, 0);
			attach_right (rc, 0);
			attach_bottom (rc, 0);
			attach_top (rc, 0);
			rc.set_margin_height (5);
			rc.set_margin_width (0);
			create p_row.make (Interface_names.t_empty, rc);
			p_row.set_row_layout;
			create p_label.make (Interface_names.t_Shell_command, p_row);
			create shell_cmd_field.make (Interface_names.t_Shell_command, p_row);
			create t_row.make (Interface_names.t_empty, rc);
			create print_to_file_t.make (Interface_names.t_Print_to_file, t_row);
			create postscript_t.make (Interface_names.t_Postscript, t_row);
			create sep.make (Interface_names.t_empty, rc);
			create form.make (Interface_names.t_Empty, rc);
			create ok_b.make (Interface_names.b_Ok, form);
			create cancel_b.make (Interface_names.b_Cancel, form);
			form.attach_left (ok_b, 15);
			form.attach_top (ok_b, 0);
			form.attach_bottom (ok_b, 0);
			form.attach_right (cancel_b, 15);
			form.attach_top (cancel_b, 0);
			form.attach_bottom (cancel_b, 0);

			postscript_t.set_toggle_on;
			ok_b.set_width (cancel_b.width);
			ok_b.add_activate_action (Current, ok_b);
			cancel_b.add_activate_action (Current, cancel_b);
			shell_cmd_field.set_width (150);
			shell_cmd_field.add_activate_action (Current, ok_b);
			mb ?= ok_b.implementation;
			mb.set_default_button_shadow_thickness (1);
			mb ?= cancel_b.implementation;
			mb.set_default_button_shadow_thickness (1);

			set_exclusive_grab;
			set_composite_attributes (Current);
			realize;
		end;

feature {NONE} -- Access

	shell_cmd_field: TEXT_FIELD;
			-- Shell command field

	print_to_file_t, postscript_t: TOGGLE_B;

	ok_b, cancel_b: PUSH_B
			-- Push buttons

	last_command: TOOL_COMMAND
			-- Last tool command

feature -- Removal

	close is
			-- Close the dialog.
		do
			popdown
		end;

feature -- Update

	popup (a_cmd: TOOL_COMMAND) is
			-- Popup the dialog for command `a_cmd'.
		local
			mb: MEL_PUSH_BUTTON;
			mf: MEL_FORM_DIALOG;
			filterable_format: FILTERABLE
			shell_command: STRING
		do
			if destroyed then
				make (a_cmd.popup_parent)
			end;
			last_command := a_cmd;
			shell_command := clone (General_resources.print_shell_command.value);
			shell_cmd_field.set_text (shell_command);
			set_title (a_cmd.tool.title);
			mb ?= ok_b.implementation;
			mb.set_show_as_default (1);
			if a_cmd.tool.last_format /= Void then
				filterable_format ?= a_cmd.tool.last_format.associated_command;
			end
			if filterable_format = Void then
				postscript_t.set_insensitive
			else
				postscript_t.set_sensitive
			end;
			display
		end;

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute the actions of the button.
		local
			chooser: like last_name_chooser;
			mp: MOUSE_PTR;
			file_name: FILE_NAME
		do
			if arg = last_name_chooser then
				create mp.set_watch_cursor;
				create file_name.make_from_string (last_name_chooser.selected_file)
				print_file (file_name, False);
				mp.restore;
			elseif arg = cancel_b then
				popdown
			elseif arg = ok_b then
				General_resources.print_shell_command.set_value 
					(clone (shell_cmd_field.text));
				create mp.set_watch_cursor;
				if print_to_file_t.state then
					chooser := name_chooser (last_command.popup_parent);
					mp.restore;
					close;
					chooser.call (Current)
				else
					create file_name.make_from_string (generate_temp_name)
					print_file (file_name, True);
					mp.restore;
					close
				end;
			end
		end

feature {NONE} -- Implementation

	print_file (file_name: FILE_NAME; delete_after: BOOLEAN) is
			-- Print a file name.
		local
			cmd_string: STRING;
			shell_request: EXECUTION_ENVIRONMENT;
			new_text: STRING;
			filterable_format: FILTERABLE;
			file: PLAIN_TEXT_FILE
		do
			cmd_string := clone (shell_cmd_field.text);
			if not cmd_string.empty then
				cmd_string.replace_substring_all ("$target", file_name);
			end;
			if last_command.tool.last_format /= Void then
				filterable_format ?= last_command.tool.last_format.associated_command;
			end
			if filterable_format = Void or else not postscript_t.state then
				new_text := last_command.text_window.text;
			else
				new_text := filterable_format.filtered_text 
					(last_command.tool.stone, "PostScript");
			end;
			if new_text /= Void then
				save_to_file (new_text, file_name);
				if not print_to_file_t.state then
					create shell_request
					shell_request.system (cmd_string)
					if delete_after then
						create file.make (file_name)
						file.delete
					end
				end
			end
		end;

	save_to_file (a_text: STRING; a_filename: STRING) is
			-- Save `a_text' in `a_filename'.
		require
			a_text_not_void: a_text /= Void;
			a_filename_not_void: a_filename /= Void
		local
			char: CHARACTER;
			new_file: PLAIN_TEXT_FILE
		do
			if not a_filename.empty then
				create new_file.make (a_filename);
				if new_file.exists and then not new_file.is_plain then
					warner (Current).gotcha_call
						(Warning_messages.w_Not_a_plain_file (new_file.name))
				elseif new_file.exists and then not new_file.is_writable then
					warner (Current).gotcha_call
						(Warning_messages.w_Not_writable (new_file.name))
				elseif not new_file.exists and then not new_file.is_creatable then
					warner (Current).gotcha_call
						(Warning_messages.w_Not_creatable (new_file.name))
				else
					new_file.open_write;
					if not a_text.empty then
						new_file.put_string (a_text);
						char := a_text.item (a_text.count);
						if char /= '%N' and then char /= '%R' then
								-- Add a carriage return like vi
								-- if there's none at the end
							new_file.put_new_line
						end
					end;
					new_file.close
				end
			end
		end;

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

end -- class PRINTER_DIALOG
