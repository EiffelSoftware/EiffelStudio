note
	description: "Eiffel compiler generated file hierarchy information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_PROJECT_CONTEXT

feature -- Access

	default_f_code_path (a_project_path: STRING): STRING
			-- Path to F_Code directory of system using target `Target_name'.
		require
			attached_project_path: a_project_path /= Void
		do
			Result := internal_f_code_path (a_project_path, Target_name)
		ensure
			attached_path: Result /= Void
		end

	f_code_path (a_project_path, a_config_path: STRING): STRING
			-- Path to F_Code folder of library target of system using configuration file `a_config_path'.
			-- `Void' if configuration file cannot be read.
		require
			attached_project_path: a_project_path /= Void
			attached_config_path: a_config_path /= Void
		local
			l_target: STRING
		do
			l_target := library_target (a_config_path)
			if l_target /= Void then
				Result := internal_f_code_path (a_project_path, l_target)
			end
		end

	library_target (a_config_path: STRING): STRING
			-- Library target name from `a_config_path'
			-- `Void' if configuration file cannot be read or if there is no library target.
		require
			attached_config_path: a_config_path /= Void
		local
			l_load: CONF_LOAD
		do
            create l_load.make (create {CONF_FACTORY})
            l_load.retrieve_configuration (a_config_path)
            if not l_load.is_error then
                Result := l_load.last_system.library_target.name
            end
        end

	Target_name: STRING = "default";
			-- Target used for compilations

feature {NONE} -- Implementation

	internal_f_code_path (a_project_path, a_target: STRING): STRING
			-- Path to F_Code directory of project at `a_project_path' using target `a_target_name'.
		require
			attached_project_path: a_project_path /= Void
			attached_target: a_target /= Void
		local
			l_dir: DIRECTORY_NAME
		do
			create l_dir.make_from_string (a_project_path)
			l_dir.extend ("EIFGENs")
			l_dir.extend (a_target)
			l_dir.extend ("F_Code")
			Result := l_dir
		ensure
			attached_path: Result /= Void
		end

invariant
	attached_target_name: Target_name /= Void

end -- class CODE_PROJECT_CONTEXT