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

	Empty_string: STRING is ""
			-- Empty string

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Shared execution environment object
		once
			create Result
		end		

	Wizard_icon_name: STRING is "eiffel_wizard_icon"
			-- .NET Wizard icon name

	Interface_names: INTERFACE_NAMES is
			-- Interface names for buttons, label, ...
		once
			create Result
		end
		
	New_line: STRING is "%N"
			-- New line
	
	Tab: STRING is "%T"
			-- Tabulation

	Unrelevant_data: STRING is "-- Unrelevant data: root class is NONE --"
			-- Message appearing in window text fields in case the root class is NONE
			
	Windows_new_line: STRING is "%R%N"
			-- New line on Windows platform
			
end -- class WIZARD_PROJECT_SHARED
