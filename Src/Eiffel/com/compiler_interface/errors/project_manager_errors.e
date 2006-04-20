indexing
  description: "Errors that can happen during project loading/compiling"
	legal: "See notice at end of class."
	status: "See notice at end of class."
  date: "$Date$"
  revision: "$Revision$"

class
	PROJECT_MANAGER_ERRORS
  
inherit
	ECOM_EIF_EXCEPTIONS_ENUM
		export
			{NONE} all
		end
  
feature {NONE} -- Error Messages

	errors_table: HASH_TABLE [STRING, INTEGER] is
			-- errors table for project manager
		once
			create Result.make (13)
			Result.put ("An unexpected error occurred within the Eiffel compiler.", eif_exceptions_unspecified)
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
			Result.put ("Unable to initialize project directory", eif_exceptions_unable_to_initialize_project)
		ensure
			non_void_result: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class PROJECT_MANAGER_ERRORS
