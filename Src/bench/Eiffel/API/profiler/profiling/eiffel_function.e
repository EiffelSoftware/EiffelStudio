indexing

	description:
		"Information about an Eiffel feature.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_FUNCTION

inherit
	FUNCTION

creation
	make

feature -- Creation

	make (new_cluster, new_class, new_name: STRING) is
			-- Create an Eiffel feature with
			-- cluster `new_cluster', class `new_class',
			-- featurename `new_name'
		do
			cluster_name := new_cluster;
			int_class_name := new_class;
			feature_name := new_name;
		end;

feature -- Output

	name: STRING is
			-- The name of the feature.
		do
			!!Result.make (0);
			Result.append_string (cluster_name);
			Result.extend ('.');
			Result.append_string (int_class_name);
			Result.extend ('.');
			Result.append_string (feature_name);
		end;

feature {NONE} -- Attributes

	cluster_name: STRING
		-- Name of cluster where the class is in,
		-- as denoted in the Ace file.

	int_class_name: STRING
		-- Name of class to which `feature_name' belongs.

	feature_name: STRING
		-- Eiffel feature name as declared in source code.

end -- class EIFFEL_FUNCTION
