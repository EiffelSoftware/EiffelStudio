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
			-- $EIFFEL5/precomp/spec/$PLATFORM
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"precomp", "spec", Eiffel_platform>>)
		end

	Eiffel_compiler_location: DIRECTORY_NAME is
			-- Location for the eiffel compiler
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"bench", "spec", Eiffel_platform, "bin">>)
		end

	Eiffel_compiler_command: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_compiler_location)
			Result.set_file_name ("ec")
		end

	Eiffel_installation_dir_name: STRING is
			-- EIFFEL5 name.
		once
			Result := (create {EXECUTION_ENVIRONMENT}).get ("EIFFEL5")
		ensure
			Result_not_void: Result /= Void
		end

	Eiffel_platform: STRING is
			-- PLATFORM name.
		local
			ev_env: EV_ENVIRONMENT
		once
			Result := (create {EXECUTION_ENVIRONMENT}).get ("PLATFORM")
			if Result = Void then 
				create ev_env
				if ev_env.platform = ev_env.Ev_platform_win32 then
					Result := "windows"
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	Interface_names: INTERFACE_NAMES is
			-- Interface names for buttons, label, ...
		once
			create Result
		end

end -- class PROJECT_WIZARD_SHARED
