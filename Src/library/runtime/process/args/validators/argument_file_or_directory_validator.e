note
	description: "A command line switch file validator that checks if a directory or file exists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_FILE_OR_DIRECTORY_VALIDATOR

inherit
	ARGUMENT_VALUE_VALIDATOR

feature {NONE} -- Validation

	validate_value (a_value: READABLE_STRING_8)
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			if not retried then
				if not (create {RAW_FILE}.make_with_name (a_value)).exists then
					invalidate_option (e_file_or_directory_does_not_exist)
				end
			else
				invalidate_option (e_invalid_file_or_directory_name)
			end
		ensure then
			a_value_exists: is_option_valid implies (create {RAW_FILE}.make_with_name (a_value)).exists
		rescue
			retried := True
			retry
		end

feature {NONE} -- Internationalization

	e_invalid_file_or_directory_name: STRING = "The specified file or directory does not exist."
	e_file_or_directory_does_not_exist: STRING = "The specified file or directory does not exist."

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
