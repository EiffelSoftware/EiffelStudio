indexing

	description: 
		"Edit class text.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EDIT_CLASS 

inherit

	EWB_EDIT;
	EWB_CLASS
		rename
			name as edit_class_cmd_name,
			help_message as edit_class_help,
			abbreviation as edit_class_abb
		redefine
			process_uncompiled_class
		end

feature {NONE} -- Execution

	associated_cmd: E_CLASS_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			check
				not_be_called: false
			end
		end;

	process_uncompiled_class (class_i: CLASS_I) is
			-- Edit class `class_i'.
		do
			edit (class_i.file_name);
		end;

end -- class EWB_EDIT_CLASS
