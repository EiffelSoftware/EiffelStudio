indexing
	description	: "This class is inherited by all the application"
	author		: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_SHARED
	
feature {NONE} -- Constants

	Default_precompiled_location: DIRECTORY_NAME is
			-- Default location for the precompiled base
			-- $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"precomp", "spec", Eiffel_platform>>)
		end

	Eiffel_compiler_location: DIRECTORY_NAME is
			-- Location for the eiffel compiler
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "spec", Eiffel_platform, "bin">>)
		end

	Eiffel_compiler_command: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_compiler_location)
			Result.set_file_name ("ec")
		end

	Eiffel_installation_dir_name: STRING is
			-- ISE_EIFFEL name.
		once
			Result := execution_environment.get ("ISE_EIFFEL")
		end

	Eiffel_platform: STRING is
			-- PLATFORM name.
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

end -- class PROJECT_WIZARD_SHARED
