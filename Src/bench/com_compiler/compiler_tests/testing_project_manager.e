indexing
	description: "Project Manager for testing purposes"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTING_PROJECT_MANAGER

inherit
	PROJECT_MANAGER
	
	COMPILER_TESTER_SHARED

		
create
	make
	
feature -- Basic Operations

	reload_ace_project: BOOLEAN is
			-- reload ace file project
		require
			project_already_loaded: project_loaded
		do
			-- reset flags
			project_loaded_internal.set_item (False)
			Valid_project_ref.set_item (False)
			Result := load_Ace_project (ace_filename)
		end
		

	

end -- class TESTING_PROJECT_MANAGER
