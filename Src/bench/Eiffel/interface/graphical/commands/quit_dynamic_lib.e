indexing

	description:	
		"Command to quit the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_DYNAMIC_LIB

inherit

	QUIT_FILE
		redefine 
			work, save_changes, loose_changes, tool
		end

creation

	make
	
feature -- Callbacks

	loose_changes is
		local
			f: PLAIN_TEXT_FILE
			res: BOOLEAN
		do
			if tool.Eiffel_dynamic_lib.file_name /= Void then
				!! f.make_open_read (tool.Eiffel_dynamic_lib.file_name)

				Res:= tool.Eiffel_dynamic_lib.parse_exports_from_file(f)
				tool.Eiffel_dynamic_lib.set_modified(False)
				tool.hide
			end
		end

	save_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end
			text_window.clear_window;
			tool.Eiffel_dynamic_lib.set_modified(False)
			tool.hide;
		end

feature

	tool: DYNAMIC_LIB_W

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if last_warner /= Void and argument = last_warner then
			else
				-- First click on open
				if tool.Eiffel_dynamic_lib.modified then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					text_window.clear_window;
					tool.hide;
					tool.close_windows;
				end
			end
		end;

end -- class QUIT_DYNAMIC_LIB

