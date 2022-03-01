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
		do
			Result := internal_c_configuration
			check
				from_precondition_has_valid_configuration: attached Result
			then
			end
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

	is_msc_vc140_configuration: BOOLEAN
			-- Is this VS 2015 or later?
		require
			has_checked: has_checked
		do
			Result := attached {VS_2015_CONFIG} internal_c_configuration
					or attached {VS_SETUP_CONFIG} internal_c_configuration
					-- Note: VS_20(17|19|22)_CONFIG inherits from VS_SETUP_CONFIG
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

			create l_manager.make (not {PLATFORM}.is_64_bits)
			l_config := l_manager.best_configuration (Void)
			if l_config /= Void then
				internal_c_configuration := l_config

			elseif {PLATFORM}.is_64_bits then
					-- In a 64bit environment we need to check both 64 and 32 bit configurations to ensure the user did not install a compiler
					-- by mistake.

					-- Try 32bit environment
				create l_x86_manager.make (True)
				l_config := l_x86_manager.best_configuration (Void)
				if l_config /= Void then
						-- 32bit environment found, indicate the error.
					set_error (e_x86_version_installed_1, <<l_config.description>>)
				else
					l_no_compatible := True
				end
			else
				l_no_compatible := True
			end

			if l_no_compatible then
				create l_compilers.make (1024)
				across l_manager.configs as ia_config loop
						-- Only list supported configurations.
					l_compilers.append_string_general ("%N    - ")
					l_compilers.append_string_general (ia_config.item.description)
				end
				set_error (e_no_compatible_compiler_1, <<l_compilers>>)
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

feature {NONE} -- Localization

	e_x86_version_installed_1: STRING_32 = "The installed version of $1 is a 32-bit (x86) environment. You are currently running a 64-bit (x64) application!"
	e_no_compatible_compiler_1: STRING_32 = "No compatible version of Visual Studio, VC Express, or Windows SDK found!%NThe following environments are supported:$1"
	e_x86_compiler_binary_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1' is a 32-bit compiler. Please install the 64-bit (x64) C/C++ tools!"
	e_x64_compiler_binary_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1'  is a 64-bit compiler. Please install the 32-bit (x86) C/C++ tools!"
	e_corrupt_compiler_binary_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1' is not a valid executable file!"
	e_no_compiler_1: STRING_32 = "$1 was found but could not be configured, indicating some of its installation files have been moved or deleted. Please also check you have installed the $2 C/C++ compiler tools."
	e_compiler_deprecated_1: STRING_32 = "The located Microsoft C/C++ compiler at '$1' has been deprecated and cannot be used. Please upgrade to one of the supported C/C++ compilers."

;note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
