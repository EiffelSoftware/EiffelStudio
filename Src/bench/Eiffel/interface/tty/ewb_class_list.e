indexing

	description: 
		"Display list of the classes in the universe,%
		%in alphabetical order in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_CLASS_LIST 

inherit

	EWB_SYSTEM
		rename
			name as class_list_cmd_name,
			help_message as class_list_help,
			abbreviation as class_list_abb
		end

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_CLASSES is
			-- Associated system command to be executed
		do
			create Result.make
		end;

end -- class EWB_CLASS_LIST
