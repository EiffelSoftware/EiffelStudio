﻿note
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

	application_name: STRING_8
			-- <Precursor>
		once
			Result := "finish_freezing"
		end

feature -- Directories

	config_eif_path: PATH
			-- Path to directory containing `config.eif'.
		require
			is_valid_environment: is_valid_environment
			windows: {PLATFORM}.is_windows
		once
			Result := config_path.extended (eiffel_platform).extended (eiffel_c_compiler)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files

	config_eif_file_name: PATH
			-- Location of `config.eif' file.
		require
			is_valid_environment: is_valid_environment
			windows: {PLATFORM}.is_windows
		once
			Result := config_eif_path.extended ("config.eif")
			if
				is_user_files_supported and then
				attached user_priority_file_name (Result, True) as l_user
			then
				Result := l_user
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
