indexing

	description: 
		"Store Eiffelcase readable format of system to disk.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_CASE_STORAGE 

inherit

	EWB_CMD
		rename
			name as storage_cmd_name,
			help_message as storage_help,
			abbreviation as storage_abb
		end;
	WINDOWS

feature {NONE} -- Implementation

    execute is
        local
            cmd: E_STORE_CASE_INFO
        do
			!! cmd.make (output_window, Progress_dialog)
			cmd.execute;
        end;

end -- class EWB_CASE_STORAGE
