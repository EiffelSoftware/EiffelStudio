indexing
	description: "Represents a user passed argument file or directory path"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_FILE_OR_DIRECTORY_OPTION

inherit
	ARGUMENT_OPTION

create {ARGUMENT_SWITCH}
	make,
	make_with_value

feature -- Status report

	is_file: BOOLEAN
			-- Indicates if `value' is a file
		require
			has_value: has_value
		local
			l_file: RAW_FILE
		do
			create l_file.make (value)
			if l_file.exists then
				Result := not l_file.is_directory and not l_file.is_device
			end
		ensure
			result_antipodal: not is_directory
		end

	is_directory: BOOLEAN
			-- Indicates if `value' is a file
		require
			has_value: has_value
		do
			Result := not is_file
		ensure
			result_antipodal: not is_file
		end

invariant
	value_exists: has_value implies (create {RAW_FILE}.make (value)).exists

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {ARGUMENT_PROPERTY_OPTION}
