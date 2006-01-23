indexing
	description: "[
		Objects that query the current installation directory of the tour.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSTALLATION_LOCATOR

feature -- Access

	installation_location: STRING is
			-- Location of installation.
			-- `Void' if environment variables not correctly set.
		local
			file_location: STRING
			directory_name: DIRECTORY_NAME
		do	
			file_location := execution_environment.get ("ISE_VISION2_TOUR")
			if file_location = Void then
				file_location := execution_environment.get ("ISE_EIFFEL")
				if file_location /= Void then
					create directory_name.make_from_string (file_location)
					directory_name.extend ("vision2_tour")
					if not valid_installation (directory_name.out) then
						directory_name := Void
					end
				end
			else
				create directory_name.make_from_string (file_location)
				if not valid_installation (directory_name.out) then
					directory_name := Void
				end
			end
			if directory_name /= Void then
				Result := directory_name.out
			end
		end
		
	has_environment_variables: BOOLEAN is
			-- Does "ISE_VISION2_TOUR" or "ISE_EIFFEL" exist on this system?
		do
			Result := Execution_environment.get ("ISE_VISION2_TOUR") /= Void
			if not result then
				Result := Execution_environment.get ("ISE_EIFFEL") /= Void
			end
		end

feature {NONE} -- Implementation

	valid_installation (root_location: STRING): BOOLEAN is
			-- Ensure that the Environment variables if found, are correct.
			-- To do this, we sample a few of the files required by the system.
			-- If they are not available, then the installation is not
			-- considered to be valid.
		local
			filename: FILE_NAME
			directory: DIRECTORY
		do
			Result := True
			create filename.make_from_string (root_location)
			filename.extend ("bitmaps")
			filename.extend ("png")
			create directory.make (filename)
			if not directory.exists then
				Result := False
			end
			
			create filename.make_from_string (root_location)
			filename.extend ("flatshort")
			create directory.make (filename)
			if not directory.exists then
				Result := False
			end
			
			create filename.make_from_string (root_location)
			filename.extend ("templates")
			create directory.make (filename)
			if not directory.exists then
				Result := False
			end
			
			create filename.make_from_string (root_location)
			filename.extend ("tests")
			create directory.make (filename)
			if not directory.exists then
				Result := False
			end
		end

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Once access to execution environment.
		once
			create Result
		end
		
	image_extension: STRING is
			-- Extension type of image formats on current platform.
			-- either "png" or "ico"
		once
			Result := "png"
		ensure
			Result_valid: Result.is_equal ("png")
		end

invariant
	execution_environment_not_void: execution_environment /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class INSTALLATION_LOCATOR
