indexing

	description: 
		"Displays clusters of the universe in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_CLUSTERS 

inherit

	EWB_SYSTEM
		rename
			name as clusters_cmd_name,
			help_message as clusters_help,
			abbreviation as clusters_abb
		end

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_CLUSTERS is
			-- Associated system command to be executed
		do
			create Result.make
		end;

end -- class EWB_CLUSTERS
