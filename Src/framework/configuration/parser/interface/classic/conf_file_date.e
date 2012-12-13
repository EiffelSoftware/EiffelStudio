note
	description: "Access to a file date."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_DATE

feature -- Access

	file_modified_date (a_path: READABLE_STRING_GENERAL): INTEGER
			-- Get last modified timestamp of `a_path'.
		require
			a_path_set: a_path /= Void and then not a_path.is_empty
		local
			f: RAW_FILE
		do
			create f.make_with_name (a_path)
			if f.exists then
				Result := f.date
			else
				Result := -1
			end
		ensure
			file_modified_date_valid: Result >= -1
		end

	file_path_modified_date (a_path: PATH): INTEGER
			-- Get last modified timestamp of `a_path'.
		require
			a_path_set: a_path /= Void and then not a_path.is_empty
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_path)
			if f.exists then
				Result := f.date
			else
				Result := -1
			end
		ensure
			file_modified_date_valid: Result >= -1
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
