indexing

	description: 
		"Edit Ace file.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT_ACE 

inherit

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
			lace_name := Lace.file_name
			if lace_name = Void then
				io.error.putstring ("You must select an Ace file first%N");
			else
				edit (Lace.file_name);
			end;
		end;

end -- class EWB_EDIT_ACE
