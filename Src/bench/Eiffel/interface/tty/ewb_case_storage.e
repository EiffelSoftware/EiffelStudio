indexing

	description: 
		"Store Eiffelcase readable format of system to disk.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_CASE_STORAGE 

inherit

	EWB_SYSTEM
		rename
			name as storage_cmd_name,
			help_message as storage_help,
			abbreviation as storage_abb
		end

feature {NONE} -- Implementation

	associated_cmd: E_STORE_CASE_INFO is
			-- Associated system command to be executed
		do
			!! Result.make_with_window (output_window)
		end;

end -- class EWB_CASE_STORAGE
