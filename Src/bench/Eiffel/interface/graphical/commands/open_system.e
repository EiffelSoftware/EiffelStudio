indexing

	description:	
		"Command to open a new ace file.";
	date: "$Date$";
	revision: "$Revision$"

class OPEN_SYSTEM 

inherit

	SHARED_EIFFEL_PROJECT;
	OPEN_FILE
		redefine
			make, work
		end;

creation

	make
	
feature -- Implementation

	make (a_text_window: SYSTEM_TEXT) is
			-- Initialize the command.
		do
			init (a_text_window)
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Open a file.
		local
			fn: STRING;
			f: RAW_FILE;
			temp: STRING
		do
			if argument /= Void and then argument = last_name_chooser then
				fn := clone (last_name_chooser.selected_file);
				if not fn.empty then
					!! f.make (fn);
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						text_window.show_file (fn);
						text_window.display_header (fn);
						Eiffel_project.set_lace_file_name (fn)
					elseif f.exists and then not f.is_plain then
						warner (text_window).custom_call (Current,
							w_Not_a_file_retry (fn), " OK ", Void, "Cancel")
					else
						warner (text_window).custom_call (Current, 
						w_Cannot_read_file_retry (fn), " OK ", Void, "Cancel");
					end
				else
					warner (text_window).custom_call (Current,
						w_Not_a_file_retry (fn), " OK ", Void, "Cancel")
				end
			else
				-- First click on open
				if text_window.changed then
					warner (text_window).call (Current, l_File_changed)
				else
					name_chooser (text_window).set_window (text_window);
					last_name_chooser.call (Current) 
				end
			end
		end;

end -- class OPEN_SYSTEM
