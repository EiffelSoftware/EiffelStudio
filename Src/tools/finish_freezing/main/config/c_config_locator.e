note
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

	c_configuration: C_CONFIG
			-- The best matched C configuration.
		require
			has_checked: has_checked
			has_valid_configuration: has_valid_configuration
		local
			l_result: like internal_c_configuration
		do
			l_result := internal_c_configuration
			check l_result_attached: l_result /= Void end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

	c_configuration_error: STRING_32
			-- The message associated with a detected C compiler configuration.
		require
			has_checked: has_checked
			not_has_valid_configuration: not has_valid_configuration
		do
			if attached internal_c_configuration_error as l_error then
				Result := l_error
			else
				create Result.make_from_string_general ("Unknown error.")
			end
		ensure
			result_attached: Result /= Void
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

	is_msc15_configuration: BOOLEAN
			-- Is this VS 2015?
		require
			has_checked: has_checked
		do
			Result := attached {VS_2015_CONFIG} internal_c_configuration
		end

feature -- Status setting

	set_error (a_error: READABLE_STRING_GENERAL; a_args: detachable ARRAY [READABLE_STRING_GENERAL])
			-- Sets an error state for Current.
			--
			-- `a_error': An error string.
			-- `a_args': Any argument to replace $n with.
		require
			a_error_attached: a_error /= Void
			not_a_error_is_empty: not a_error.is_empty
		local
			l_count, i: INTEGER
			l_error: STRING_32
		do
			internal_c_configuration := Void

			create l_error.make_from_string_general (a_error)
			if a_args /= Void then
				l_count := a_args.upper
				from i := a_args.lower until i > l_count loop
					l_error.replace_substring_all ("$" + i.out, a_args.item (i).as_string_32)
					i := i + 1
				end
			end
			internal_c_configuration_error := l_error
		ensure
			internal_c_configuration_detached: internal_c_configuration = Void
			internal_c_configuration_error_attached: internal_c_configuration_error /= Void
			not_internal_c_configuration_error_is_empty: attached internal_c_configuration_error as l_cfg_error and then
				not l_cfg_error.is_empty
		end

feature {NONE} -- Query

	file_assembly_type (a_exec: PATH): INTEGER
			-- Determines what a PE file's assembly type is (x64/x86).
			--
			-- `a_exec': The location of an executable file name.
		require
			a_exec_attached: a_exec /= Void
			not_a_exec_is_empty: not a_exec.is_empty
			a_exec_exists: (create {RAW_FILE}.make_with_path (a_exec)).exists
		local
			l_file: detachable RAW_FILE
			l_offset: NATURAL
			retried: BOOLEAN
		do
			Result := unknown_assembly_type

			if not retried then
				create l_file.make_with_path (a_exec)
				l_file.open_read
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

			if l_file /= Void and then not l_file.is_closed then
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
			l_config: detachable C_CONFIG
			l_no_compatible: BOOLEAN
			l_compilers: STRING_32
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
						l_config := l_x86_manager.best_configuration
						check l_config_attached: l_config /= Void end
						set_error (e_x86_version_installed_1, <<l_config.description>>)
					else
						l_no_compatible := True
					end
				else
					l_no_compatible := True
				end

				if l_no_compatible then
					create l_compilers.make (1024)
					across l_manager.ordered_configs as ia_config loop
						if not ia_config.item.is_deprecated then
								-- Only list supported configurations.
							l_compilers.append_string_general ("%N    - ")
							l_compilers.append_string_general (ia_config.item.description)
						end
					end
					set_error (e_no_compatible_compiler_1, <<l_compilers>>)
				end
			else
					-- A configuration was located, lets make sure the required components are locatable and are the right assembly type.
				l_config := l_manager.best_configuration
				check l_config_attached: l_config /= Void end
				if l_config.is_deprecated then
						-- The configuration is deprecated.
					set_error (e_compiler_deprecated_1, <<l_config.description>>)
				else
					internal_c_configuration := l_config
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

feature {NONE} -- Implementation: Internal cache

	internal_c_configuration: detachable like c_configuration
			-- Cached version of `c_configuration'.
			-- Note: Do not use directly!

	internal_c_configuration_error: detachable like c_configuration_error
			-- Cached version of `c_configuration_error'.
			-- Note: Do not use directly!

feature {NONE} -- Constants

	unknown_assembly_type: INTEGER = 0
	x86_assembly_type: INTEGER = 0x10B
	x64_assembly_type: INTEGER = 0x20B
			-- Windows assembly type codes returned from `assembly_type'

feature {NONE} -- Localization

	e_x86_version_installed_1: STRING_32 = "The installed version of $1 is a 32-bit (x86) environment. You are currently running a 64-bit (x64) application!"
	e_no_compatible_compiler_1: STRING_32 = "No compatible version of Visual Studio, VC Express, or Windows SDK found!%NThe following environments are supported:$1"
	e_x86_compiler_binary_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1' is a 32-bit compiler. Please install the 64-bit (x64) C/C++ tools!"
	e_x64_compiler_binary_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1'  is a 64-bit compiler. Please install the 32-bit (x86) C/C++ tools!"
	e_corrupt_compiler_binary_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1' is not a valid executable file!"
	e_no_compiler_1: STRING_32 = "$1 was found but could not be configured, indicating some of its installation files have been moved or deleted. Please also check you have installed the $2 C/C++ compiler tools."
	e_compiler_deprecated_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1' has been deprecated and cannot be used. Please upgrade to one of the supported C/C++ compilers."

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
