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
			update_more
		end

create

	make

feature -- Updating

	update_more is
			-- Update the file name of the ace file.
		local
			show_text: SHOW_TEXT
		do
			show_text ?= tool.last_format.associated_command;
			if show_text /= Void then
				Eiffel_ace.set_file_name (tool.file_name)
			end;
		end

end -- class SAVE_AS_SYSTEM
