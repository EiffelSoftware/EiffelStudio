indexing
	description	: "This class is inherited by all the application"

class
	WIZARD_PROJECT_SHARED

inherit
	BENCH_WIZARD_SHARED

feature {NONE} -- Constants

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
