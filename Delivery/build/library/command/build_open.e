indexing

	description:
		"EiffelBuild predefined command for opening a file.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BUILD_OPEN

inherit

	BUILD_CMD
		rename
			context_data as nothing_data
		undefine
			set_context_data, context_data_useful
		end;

	COMMAND
		rename
			execute as oui_execute
		end

creation

	make

feature -- Initialization

	make (arg1: SCROLLED_T) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1;
			!!file_box.make ("File Box", argument1.top);
			!!error_box.make ("Alert", argument1.top);
			error_box.hide_help_button;
			error_box.hide_cancel_button;
			error_box.add_ok_action (Current, Void);
			error_box.set_exclusive_grab;
		end;

feature -- Access

	open_label: STRING is "open";
			-- Text of label for Open transition

	cancel_label: STRING is "cancel";
			-- Text of label for Cancel transition

	argument1: SCROLLED_T;
			-- The command's argument

	asked_for_name: BOOLEAN;	
			-- Has the user been asked for a name?

	file_box: FILE_BOX;
			-- File box to specify file

	error_box: ERROR_D;
			-- Error dialog to display error messages

feature -- Execution

	execute is
			-- Popup file box and retrieve file name entered
			-- by the user. If a valid file name is selected then
			-- set the transition to `open_label' and display
			-- the contents of the file in `argument1'. If cancel
			-- is selected then set the transition to `cancel_label'.
		local
			file: PLAIN_TEXT_FILE;
			msg, error_tag: STRING
		do
			if not asked_for_name then
				asked_for_name := True;
				file_box.popup (Current)
			else
				asked_for_name := False;
				if not file_box.canceled then
					!!file.make (file_box.selected_file);
					if file.exists then
						if file.is_directory then
							error_tag := "file is directory";
						elseif not file.is_readable then	
							error_tag := "file not readable";
						end
					else
						error_tag := "file does not exist";
					end
					if error_tag = Void then
						if not file.empty then 
							file.open_read;
							file.readstream (file.count);
							argument1.set_text (file.laststring);
							file.close;
						end
						set_transition_label (open_label)
					else
						!!msg.make (0);
						msg.append ("Cannot open: %"");
						msg.append (file.name);
						msg.append ("%"");	
						msg.append ("%NReason: ");
						msg.append (error_tag);
						error_box.set_message (msg);
						error_box.popup;
					end
				else
					set_transition_label (cancel_label);
				end;
			end;
		end;

	oui_execute (argument: ANY) is
			-- Popdown the error dialog.
		do
			error_box.popdown
		end;

end -- class BUILD_OPEN

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
