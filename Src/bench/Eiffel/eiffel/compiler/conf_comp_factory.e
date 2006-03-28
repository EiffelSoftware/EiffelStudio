indexing
	description: "Factory for configuration objects, used by the compiler."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_COMP_FACTORY

inherit
	CONF_FACTORY
		redefine
			new_class,
			new_class_assembly,
			new_class_partial,
			new_cluster
		end

feature

	new_class (a_file_name: STRING; a_group: CLUSTER_I; a_path: STRING): EIFFEL_CLASS_I is
			-- Create a `CONF_CLASS' object.
		do
			create Result.make (a_file_name, a_group, a_path)
		end

	new_class_assembly (a_name, a_dotnet_name: STRING; an_assembly: ASSEMBLY_I; a_position: INTEGER): EXTERNAL_CLASS_I is
			-- Create a `CONF_CLASS_ASSEMBLY' object.
		do
			create Result.make_assembly_class (a_name, a_dotnet_name, an_assembly, a_position)
		end

	new_class_partial (a_partial_classes: ARRAYED_LIST [STRING]; a_group: CLUSTER_I; a_base_location: CONF_LOCATION): PARTIAL_EIFFEL_CLASS_I is
			-- Create a `CONF_CLASS_PARTIAL' object.
		do
			create Result.make_from_partial (a_partial_classes, a_group, a_base_location)
		end

	new_cluster (a_name: STRING; a_directory: CONF_LOCATION; a_target: CONF_TARGET): CLUSTER_I is
			-- Create a `CONF_CLUSTER' object.
		do
			create Result.make (a_name, a_directory, a_target)
		end
end
