indexing
	description: "[
		Objects that query the current installation directory of the tour.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSTALLATION_LOCATOR

feature -- Access

	location: STRING is
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
				end
			else
				create directory_name.make_from_string (file_location)
			end
			if directory_name /= Void then
				Result := directory_name.out
			end
		end
		
feature {NONE} -- Implementation

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Once access to execution environment.
		once
			create Result
		end

invariant
	execution_environment_not_void: execution_environment /= Void

end -- class INSTALLATION_LOCATOR
