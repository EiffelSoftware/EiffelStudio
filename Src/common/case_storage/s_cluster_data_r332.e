indexing

	description: 
		"Updated version of S_CLUSTER_DATA for%
		%versions 3.3.2 and up";
	date: "$Date$";
	revision: "$Revision $"

class S_CLUSTER_DATA_R332

inherit

	S_CLUSTER_DATA
		redefine
			reversed_engineered_file_name 
		end

creation

	make

feature -- Properties

	reversed_engineered_file_name: STRING;
			-- Directory path of reversed engineered cluster
			-- (with environment variables not interpreted)

feature -- Setting

	set_reversed_engineered_file_name (fname: STRING) is
			-- Assign `fname' to `reversed_engineered_file_name'.
		do
			reversed_engineered_file_name := fname
		end

end -- class S_CLUSTER_DATA_R332
