indexing
	description: "Setup environment variables for Visual Studio C compiler."
	date: "$Date$"
	revision: "$Revision$"

class
	VS_SETUP

inherit
	EXECUTION_ENVIRONMENT
		rename
			command_line as non_used_command_line
		export
			{NONE} non_used_command_line
		end
		
	PATH_CONVERTER

create
	make

feature -- Initialization

	make is
			-- Create and setup environment variables for currently installed
			-- version of Visual Studio.
		do
			create variables.make (5)
			initialize_env_vars
		end

	initialize_env_vars is
			-- If use has a valid vsvars32.bat file then run it to ensure environment variables
			-- are set correctly when attempting C compilation, otherwise do nothing.
		local
			l_batch_file,
			l_temp_file: RAW_FILE
			l_var_string: STRING
		do
			if valid_vcvars then
				create l_batch_file.make_open_write ("finish_freezing.bat")
						-- Unset the INCLUDE, LIB and PATH.
				l_batch_file.putstring ("echo off")
				l_batch_file.new_line		
				l_batch_file.putstring ("set INCLUDE=")
				l_batch_file.new_line
				l_batch_file.putstring ("set LIB=")
				l_batch_file.new_line
				l_batch_file.putstring ("set PATH=")
				l_batch_file.new_line
				l_batch_file.putstring ("call " + short_path (Vcvars32_bat_path_and_filename))
				l_batch_file.new_line
				l_batch_file.putstring ("set > temp")
				l_batch_file.new_line
				l_batch_file.close
				env.system (l_batch_file.name)
				l_batch_file.delete
				create l_temp_file.make_open_read ("temp")
				if l_temp_file.exists then
					from
						l_temp_file.start
					until
						l_temp_file.end_of_file
					loop
						l_temp_file.read_line
						l_var_string := clone (l_temp_file.laststring)
						if l_var_string /= Void and not l_var_string.is_empty then
							parse_variable_string (l_var_string)
						end
					end
					l_temp_file.close
					l_temp_file.delete
				end
			end
		end
		
feature -- Implementation

	parse_variable_string (a_string: STRING) is
			-- Given 'a_string' parse and extract the environment variable from it.
		require
			a_string_not_void: a_string /= Void
			a_string_not_empty: not a_string.is_empty
			a_string_valid: a_string.occurrences ('=') >= 1
		local
			l_split_list: LIST [STRING]
		do
			l_split_list := a_string.split ('=')
			if 
				l_split_list.first.is_equal ("INCLUDE") or 
				l_split_list.first.is_equal ("LIB") or
				l_split_list.first.is_equal ("PATH")
			then
				variables.put (l_split_list.i_th (2), l_split_list.first)
				synchronize_variable (l_split_list.first)				
			end
		end
		
	synchronize_variable (a_string: STRING) is
			-- Compare the variable value in 'variables' hashed by 'a_string' against
			-- actual system variable value known by 'a_string'.  Result will contain 
			-- all values in 'a_string' and in system without duplication.
		require
			a_string_not_void: a_string /= Void
		local
			l_system_var_values,
			l_local_var_values: LIST [STRING]
			l_new_var_value: STRING
			l_value, l_name: WEL_STRING
			success: BOOLEAN
		do
			create l_name.make (a_string)
					-- Get the environment variable value for this process.
			l_local_var_values := variables.item (a_string).split (';')	
			if l_local_var_values /= Void and not l_local_var_values.is_empty then
						-- Get the corresponding system environment variable.
				l_system_var_values := env.get (a_string).split (';')
				if l_system_var_values /= Void and not l_system_var_values.is_empty then
					create l_new_var_value.make_empty
					from
						l_system_var_values.start
					until
						l_system_var_values.after
					loop
						if not l_local_var_values.has (l_system_var_values.item) then
							l_local_var_values.extend (l_system_var_values.item)
						end
						l_system_var_values.forth
					end
							-- Now extract the full value containing all options.
					from
						l_local_var_values.start
					until
						l_local_var_values.after
					loop
						l_new_var_value.append (l_local_var_values.item + ";")
						l_local_var_values.forth 
					end
					create l_value.make (l_new_var_value)
					success := set_environment_variable (l_name.item, l_value.item)
				else
						-- There is no system variable known by 'a_string' or it is empty
						-- so just set the local one.
					create l_value.make (variables.item (a_string))
					success := set_environment_variable (l_name.item, l_value.item)
				end
			end
		end

feature -- Keys

	Vcvars32_bat_path_and_filename: STRING is
			-- Full path and filename of vcvars32.bat file.
		local
			l_dir: STRING
		once
			l_dir := Visual_studio_common_dir
			if l_dir /= Void then
				Result := Visual_studio_common_dir + "bin\" + "vcvars32.bat"
			end
		end

	Visual_studio_common_dir: STRING is
			-- Path the the Visual Studio 'Common' directory.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
			check_for_vs6: BOOLEAN
		once
			create reg
					-- First look for Visual Studio 7.0.
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\7.0\Setup\VC",
				feature {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
			if p /= default_pointer then
				key := reg.key_value (p, "ProductDir")
				reg.close_key (p)	
				if key /= Void then
					Result := key.string_value
					vs_version := 7
				else
					check_for_vs6 := True
				end
			else
				check_for_vs6 := True
			end
			
			if check_for_vs6 then
						-- Since previous failed now look for Version 6.0 instead.
				p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\6.0\Setup\MicrosoftVisualC++",
					feature {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
				if p /= default_pointer then
					key := reg.key_value (p, "ProductDir")
					reg.close_key (p)
					if key /= Void then
						Result := key.string_value
						vs_version := 6
					end
				end
			end
		end

feature -- Access

	variables: HASH_TABLE [STRING, STRING]
		-- Variable names and values.

	vs_version: INTEGER
			-- Version of Visual Studio installed.

	valid_vcvars: BOOLEAN is
			-- Is the vc_vars32.bat file a valid file?
		local
			l_vc_vars: RAW_FILE
		once
			create l_vc_vars.make (Vcvars32_bat_path_and_filename)
			Result := l_vc_vars.exists
		end

	env: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

	has_vs_installed: BOOLEAN is
			-- Was a version for VS installed?
		do
			Result := vs_version = 6 or vs_version = 7
		end
		
feature -- Externals

	set_environment_variable (name, value: POINTER): BOOLEAN is
			-- Set environment variable `name' with value `value'.
			-- Return True if successful.
		external
			"C macro signature (LPCTSTR, LPCTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"SetEnvironmentVariable"
		end
		
end -- class VS_SETUP
