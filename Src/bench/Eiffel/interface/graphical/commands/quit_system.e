indexing

	description:	
		"Command to quit the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_SYSTEM 

inherit

	QUIT_FILE
		redefine 
			work, save_changes
		end

creation

	make
	
feature -- Callbacks

	save_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end
			text_window.clear_window;
			tool.hide;
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if last_warner /= Void and argument = last_warner then
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					text_window.clear_window;
					tool.hide;
					tool.close_windows;
				end
			end
		end;

end -- class QUIT_SYSTEM
