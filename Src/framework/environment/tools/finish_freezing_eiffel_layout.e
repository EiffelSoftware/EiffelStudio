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

feature -- Access

	application_name: !STRING_8 = "finish_freezing"
			-- <Precursor>

feature -- Directories

	config_eif_path: !DIRECTORY_NAME
			-- Path to directory containing `config.eif'.
		require
			is_valid_environment: is_valid_environment
			windows: {PLATFORM}.is_windows
		once
			Result ?= config_path.twin
			Result.extend_from_array (<<eiffel_platform, eiffel_c_compiler>>)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files

	config_eif_file_name: !FILE_NAME
			-- Location of `config.eif' file.
		require
			is_valid_environment: is_valid_environment
			windows: {PLATFORM}.is_windows
		local
			l_user: like user_priority_file_name
		once
			create Result.make_from_string (config_eif_path)
			Result.set_file_name ("config")
			Result.add_extension ("eif")

			if is_user_files_supported then
				l_user := user_priority_file_name (Result, True)
				if l_user /= Void then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
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
