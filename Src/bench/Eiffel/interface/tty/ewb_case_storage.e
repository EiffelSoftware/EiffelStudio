indexing
	description: "Store Eiffelcase readable format of system to disk.";
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

feature {NONE} -- Implementation

	execute is
		local
			format_storage: FORMAT_CASE_STORAGE
		do
				-- We generate all clusters by default
			!! format_storage.make (output_window, degree_output, True);
			format_storage.execute ("")
		end

end -- class EWB_CASE_STORAGE
