indexing
	description	: "This class is inherited by all the application"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_SHARED

inherit
	BENCH_WIZARD_SHARED

feature {NONE} -- Constants

	Emitter_location: DIRECTORY_NAME is
			-- Location for the eiffel compiler
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"bench", "wizards", "new_projects", "dotnet", "spec", Eiffel_platform, "bin">>)
		end

	Emitter_command: FILE_NAME is
		once
			create Result.make_from_string (Emitter_location)
			Result.set_file_name ("emitter")
		end

	Eiffel_installation_dir_name: STRING is
			-- ISE_EIFFEL name.
		once
			Result := execution_environment.get ("ISE_EIFFEL")
		end

	Eiffel_platform: STRING is
			-- ISE_PLATFORM name.
		once
			Result := execution_environment.get ("ISE_PLATFORM")
		end

	Interface_names: INTERFACE_NAMES is
			-- Interface names for buttons, label, ...
		once
			create Result
		end
		
	execution_environment: EXECUTION_ENVIRONMENT is
			-- Shared execution environment object
		once
			create Result
		end		

end -- class WIZARD_PROJECT_SHARED
