
class EWB_EDIT_ACE 

inherit

	EWB_CMD
		rename
			name as edit_ace_cmd_name,
			help_message as edit_ace_help,
			abbreviation as edit_ace_abb
		end

feature

	execute is
		local
			lace_name: STRING;
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					lace_name := Lace.file_name
					if lace_name = Void then
						io.error.putstring ("You must select an Ace file first%N");
					else
						edit (Lace.file_name);
					end;
				end;
			end;
		end;

end
