indexing
	description: "Setup environment variables for Visual Studio C compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_batch_file, l_temp_file: RAW_FILE
			l_var_string, l_com_spec, l_cmd: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
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
				l_batch_file.put_string ("call " + short_path (vcvars_full_path) + " > temp ")
				l_batch_file.put_new_line
				l_batch_file.put_string ("set > temp")
				l_batch_file.put_new_line
				l_batch_file.close
				create l_process_launcher
				l_process_launcher.run_hidden
				l_com_spec := env.get ("ComSpec")
				check
					has_com_spec: l_com_spec /= Void
				end
				create l_cmd.make (l_com_spec.count + 4 + l_batch_file.name.count)
				l_cmd.append (l_com_spec)
				l_cmd.append (" /c ")
				l_cmd.append (l_batch_file.name)
				l_process_launcher.launch (l_cmd, Void, Void)
				l_batch_file.delete
				create l_temp_file.make ("temp")
				if l_temp_file.exists then
					l_temp_file.open_read
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
			-- actual system variable value known by 'a_string'. Result will contain 
			-- all values in 'a_string' and in system without duplication.
		require
			a_string_not_void: a_string /= Void
		local
			l_system_var_values,
			l_local_var_values: LIST [STRING]
			l_var_value, l_new_var_value: STRING
			l_value, l_name: WEL_STRING
			success: BOOLEAN
		do
			create l_name.make (a_string)
					-- Get the environment variable value for this process.
			check
				variables_has_a_string: variables.has (a_string)
			end
			l_local_var_values := variables.item (a_string).split (';')	
			if l_local_var_values /= Void and not l_local_var_values.is_empty then
						-- Get the corresponding system environment variable if it existed before.
				l_var_value := env.get (a_string)
				if l_var_value /= Void then
					l_system_var_values := l_var_value.split (';')
				end
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
			l_platform: PLATFORM
		once
			if is_windows_64_bits then
					-- We have been compiled for 64bits, meaning that we can only compile 64 bits code
					-- and we require at least Visual Studio .NET 2005.
				l_buffer := vc_product_dir_for_vs_dotnet ("8.0", 64)
				if l_buffer /= Void then
					create l_file.make (vcvars_bat_path_and_filename (l_buffer, 64))
					if l_file.exists then
						Result := l_file.name
					end
				end
			else
					-- VS.NET 2005 on 32 and 64 bits for 32 bits version of EiffelStudio
				l_buffer := vc_product_dir_for_vs_dotnet ("8.0", 64)
				if l_buffer = Void then
					l_buffer := vc_product_dir_for_vs_dotnet ("8.0", 32)
				end
				if l_buffer /= Void then
					create l_file.make (vcvars_bat_path_and_filename (l_buffer, 32))
					if l_file.exists then
						Result := l_file.name
					end
				end

					-- VS.NET 2003
				if Result = Void then
					l_buffer := vc_product_dir_for_vs_dotnet ("7.1", 32)
					if l_buffer /= Void then
						create l_file.make (vcvars_bat_path_and_filename (l_buffer, 32))
						if l_file.exists then
							Result := l_file.name
						end
					end
				end
				
					-- VS.NET 2002
				if Result = Void then
					l_buffer := vc_product_dir_for_vs_dotnet ("7.0", 32)
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
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
		end
		
feature {NONE} -- Keys
		
	vc_product_dir_for_vs_dotnet (a_version: STRING; a_platform: INTEGER): STRING is
			--Retrieve product dir for VC from a Visual Studio .NET installation
		require
			a_version_not_void: a_version /= Void
			not_a_version_is_empty: not a_version.is_empty
			a_platform_valid: a_platform = 32 or a_platform = 64
		local
			l_key_path: STRING
		do
			create l_key_path.make (60 + a_version.count)
			l_key_path.append ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\")
			l_key_path.append (a_version)
			l_key_path.append ("\Setup\VC")
			Result := vc_product_dir_from_key (l_key_path)
			
			if Result = Void and a_platform = 64 then
					-- Search the key in the `Wow6432Node'.
				create l_key_path.make (60 + a_version.count)
				l_key_path.append ("hkey_local_machine\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\")
				l_key_path.append (a_version)
				l_key_path.append ("\Setup\VC")
				Result := vc_product_dir_from_key (l_key_path)
			end
		ensure
			valid_result: Result /= Void implies Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).directory_separator
		end

	vc_product_dir_for_vs_6: STRING is
			--Retrieve product dir for VC from a Visual Studio .NET installation
		do
			Result := vc_product_dir_from_key ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\6.0\Setup\Microsoft Visual C++")
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
			l_reg_key := l_reg.open_key_with_access (a_key_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
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
			valid_64_bits: a_bits = 64 implies is_windows_64_bits
		do
			if a_bits = 64 then 
				Result := a_product_dir + "bin\amd64\vcvarsamd64.bat"
			else
				Result := a_product_dir + "bin\vcvars" + a_bits.out + ".bat"
			end
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
		
	is_windows_64_bits: BOOLEAN is
			-- Is Current running on Windows 64 bits?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_64_BITS"
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class VS_SETUP
