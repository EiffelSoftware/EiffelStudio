indexing

	description: 
		"Display the indexing clause of classes in the universe%
		%in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_INDEXING

inherit

	EWB_FILTER_SYSTEM
		rename
			name as indexing_cmd_name, 
			help_message as indexing_help, 
			abbreviation as indexing_abb
		end;

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_INDEXING_CLAUSE is
			-- Associated system command to be executed
		do
			create Result.make
		end;

end -- class EWB_INDEXING
