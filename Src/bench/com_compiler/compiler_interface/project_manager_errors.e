indexing
  description: "Objects that ..."
  author: ""
  date: "$Date$"
  revision: "$Revision$"

class
	PROJECT_MANAGER_ERRORS
  
inherit
	ECOM_eif_exceptions_ENUM
		export
			{NONE} all
		end
  
feature {NONE} -- Error Messages

	errors_table: HASH_TABLE [STRING, INTEGER] is
			-- errors table for project manager
		once
			create Result.make (13)
			Result.put ("A project has not been succesfully loaded.", eif_exceptions_no_project_loaded)
			Result.put ("Project was compiled with an alternative version of the compiler.", eif_exceptions_project_incompatible)
			Result.put ("Project file is corrurpted.", eif_exceptions_project_file_corrupted)
			Result.put ("Unable to remove existing project.", eif_exceptions_unable_to_remove_project)
			Result.put ("Unable to create new project", eif_exceptions_unable_to_create_project)
			Result.put ("Specified ace file is invalid", eif_exceptions_invalid_ace_file)
			Result.put ("Project has not been succesfully compiled", eif_exceptions_project_not_compiled)
			Result.put ("Ace file does not exists", eif_exceptions_ace_file_does_not_exists)
			Result.put ("A project has already been loaded!", eif_exceptions_project_already_initialized)
			Result.put ("Project file is incomplete", eif_exceptions_project_incomplete)
			Result.put ("Read/Write error - could not read project file", eif_exceptions_ioerror)
			Result.put ("Project file has not been compiled for .NET", eif_exceptions_non_dotnet_project)
		ensure
			non_void_result: Result /= Void
		end
		

end -- class PROJECT_MANAGER_ERRORS
