indexing
	description: "[
		Eiffel environment constant values.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EIFFEL_ENVIRONMENT_CONSTANTS

feature -- Variable names

	ise_eiffel_env: STRING = "ISE_EIFFEL"
			-- Installation location.

	ise_library_env: STRING = "ISE_LIBRARY"
			-- Location of the library folder.

	ise_precomp_env: STRING = "ISE_PRECOMP"
			-- Precompile location.

	ise_platform_env: STRING = "ISE_PLATFORM"
			-- Platform.

	ise_c_compiler_env: STRING = "ISE_C_COMPILER"
			-- C compiler (windows only)

	ise_projects_env: STRING = "ISE_PROJECTS"
			-- Project locations

	ise_user_files_env: STRING = "ISE_USER_FILES"
			-- User files location

	ise_app_data_env: STRING = "ISE_APP_DATA"
			-- User configuration files location

	ec_name_env: STRING = "EC_NAME"
			-- ec executable name.

feature -- Version

	major_version: NATURAL_16 = 6
			-- Major release version.

	minor_version: NATURAL_16 = 2
			-- Minor release version.

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
