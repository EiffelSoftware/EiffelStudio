indexing

	description: 
		"Display classes modified since last compilation%
		%in output window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_MODIFIED

inherit

	EWB_SYSTEM
		rename
			name as modified_cmd_name, 
			help_message as modified_help, 
			abbreviation as modified_abb
		end

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_MODIFIED_CLASSES is
			-- Associated system command to be executed
		once
			!! Result.do_nothing
		end;

end -- class EWB_MODIFIED
