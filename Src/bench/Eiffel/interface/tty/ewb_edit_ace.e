indexing

	description: 
		"Edit Ace file.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT_ACE 

inherit

	EWB_EDIT;
	EWB_CMD
		rename
			name as edit_ace_cmd_name,
			help_message as edit_ace_help,
			abbreviation as edit_ace_abb
		end

feature {NONE} -- Execution

	execute is
		local
			lace_name: STRING;
		do
			lace_name := Eiffel_ace.file_name
			if lace_name = Void then
				io.error.put_string ("You must select an Ace file first%N");
			else
				edit (lace_name);
			end;
		end;

end -- class EWB_EDIT_ACE
