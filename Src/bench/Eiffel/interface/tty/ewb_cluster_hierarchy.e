indexing

	description: 
		"Display the cluster hierarchy of the system";
	date: "$Date$";
	revision: "$Revision $"

class EWB_CLUSTER_HIERARCHY 

inherit

	EWB_SYSTEM
		rename
			name as cluster_hierarchy_cmd_name,
			help_message as cluster_hierarchy_help,
			abbreviation as cluster_hierarchy_abb
		end

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_CLUSTER_HIERARCHY is
			-- Associated system command to be executed
		do
			create Result.make
		end;

end -- class EWB_CLUSTER_HIERARCHY
