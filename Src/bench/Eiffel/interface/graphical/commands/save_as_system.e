indexing

	description:	
		"Command to save the ace-file under a different name.";
	date: "$Date$";
	revision: "$Revision$"


class SAVE_AS_SYSTEM 

inherit

	SHARED_EIFFEL_PROJECT;
	SAVE_AS_FILE
		redefine
			make, update_more
		end

creation

	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (a_text_window)
		end;

feature -- Updating

	update_more is
			-- Update the file name of the ace file.
		local
			show_text: SHOW_TEXT
		do
			show_text ?= text_window.last_format_2.associated_command;
			if show_text /= Void then
				Eiffel_project.set_lace_file_name (text_window.file_name)
			end;
		end

end -- class SAVE_AS_SYSTEM
