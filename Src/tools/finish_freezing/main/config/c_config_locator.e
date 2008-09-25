indexing
	description: "[
		Attempts to locate the best C configuration possible, respecting corrupt installations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	C_CONFIG_LOCATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Locate a C configuration.
		do
			locate_c_configuration
		end

feature -- Access

	c_configuration: !C_CONFIG
			-- The best matched C configuration.
		require
			has_checked: has_checked
			has_valid_configuration: has_valid_configuration
		do
			Result ?= internal_c_configuration
		end

	c_configuration_error: !STRING
			-- The message associated with a detected C compiler configuration.
		require
			has_checked: has_checked
			not_has_valid_configuration: not has_valid_configuration
		do
			Result ?= internal_c_configuration_error
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	has_checked: BOOLEAN
			-- Indicates if Current has been checked for a C configuration yet.

	has_valid_configuration: BOOLEAN
			-- Indicates if a valid configuration was located.
		require
			has_checked: has_checked
		do
			Result := internal_c_configuration /= Void
		ensure
			internal_c_configuration_attached: Result implies internal_c_configuration /= Void
			internal_c_configuration_error_attached: not Result implies internal_c_configuration_error /= Void
		end

feature -- Status setting

	set_error (a_error: !STRING; a_args: ?TUPLE)
			-- Sets an error state for Current.
			--
			-- `a_error': An error string.
			-- `a_args': Any argument to replace $n with.
		require
			not_a_error_is_empty: not a_error.is_empty
		local
			l_count, i: INTEGER
			l_error: STRING
		do
			internal_c_configuration := Void

			create l_error.make_from_string (a_error)
			if a_args /= Void then
				l_count := a_args.count
				from i := 1 until i > l_count loop
					l_error.replace_substring_all ("$" + i.out, a_args.item (i).out)
					i := i + 1
				end
			end
			internal_c_configuration_error := l_error
		ensure
			internal_c_configuration_detached: internal_c_configuration = Void
			internal_c_configuration_error_attached: internal_c_configuration_error /= Void
			not_internal_c_configuration_error_is_empty: not internal_c_configuration_error.is_empty
		end

