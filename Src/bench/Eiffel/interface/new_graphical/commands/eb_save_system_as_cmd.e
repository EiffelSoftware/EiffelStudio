indexing
	description: "Command to save the ace-file under a different name."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_SYSTEM_AS_CMD

inherit
	SHARED_EIFFEL_PROJECT
	EB_SAVE_FILE_AS_CMD
		redefine
			set_tool_new_name
		end

creation
	make

feature -- Updating

	set_tool_new_name (new_name: STRING) is
			-- Update the file name of the ace file.
		local
			show_text: EB_TEXT_FORMATTER
		do
			precursor (new_name)
			show_text ?= tool.last_format
			if show_text /= Void then
				Eiffel_ace.set_file_name (new_name)
			end;
		end

end -- class EB_SAVE_SYSTEM_AS_CMD
