indexing
	description: "finish freezing layout"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FINISH_FREEZING_EIFFEL_LAYOUT

inherit
	EIFFEL_ENV
		redefine
			shared_application_path
		end

feature -- Access

	application_name: STRING is "finish_freezing";

	shared_application_path: DIRECTORY_NAME is
			-- Location of shared files specific for the current application (platform independent).
		once
			Result := shared_path.twin
			Result.extend (short_studio_name)
		end

	config_eif: FILE_NAME is
			-- Location of `cofig.eif' file.
		require
			windows: platform.is_windows
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (config_eif_path)
			Result.set_file_name ("config")
			Result.add_extension ("eif")
		ensure
			config_eif_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	config_eif_path: DIRECTORY_NAME is
			-- Path to directory containing `config.eif'.
		require
			windows: platform.is_windows
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Config_path)
			Result.extend_from_array (<<eiffel_platform, eiffel_c_compiler>>)
		ensure
			config_eif_path_not_void_or_empty: Result /= Void and not Result.is_empty
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