feature {NONE} -- Query

	file_assembly_type (a_exec: !STRING): INTEGER
			-- Determines what a PE file's assembly type is (x64/x86).
			--
			-- `a_exec': The location of an executable file name.
		require
			not_a_exec_is_empty: not a_exec.is_empty
			a_exec_exists: (create {RAW_FILE}.make (a_exec)).exists
		local
			l_file: !RAW_FILE
			l_offset: NATURAL
			retried: BOOLEAN
		do
			Result := unknown_assembly_type

			if not retried then
				create l_file.make_open_read (a_exec)
				if l_file.count > 0x3c then
					l_file.move (0x3c)

					l_file.read_natural_32 -- PE header (PEH) offset
					l_offset := l_file.last_natural_32 - 0x40
					if l_offset > 0 and then l_file.count.to_natural_32 > (0x3c + l_offset + 0x18 + 2) then
							-- Move pointer to optional header location
						l_file.move (l_offset.to_integer_32 + 0x18)

						l_file.read_natural_16 -- Read magic number (PE32 or PE32+)

						inspect l_file.last_natural_16
						when x86_assembly_type then
							Result := x86_assembly_type
						when x64_assembly_type then
							Result := x64_assembly_type
						else
							-- Do nothing, use default set Result
						end
					end
				end
			end

			if not l_file.is_closed then
				l_file.close
			end
		ensure
			result_is_valid_assembly_type:
				Result = x86_assembly_type or
				Result = x64_assembly_type or
				Result = unknown_assembly_type
		rescue
			retried := True
			retry
		end

feature -- Basic operations

	locate_c_configuration
			-- Attempts to locate a valid C compiler configuration, not just by looking at a configuration's
			-- installation set up, but also locating a compiler and ensuring it is bit-compatible.
		local
			l_manager: C_CONFIG_MANAGER
			l_x86_manager: C_CONFIG_MANAGER
			l_config: !C_CONFIG
			l_no_compatible: BOOLEAN
			l_compilers: !STRING
		do
			reset
			has_checked := True

			create l_manager.make (not {PLATFORM_CONSTANTS}.is_64_bits)
			if not l_manager.has_applicable_config then
				if {PLATFORM_CONSTANTS}.is_64_bits then
						-- In a 64bit environment we need to check both 64 and 32 bit configurations to ensure the user did not install a compiler
						-- by mistake.

						-- Try 32bit environment
					create l_x86_manager.make (True)
					if l_x86_manager.has_applicable_config then
							-- 32bit environment found, indicate the error.
						set_error (e_x86_version_installed_1, [l_x86_manager.best_configuration.description])
					else
						l_no_compatible := True
					end
				else
					l_no_compatible := True
				end

				if l_no_compatible then
					create l_compilers.make (1024)
					l_manager.ordered_configs.do_all (agent (ia_buffer: !STRING; ia_config: !C_CONFIG)
						do
							if not ia_config.is_deprecated then
									-- Only list supported configurations.
								ia_buffer.append ("%N    - ")
								ia_buffer.append (ia_config.description)
							end
						end (l_compilers, ?))
					set_error (e_no_compatible_compiler_1, [l_compilers])
				end
			else
					-- A configuration was located, lets make sure the required components are locatable and are the right assembly type.
				l_config ?= l_manager.best_configuration
				if l_config.is_deprecated then
						-- The configuration is deprecated.
					set_error (e_compiler_deprecated_1, [l_config.description])
				else
					internal_c_configuration := l_config
					check_compiler_executable (l_config)
				end
			end
		end

feature {NONE} -- Basic operations

	reset
			-- Resets the state of Current.
		do
			has_checked := False
			internal_c_configuration := Void
			internal_c_configuration_error := Void
		ensure
			not_has_checked: not has_checked
			internal_c_configuration_detached: internal_c_configuration = Void
			internal_c_configuration_error_detached: internal_c_configuration_error = Void
		end

	check_compiler_executable (a_config: !C_CONFIG) is
			-- Checks of a given file name in a canonicalized list of paths.
			--
			-- `a_config': A C configuration to use to locate the matching compiler'.
		require
			a_config_exists: a_config.exists
		local
			l_var_path: STRING
			l_var: STRING
			l_paths: LIST [STRING]
			l_path: !STRING
			l_file_name: STRING
			l_sep: CHARACTER
			l_has_file: BOOLEAN
			l_stop: BOOLEAN
		do
			create l_var_path.make (1024)
			l_var_path.append (a_config.path_var)

				-- Get PATH environment variable, incase the CL compiler is located there.
			l_var := (create {ENVIRONMENT_ACCESS}).get ("PATH")
			if l_var /= Void and then not l_var.is_empty then
				if not l_var_path.is_empty then
					l_var_path.append_character (';')
				end
				l_var_path.append (l_var)
			end

			l_sep := operating_environment.directory_separator
			l_file_name := a_config.compiler_file_name
			l_paths := l_var_path.split (';')

				-- Scan each path to find the first compiler file name match
			from l_paths.start until l_paths.after or l_stop or l_has_file loop
				l_path ?= l_paths.item
				if not l_path.is_empty then
					if l_path.item (l_path.count) /= l_sep  then
						l_path.append_character (l_sep)
					end
					l_path.append (l_file_name)
					l_has_file := (create {RAW_FILE}.make (l_path)).exists
					if l_has_file then
						inspect file_assembly_type (l_path)
						when x86_assembly_type then
							if {PLATFORM_CONSTANTS}.is_64_bits then
								l_has_file := False
								l_stop := True
								set_error (e_x86_compiler_binary_1, [l_path])
							end
						when x64_assembly_type then
							if not {PLATFORM_CONSTANTS}.is_64_bits then
								l_has_file := False
								l_stop := True
								set_error (e_x64_compiler_binary_1, [l_path])
							end
						else
								-- Not a valid PE file
							l_has_file := False
							l_stop := True
							set_error (e_corrupt_compiler_binary_1, [l_path])
						end
					end
				end
				l_paths.forth
			end

			if not l_has_file and not l_stop then
				if {PLATFORM_CONSTANTS}.is_64_bits then
					set_error (e_no_compiler_1, [a_config.description, "64-bit (x64)"])
				else
					set_error (e_no_compiler_1, [a_config.description, "32-bit (x86)"])
				end
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_c_configuration: ?like c_configuration
			-- Cached version of `c_configuration'.
			-- Note: Do not use directly!

	internal_c_configuration_error: ?like c_configuration_error
			-- Cached version of `c_configuration_error'.
			-- Note: Do not use directly!

feature {NONE} -- Constants

	unknown_assembly_type: INTEGER = 0
	x86_assembly_type: INTEGER = 0x10B
	x64_assembly_type: INTEGER = 0x20B
			-- Windows assembly type codes returned from `assembly_type'

feature {NONE} -- Localization

	e_x86_version_installed_1: !STRING = "The installed version of $1 is a 32-bit (x86) environment. You are currently running a 64-bit (x64) application!"
	e_no_compatible_compiler_1: !STRING = "No compatible version of Visual Studio, VC Express, or Windows SDK found!%NThe following environments are supported:$1"
	e_x86_compiler_binary_1: !STRING = "The located Microsoft C/C++ compiler at '$1' is a 32-bit compiler. Please install the 64-bit (x64) C/C++ tools!"
	e_x64_compiler_binary_1: !STRING = "The located Microsoft C/C++ compiler at '$1'  is a 64-bit compiler. Please install the 32-bit (x86) C/C++ tools!"
	e_corrupt_compiler_binary_1: !STRING = "The located Microsoft C/C++ compiler at '$1' is not a valid executable file!"
	e_no_compiler_1: !STRING = "$1 was found but is could not be configured, indicating some of its installation files have been moved or deleted. Please also check you have installed the $2 C/C++ compiler tools."
	e_compiler_deprecated_1: !STRING = "The located Microsoft C/C++ compiler at '$1' has been deprecated and cannot be used. Please upgrade to one of the supported C/C++ compilers."

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
