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
				l_batch_file.put_string ("@echo off")
				l_batch_file.put_new_line		
				l_batch_file.put_string ("set INCLUDE=")
				l_batch_file.put_new_line
				l_batch_file.put_string ("set LIB=")
				l_batch_file.put_new_line
				l_batch_file.put_string ("set PATH=")
				l_batch_file.put_new_line
				l_batch_file.put_string ("call " + short_path (vcvars_full_path))
				l_batch_file.put_new_line
				l_batch_file.put_string ("set > temp")
				l_batch_file.put_new_line
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
						l_var_string := l_temp_file.last_string.twin
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

	vcvars_full_path: STRING is
			-- Most recent version of vsvarXX.bat to execute
		local
			l_buffer: STRING
			l_file: PLAIN_TEXT_FILE
		once
				-- VS.NET 2005
			l_buffer := vc_product_dir_for_vs_dotnet ("8.0")
			if l_buffer /= Void then
				create l_file.make (vcvars_bat_path_and_filename (l_buffer, 64))
				if l_file.exists then
					Result := l_file.name
				else
					create l_file.make (vcvars_bat_path_and_filename (l_buffer, 32))
					if l_file.exists then
						Result := l_file.name
					end
				end
			end
				-- VS.NET 2003
			if Result = Void then
				l_buffer := vc_product_dir_for_vs_dotnet ("7.1")
				if l_buffer /= Void then
					create l_file.make (vcvars_bat_path_and_filename (l_buffer, 32))
					if l_file.exists then
						Result := l_file.name
					end
				end
			end
			
				-- VS.NET 2002
			if Result = Void then
				l_buffer := vc_product_dir_for_vs_dotnet ("7.0")
				if l_buffer /= Void then
					create l_file.make (vcvars_bat_path_and_filename (l_buffer, 32))
					if l_file.exists then
						Result := l_file.name
					end
				end
			end
			
				-- VS 6.0
			if Result = Void then
				l_buffer := vc_product_dir_for_vs_6
				if l_buffer /= Void then
					create l_file.make (vcvars_bat_path_and_filename (l_buffer, 32))
					if l_file.exists then
						Result := l_file.name
					end
				end	
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
		end
		
feature {NONE} -- Keys
		
	vc_product_dir_for_vs_dotnet (a_version: STRING): STRING is
			--Retrieve product dir for VC from a Visual Studio .NET installation
		require
			a_version_not_void: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
		local
			l_key_path: STRING
		do
			create l_key_path.make (60 + a_version.count)
			l_key_path.append ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\")
			l_key_path.append (a_version)
			l_key_path.append ("\Setup\VC")
			Result := vc_product_dir_from_key (l_key_path)
		ensure
			valid_result: Result /= Void implies Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).directory_separator
		end

	vc_product_dir_for_vs_6: STRING is
			--Retrieve product dir for VC from a Visual Studio .NET installation
		do
			Result := vc_product_dir_from_key ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\6.0\Setup\MicrosoftVisual C++")
		ensure
			valid_result: Result /= Void implies Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).directory_separator
		end
		
	vc_product_dir_from_key (a_key_path: STRING): STRING is
			-- retrieve product dur from `a_key_path' in registry
		require
			a_key_path_not_void: a_key_path /= Void
			not_a_key_path_is_empty: not a_key_path.is_empty
		local
			l_reg: WEL_REGISTRY
			l_reg_key: POINTER
			l_key_value: WEL_REGISTRY_KEY_VALUE
			l_sep: CHARACTER
		do
			create l_reg
			l_reg_key := l_reg.open_key_with_access (a_key_path, feature {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
			if l_reg_key /= default_pointer then
				l_key_value := l_reg.key_value (l_reg_key, "ProductDir")
				l_reg.close_key (l_reg_key)	
				if l_key_value /= Void then
					Result := l_key_value.string_value
					l_sep := (create {OPERATING_ENVIRONMENT}).directory_separator
					if Result.item (Result.count) /= l_sep then
						Result.append_character (l_sep)
					end
				end
			end

		end

	vcvars_bat_path_and_filename (a_product_dir: STRING; a_bits: INTEGER): STRING is
			-- Full path and filename of vcvars`a_bit'.bat file from product instllation `a_product_dir'
		require
			non_void_a_product_dir: a_product_dir /= Void
			not_a_product_dir_is_empty: not a_product_dir.is_empty
			valid_a_product_dir: a_product_dir.item (a_product_dir.count) = (create {OPERATING_ENVIRONMENT}).directory_separator
			valid_a_bit: a_bits = 32 or a_bits = 64
		do
			Result := a_product_dir + "bin\vcvars" + a_bits.out + ".bat"
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Access

	variables: HASH_TABLE [STRING, STRING]
		-- Variable names and values.

	vs_version: INTEGER
			-- Version of Visual Studio installed.

	valid_vcvars: BOOLEAN is
			-- Is the vc_vars32.bat file a valid file?
		once			
			Result := vcvars_full_path /= Void
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