note
	description: "[
		Is returned by {XS_WEBAPP_ACTION}.check_status if a certain file 
		does not exist or is not executable.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_STATUS_FILE_NOT_EXIST

inherit
	XSWA_STATUS
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING)
			-- Initialization for `Current'.
		require
			a_file_name_attached: a_file_name /= Void
		do
			file_name := a_file_name
		ensure
			a_file_name_set: a_file_name ~ file_name
		end

feature -- Access

	file_name: STRING

feature -- Status Report

	out: STRING
			-- Returns the error message
		do
			Result := file_name + " does not exist or is not executable."
		end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
