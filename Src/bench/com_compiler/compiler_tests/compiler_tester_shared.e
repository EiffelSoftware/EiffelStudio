indexing
	description: "Shared components for testing the compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_TESTER_SHARED
	
feature -- Access

	epr_filename: STRING
		-- name of epr loaded
		
	ace_filename: STRING
		-- name of ace file
		
	project_loaded: BOOLEAN
		-- has a project already been loaded?
		
	project_manager: PROJECT_MANAGER
		-- active project manager for loaded project
		
	test_path: STRING is "C:\ISE.Compiler Testing"
		-- path to save files to
		
feature -- Basic Operations

	load_epr_project (a_epr_filename: STRING): BOOLEAN is
			-- load a compiled project
			-- returns True if loaded
		require
			non_void_epr_filename: a_epr_filename /= Void
			non_empty_epr_filename: not a_epr_filename.is_empty
			epr_filename_exists: (create {RAW_FILE}.make (a_epr_filename)).exists
		do
			if not project_loaded then
				create project_manager.make
				project_manager.retrieve_project (a_epr_filename)
				if project_manager.last_error_message /= Void and not project_manager.last_error_message.is_empty then
					io.putstring ("%N# Could not load project due to: '" + project_manager.last_error_message + "'")	
				else
					project_loaded := True
				end
			else
				io.putstring ("%N# A project has already been loaded - exit to restart")
			end
		end
		
	load_ace_project (a_ace_filename: STRING): BOOLEAN is
			-- load just the project settings
			-- returns True if loaded
		require
			non_void_ace_filename: a_ace_filename /= Void
			non_empty_ace_filename: not a_ace_filename.is_empty
			ace_filename_exists: (create {RAW_FILE}.make (a_ace_filename)).exists
		local
			l_test_path: DIRECTORY
		do
			if not project_loaded then
				create project_manager.make
				
				create l_test_path.make (test_path)
				if not l_test_path.exists then
					l_test_path.create_dir
				end
				
				project_manager.create_project (a_ace_filename, test_path)
				if project_manager.last_error_message /= Void and not project_manager.last_error_message.is_empty then
					io.putstring ("%N# Could not load project due to: '" + project_manager.last_error_message + "'")	
				else
					project_loaded := True
				end
			else
				io.putstring ("%N# A project has already been loaded - exit to restart")
			end
		end

end -- class COMPILER_TESTER_SHARED
