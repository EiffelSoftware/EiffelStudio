indexing
	description: "Validity errors by id"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VALIDITY_STATUS_IDS

feature -- Access

	Eiffel_project, Ace_file, Eiffel_class, Eiffel_cluster,
	Component_definition_file, Destination_folder, Project_name, End_id: INTEGER is unique
			-- ids
	
	errors: ARRAY [STRING] is
			-- Error messages
		once
			create Result.make (1, 10)
			Result.put ("Path to Eiffel project file is invalid", Eiffel_project)
			Result.put ("Path to Eiffel project ACE file is invalid", Ace_file)
			Result.put ("Not a valid Eiffel class name", Eiffel_class)
			Result.put ("Not a valid Eiffel cluster name", Eiffel_cluster)
			Result.put ("Path to component definition file is invalid", Component_definition_file)
			Result.put ("Missing destination folder", Destination_folder)
			Result.put ("Project name contains invalid characters", Project_name)
		end

feature -- Status Report

	is_valid_status_id (a_id: INTEGER): BOOLEAN is
			-- Is `a_id' a valid status id?
		do
			Result := a_id > 0 and a_id < End_id
		end
		
end
